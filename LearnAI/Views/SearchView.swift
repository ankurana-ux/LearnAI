import SwiftUI

struct SearchView: View {

    @State private var query = ""
    @State private var aiInfo: AIObjectInfo?
    @State private var isLoading = false
    @State private var showSheet = false
    @State private var showError = false
    @State private var errorMessage = ""

    var body: some View {

        NavigationStack {

            VStack(spacing: 24) {

                TextField("Search anything...", text: $query)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)

                Button {

                    guard !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                        return
                    }

                    Task {

                        isLoading = true

                        defer {
                            Task { @MainActor in
                                isLoading = false
                            }
                        }

                        do {

                            let info = try await AIService.shared.fetchInfo(for: query)

                            await MainActor.run {
                                aiInfo = info
                                showSheet = true
                            }

                        } catch {

                            await MainActor.run {

                                let nsError = error as NSError

                                switch nsError.code {

                                case 429:
                                    errorMessage = "You've reached the AI request limit. Please wait about a minute and try again."

                                case 503:
                                    errorMessage = "The AI service is currently busy. Please try again in a few moments."

                                default:
                                    errorMessage = nsError.localizedDescription

                                }

                                showError = true

                            }

                        }

                    }

                } label: {

                    if isLoading {
                        ProgressView()
                    } else {
                        Text("Search")
                    }

                }
                .buttonStyle(.borderedProminent)
                .disabled(isLoading)

                Spacer()

            }
            .navigationTitle("Search")
            .sheet(isPresented: $showSheet) {

                if let info = aiInfo {
                    SearchResultSheet(info: info)
                }

            }
            .alert("Search Failed", isPresented: $showError) {

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
