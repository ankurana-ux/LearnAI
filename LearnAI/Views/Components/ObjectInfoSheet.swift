import SwiftUI

struct ObjectInfoSheet: View {

    let object: DetectedObject
    let aiInfo: AIObjectInfo?
    let imageData: Data?
    let isLoading: Bool
    let onLearnMore: () -> Void
    @State private var question = ""
    @State private var messages: [ChatMessage] = []
    @State private var isAskingAI = false
    @State private var suggestedQuestions: [String] = []
    @State private var isLoadingQuestions = false
    @State private var lastObjectID: UUID?
    @State private var chatError: String?
    @State private var lastQuestion: String?
    @StateObject private var imageLoader = RemoteImageLoader()
    @State private var selectedTab = 0
    @State private var detailedMode = false
//    @Environment(\.dismiss) private var dismiss

    private let tabs = [
        "Summary",
        "History",
        "Uses",
        "Fun Facts",
        "Safety"
    ]
    
    
    var body: some View {
        
        ScrollViewReader { proxy in
            
            ScrollView {
                
                VStack(spacing: 0) {
                    
//                    HStack {
//
//                        Button {
//
//                            dismiss()
//
//                        } label: {
//
//                            HStack(spacing: 4) {
//
//                                Image(systemName: "chevron.left")
//                                    .font(.headline)
//
////                                Text("Detail")
////                                    .font(.headline)
//
//                            }
//                            .foregroundStyle(.primary)
//
//                        }
//
//                        Spacer()
//
//                        Text("Detail")
//                            .font(.title3.bold())
//
//                        Spacer()
//
//                        Button {
//
//                            // Share
//
//                        } label: {
//
//                            Image(systemName: "square.and.arrow.up")
//                                .font(.headline)
//                                .foregroundStyle(.primary)
//                                .frame(width: 32)
//
//                        }
//
//                    }
//                    .padding(.horizontal, 24)
//                    .padding(.top, 20)
//                    .padding(.bottom, 28)
                    
                    if let imageData,
                       let uiImage = UIImage(data: imageData) {
                        
                        Image(uiImage: uiImage)
                            .frame(height: 260)
                            .frame(maxWidth: .infinity)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 28)
                            )
                            .padding(.horizontal, 24)
                        
                    } else if let urlString = imageLoader.imageURL,
                              let url = URL(string: urlString) {
                        
                        AsyncImage(url: url) { image in
                            
                            image
                                .resizable()
                                .scaledToFill()
                            
                        } placeholder: {
                            
                            ProgressView()
                            
                        }
                        .frame(height: 260)
                        .frame(maxWidth: .infinity)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 28)
                        )
                        .padding(.horizontal, 24)
                        
                    } else {
                        
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 120)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.secondary)
                            .padding(.horizontal)
                        
                    }
                    
                    VStack(alignment: .leading, spacing: 24) {
                        
                        // MARK: Handle
                        
                        VStack(alignment: .leading, spacing: 8) {

                            Text(object.name)
                                .font(.system(size: 32, weight: .bold))

                            Text("Recent AI analysis of this object.")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)

                            Text(object.category)
                                .font(.subheadline.weight(.semibold))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(
                                    Color(
                                        red: 156 / 255,
                                        green: 163 / 255,
                                        blue: 175 / 255
                                    )
                                    .opacity(0.15)
                                )
                                .clipShape(Capsule())

                        }
                        .padding(.top, 20)
                        
                        VStack {

                            HStack(spacing: 12) {

                                Toggle("", isOn: $detailedMode)
                                    .labelsHidden()

                                Text("Explain in detail")
                                    .font(.headline)

                                Spacer()

                            }
                            .padding(.top, 12)
                            .padding(.bottom, 8)

                        }
//                        .background(
//                            Color(
//                                red: 246 / 255,
//                                green: 246 / 255,
//                                blue: 248 / 255
//                            )
//                        )
                        .clipShape(
                            RoundedRectangle(cornerRadius: 18)
                        )
                        
                        ScrollView(.horizontal, showsIndicators: false) {

                            HStack(spacing: 28) {

                                ForEach(tabs.indices, id: \.self) { index in

                                    Button {

                                        selectedTab = index

                                    } label: {

                                        VStack(spacing: 8) {

                                            Text(tabs[index])
                                                .font(.subheadline.weight(.semibold))
                                                .foregroundStyle(
                                                    selectedTab == index
                                                    ? .primary
                                                    : .secondary
                                                )

                                            Rectangle()
                                                .fill(
                                                    selectedTab == index
                                                    ? Color.black
                                                    : Color.clear
                                                )
                                                .frame(height: 2)

                                        }

                                    }
                                    .buttonStyle(.plain)

                                }

                            }
                            .padding(.vertical, 4)

                        }
                        .pickerStyle(.segmented)
                        
                        if let aiInfo {

                            VStack(alignment: .leading, spacing: 20) {

                                switch selectedTab {

                                case 0:

                                    QuickSummaryView(object: object)

                                case 1:

                                    AIInfoCard(
                                        title: "History",
                                        text: aiInfo.history
                                    )

                                case 2:

                                    AIInfoCard(
                                        title: "Uses",
                                        text: aiInfo.uses.joined(separator: "\n• ")
                                    )

                                case 3:

                                    AIInfoCard(
                                        title: "Fun Facts",
                                        text: aiInfo.funFacts.joined(separator: "\n• ")
                                    )

                                default:

                                    AIInfoCard(
                                        title: "Safety",
                                        text: aiInfo.safety
                                    )

                                }

                            }
                            .padding(.top, 8)

                        }
                        

                        VStack(alignment: .leading, spacing: 24) {

                            ChatSectionView(
                                messages: messages,
                                isAskingAI: isAskingAI
                            )

                            if let _ = chatError {

                                HStack {

                                    Image(systemName: "exclamationmark.triangle.fill")
                                        .foregroundStyle(.orange)

                                    Text("AI couldn't respond")

                                    Spacer()

                                    Button("Try Again") {

                                        guard let lastQuestion else { return }

                                        question = lastQuestion
                                        askQuestion()

                                    }
                                    .buttonStyle(.bordered)

                                }
                                .padding(.horizontal)

                            }

                            SuggestedQuestionsView(
                                questions: suggestedQuestions,
                                isLoading: isLoadingQuestions
                            ) { question in

                                self.question = question
                                askQuestion()

                            }

                            ChatInputView(
                                question: $question,
                                isLoading: isAskingAI,
                                onSend: askQuestion
                            )

                        }
                        .padding(20)
                        .background(
                            Color(
                                red: 246 / 255,
                                green: 246 / 255,
                                blue: 246 / 255
                            )
                        )
                        .clipShape(
                            RoundedRectangle(cornerRadius: 28)
                        )

                        LearnMoreButton(
                            aiInfo: aiInfo,
                            isLoading: isLoading
                        ) {
                            guard !isLoading else { return }
                            onLearnMore()
                        }
                        .padding(.top, 20)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)
                }
                .navigationTitle("Detail")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {

                    ToolbarItem(placement: .topBarTrailing) {

                        Button {

                            // Share

                        } label: {

                            Image(systemName: "square.and.arrow.up")
                        }

                    }

                }
            }
            .scrollDismissesKeyboard(.immediately)
            .task {
                await loadSuggestedQuestions()
            }
            
            .onAppear {

                guard imageData == nil else {
                    return
                }

                imageLoader.load(
                    topic: object.name
                )

            }
            
            .onChange(of: object.id) { _, newID in

                guard lastObjectID != newID else { return }

                lastObjectID = newID

                messages.removeAll()
                question = ""
                suggestedQuestions.removeAll()

                Task {
                    await loadSuggestedQuestions()
                }
            }
        }
    }
    

                private func loadSuggestedQuestions() async {

                    isLoadingQuestions = true

                    defer {
                        isLoadingQuestions = false
                    }

                    do {
                        suggestedQuestions = try await AIService.shared.generateSuggestedQuestions(
                            for: object.name
                        )
                    } catch {

                        print("❌ Failed to load suggested questions:", error)

                        suggestedQuestions = [
                            "Is it dangerous?",
                            "Interesting facts",
                            "Where is it found?",
                            "What does it eat?"
                        ]
                    }
                }
            
            private func askQuestion() {
                
                guard !question.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                    return
                }
                
                Task {
                    
                    let userQuestion = question.trimmingCharacters(in: .whitespacesAndNewlines)
                    lastQuestion = userQuestion
                    
                    guard !userQuestion.isEmpty else { return }
                    
                    messages.append(
                        ChatMessage(
                            isUser: true,
                            text: userQuestion
                        )
                    )
                    
                    question = ""
                    isAskingAI = true
                    chatError = nil
                    
                    do {
                        
                        let aiMessageID = UUID()

                        messages.append(
                            ChatMessage(
                                id: aiMessageID,
                                isUser: false,
                                text: ""
                            )
                        )

                        let prompt = GeminiPromptBuilder.streamingQuestionPrompt(
                            object: object,
                            question: userQuestion,
                            conversation: messages
                        )

                        try await AIService.shared.streamContent(
                            parts: [
                                [
                                    "text": prompt
                                ]
                            ]
                        ) { chunk in

                            Task { @MainActor in

                                if let index = messages.firstIndex(
                                    where: { $0.id == aiMessageID }
                                ) {
                                    messages[index].text += chunk
                                }

                            }

                        }
                        
                    } catch {
                        
                        chatError = error.localizedDescription

                        messages.append(
                            ChatMessage(
                                isUser: false,
                                text: "I couldn't get an answer right now."
                            )
                        )

                    }
                    
                    isAskingAI = false
                }
                
            }
    
        }


#Preview {

    ObjectInfoSheet(

        object: DetectedObject(

            name: "Snake Plant",
            category: "Indoor Plant",
            shortSummary: "Indoor plant that helps improve air quality.",
            detailedSummary: "Snake plants are hardy indoor plants known for improving air quality and thriving in low-light conditions.",
            confidence: 0.98,
            icon: "leaf.fill",

            facts: [

                ObjectFact(
                    icon: "drop.fill",
                    title: "Water",
                    value: "Every 2–3 weeks"
                ),

                ObjectFact(
                    icon: "sun.max.fill",
                    title: "Light",
                    value: "Bright indirect light"
                ),

                ObjectFact(
                    icon: "thermometer.medium",
                    title: "Difficulty",
                    value: "Easy"
                )

            ]

        ),

        aiInfo: nil,
        imageData: nil,
        isLoading: false,
        onLearnMore: { }

    )

}
