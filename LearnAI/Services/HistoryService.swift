import Foundation
import Combine
import UIKit
import CoreImage
@MainActor
final class HistoryService: ObservableObject {

    static let shared = HistoryService()

    @Published private(set) var history: [ScanHistory] = []

    private let key = "scan_history"
    private let context = CIContext()

    private init() {
        load()
    }
    
    func toggleFavorite(for id: UUID) {
        guard let index = history.firstIndex(where: { $0.id == id }) else {
            return
        }
        history[index].isFavorite.toggle()
        persist()
    }
    
    func delete(_ item: ScanHistory) {
        history.removeAll { $0.id == item.id }
        persist()
    }
    
    func saveAIInfo(for id: UUID, info: AIObjectInfo) {
        guard let index = history.firstIndex(where: { $0.id == id }) else {
            return
        }

        history[index].aiInfo = StoredAIInfo(
            summary: info.summary,
            history: info.history,
            uses: info.uses,
            funFacts: info.funFacts,
            safety: info.safety
        )


        persist()

    }
    
    func aiInfo(for id: UUID) -> AIObjectInfo? {

        guard
            let item = history.first(where: { $0.id == id }),
            let stored = item.aiInfo
        else {
            
            return nil
        }

        return AIObjectInfo(
            name: item.name,
            summary: stored.summary,
            history: stored.history,
            uses: stored.uses,
            funFacts: stored.funFacts,
            safety: stored.safety
        )

    }
    
    func loadAIInfo(for id: UUID) async {

        guard let index = history.firstIndex(where: { $0.id == id }) else {
            return
        }

        guard history[index].aiInfo == nil else {
            return
        }

        do {

            let info = try await AIService.shared.fetchInfo(for: history[index].name)

            saveAIInfo(for: id, info: info)

        } catch {

            print(error)

        }

    }
    func save(object: DetectedObject, pixelBuffer: CVPixelBuffer) -> UUID {

        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        var imageData: Data?
        if let cgImage = context.createCGImage(ciImage, from: ciImage.extent) {
            let image = UIImage(cgImage: cgImage)
            imageData = image.jpegData(compressionQuality: 0.6)
        }
        let item = ScanHistory(
            name: object.name,
            confidence: object.confidence,
            date: Date(),
            isFavorite: false,
            imageData: imageData
        )
        history.removeAll {
            $0.name == item.name
        }

        history.insert(item, at: 0)
//        print("Thumbnail saved:", imageData?.count ?? 0, "bytes")
      persist()
        return item.id
    }
    
    func renameObject(
        id: UUID,
        to newName: String
    ) {

        guard let index = history.firstIndex(where: { $0.id == id }) else {
            return
        }

        history[index] = ScanHistory(
            id: history[index].id,
            name: newName,
            confidence: history[index].confidence,
            date: history[index].date,
            isFavorite: history[index].isFavorite,
            imageData: history[index].imageData,
            aiInfo: history[index].aiInfo
        )

        persist()
    }

    private func persist() {

        guard let data = try? JSONEncoder().encode(history) else {
            return
        }

        UserDefaults.standard.set(data, forKey: key)

    }

    private func load() {

        guard
            let data = UserDefaults.standard.data(forKey: key),
            let items = try? JSONDecoder().decode([ScanHistory].self, from: data)
        else {
            return
        }

        history = items

    }
    
    func saveSearch(_ query: String) {

        let cleanQuery = query.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !cleanQuery.isEmpty else {
            return
        }

        UserDefaults.standard.set(
            cleanQuery,
            forKey: "last_search"
        )

    }
    
    var recentSearches: [String] {

        UserDefaults.standard
            .stringArray(
                forKey: "recent_searches"
            ) ?? []

    }
    
    func addRecentSearch(_ query: String) {

        let cleanQuery = query.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !cleanQuery.isEmpty else {
            return
        }


        var searches = recentSearches


        searches.removeAll {
            $0.lowercased() == cleanQuery.lowercased()
        }


        searches.insert(
            cleanQuery,
            at: 0
        )


        if searches.count > 10 {

            searches = Array(
                searches.prefix(10)
            )

        }


        UserDefaults.standard.set(
            searches,
            forKey: "recent_searches"
        )

    }

    func saveAIResult(
        _ info: AIObjectInfo,
        imageData: Data?
    ) {

        let item = ScanHistory(
            name: info.name,
            confidence: 1.0,
            date: Date(),
            isFavorite: false,
            imageData: imageData,
            aiInfo: StoredAIInfo(
                summary: info.summary,
                history: info.history,
                uses: info.uses,
                funFacts: info.funFacts,
                safety: info.safety
            )
        )

        history.removeAll {
            $0.name.lowercased() == info.name.lowercased()
        }

        history.insert(
            item,
            at: 0
        )

        persist()

    }
}
    
