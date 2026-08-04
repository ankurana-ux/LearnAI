import SwiftUI

struct SearchView: View {
    @State private var query = ""
    @State private var submittedQuery = ""
    @State private var hasSubmittedSearch = false
    @FocusState private var isSearchFocused: Bool

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
                VStack(alignment: .leading, spacing: 12) {

                    Text("Search Real World")
                        .font(.largeTitle.bold())

                    Text("Knowledge")
                        .font(.largeTitle.bold())

                    Text("Find objects in your library or trigger AI to research any item instantly.")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                        .padding(.top, 4)

                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 12)
                
                HStack(spacing: 12) {

                    HStack(spacing: 12) {

                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.secondary)

                        TextField(
                            "Search anything here...",
                            text: $query
                        )
                        .focused($isSearchFocused)
                        .submitLabel(.search)
                        .onSubmit {

                            submittedQuery = query.trimmingCharacters(
                                in: .whitespacesAndNewlines
                            )

                            hasSubmittedSearch = true

                        }

                    }
                    .padding(.horizontal, 18)
                    .frame(height: 64)
                    .background(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray.opacity(0.18), lineWidth: 1)
                    )

                    if isSearchFocused {

                        Button("Cancel") {

                            query = ""
                            submittedQuery = ""
                            hasSubmittedSearch = false
                            isSearchFocused = false

                        }
                        .transition(.move(edge: .trailing).combined(with: .opacity))

                    }

                }
                .padding(.horizontal)
                .animation(.easeInOut(duration: 0.2), value: isSearchFocused)
                
                if query.isEmpty {

                    ScrollView {

                        VStack(alignment: .leading, spacing: 28) {

                            VStack(alignment: .leading, spacing: 12) {

                                AppCard {

                                    VStack(alignment: .leading, spacing: 18) {

                                        AppSectionHeader(
                                            title: "Recent Searches",
                                            icon: "clock.arrow.circlepath",
                                            color: .blue
                                        )

                                        ForEach(history.recentSearches.prefix(5), id: \.self) { search in

                                            HStack {

                                                Image(systemName: "clock")
                                                    .foregroundStyle(.secondary)

                                                Text(search)
                                                    .font(.body)

                                                Spacer()

                                                Image(systemName: "arrow.up.left")
                                                    .font(.caption)
                                                    .foregroundStyle(.secondary)

                                            }

                                            if search != history.recentSearches.prefix(5).last {

                                                Divider()

                                            }

                                        }

                                    }

                                }
                                .padding(.horizontal)

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
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .navigationBar)
            
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
