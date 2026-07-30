import SwiftUI

struct SearchView: View {
    @State private var query = ""
    @State private var submittedQuery = ""
    @State private var recentSearches: [String] = []
    @State private var hasSubmittedSearch = false

    private let suggestions = [
        "Why is the sky blue?",
        "How do airplanes fly?",
        "What is a black hole?",
        "Why do leaves change colour?",
        "How do bees make honey?",
        "Why do cats purr?"
    ]
    @State private var aiInfo: AIObjectInfo?
    @State private var imageData: Data?
    @State private var isLoading = false
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var selectedObject: DetectedObject?
    @StateObject private var history = HistoryService.shared
    
    var filteredHistory: [ScanHistory] {
        if query.isEmpty {
            return []
        }
        return history.history.filter {
            $0.name.localizedCaseInsensitiveContains(query)
        }

    }
    

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                TextField(
                    "Ask anything...",
                    text: $query
                )
                .submitLabel(.search)
                .onSubmit {

                    submittedQuery = query.trimmingCharacters(
                        in: .whitespacesAndNewlines
                    )

                    hasSubmittedSearch = true
                }
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                
                if query.isEmpty {

                    ScrollView {

                        VStack(alignment: .leading, spacing: 28) {

                            VStack(alignment: .leading, spacing: 12) {

                                Label("Recent Searches", systemImage: "clock")

                                ForEach(recentSearches, id: \.self) { item in

                                    Button {

                                        query = item
                                        submittedQuery = item
                                        
                                    } label: {

                                        HStack {

                                            Image(systemName: "clock.arrow.circlepath")

                                            Text(item)

                                            Spacer()

                                        }

                                    }
                                    .buttonStyle(.plain)

                                }

                            }

                            VStack(alignment: .leading, spacing: 12) {

                                Label("Suggested Questions", systemImage: "sparkles")

                                ForEach(suggestions, id: \.self) { question in

                                    Button {

                                        query = question
                                        submittedQuery = question
                                        
                                    } label: {

                                        HStack(alignment: .top) {

                                            Image(systemName: "sparkles")

                                            Text(question)

                                            Spacer()

                                        }

                                    }
                                    .buttonStyle(.plain)

                                }

                            }

                        }
                        .padding()

                    }

                } else if hasSubmittedSearch && filteredHistory.isEmpty {
                    
                    ProgressView("Searching with AI...")
                    
                        .task(id: submittedQuery)  {

                            guard selectedObject == nil else { return }

                            isLoading = true

                            defer {

                                Task { @MainActor in
                                    isLoading = false
                                }

                            }

                            do {

                                let info = try await AIService.shared.fetchInfo(
                                    for: submittedQuery
                                )
                                
//                                var imageData: Data?

                                if let imageURL = try? await ImageService.shared.fetchImageURL(
                                    for: info.name
                                ),
                                let url = URL(string: imageURL) {

                                    do {

                                        let (data, _) = try await URLSession.shared.data(
                                            from: url
                                        )

                                        imageData = data

                                    } catch {

                                        print("❌ Failed to download image:", error.localizedDescription)

                                    }

                                }

                                await MainActor.run {
                                    aiInfo = info

                                    HistoryService.shared.addRecentSearch(submittedQuery)
                                    HistoryService.shared.saveAIResult(
                                        info,
                                        imageData: imageData
                                    )

                                    selectedObject = DetectedObject(
                                        name: info.name,
                                        category: "AI Search",
                                        shortSummary: info.summary,
                                        detailedSummary: info.history,
                                        confidence: 1.0,
                                        icon: "sparkles",
                                        facts: []
                                    )

                                }

                            } catch {

                                await MainActor.run {

                                    errorMessage = error.localizedDescription
                                    showError = true

                                }

                            }

                        }

                } else {
                    List {
                        ForEach(filteredHistory) { item in
                            Button {
                                aiInfo = HistoryService.shared.aiInfo(for: item.id)
                                selectedObject = DetectedObject(
                                    name: item.name,
                                    category: "Object",
                                    shortSummary: "",
                                    detailedSummary: "",
                                    confidence: item.confidence,
                                    icon: "camera.viewfinder",
                                    facts: []
                                )
                            } label: {
                                HStack(spacing: 12) {
                                    if let data = item.imageData,
                                       let image = UIImage(data: data) {
                                        Image(uiImage: image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 60, height: 60)
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                    }
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(item.name)
                                            .font(.headline)
                                        Text(item.date, style: .date)
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Discover")
            .onAppear {

                recentSearches = HistoryService.shared.recentSearches

            }
            .sheet(item: $selectedObject, onDismiss: {

                selectedObject = nil
                aiInfo = nil
                imageData = nil

            }) { object in

                ObjectInfoSheet(
                    object: object,
                    aiInfo: aiInfo,
                    imageData: imageData,
                    isLoading: false,
                    onLearnMore: { }
                )

            }.alert("Search Failed", isPresented: $showError) {
                
                Button("OK", role: .cancel) { }

            } message: {

                Text(errorMessage)

            }
        }
    }
}
#Preview {
    SearchView()
}
