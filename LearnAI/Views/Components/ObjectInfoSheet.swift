import SwiftUI

struct ObjectInfoSheet: View {

    let object: DetectedObject
    let pixelBuffer: CVPixelBuffer?
    let aiInfo: AIObjectInfo?
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
    
    
    var body: some View {
        
        ScrollViewReader { proxy in
            
            ScrollView {
                
                VStack(alignment: .leading, spacing: 24) {
                    
                    // MARK: Handle
                    
                    ObjectHeaderView(object: object)
                    
                    // MARK: Summary
                    
                    QuickSummaryView(object: object)
                    
                    // MARK: Quick Facts
                    
                    QuickFactsView(facts: object.facts)
                    
                    // MARK: AI Information
                    
                    AIInformationView(
                        aiInfo: aiInfo,
                        object: object
                    )
                    
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
 
                    .buttonStyle(.borderedProminent)
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
            
            .task {
                await loadSuggestedQuestions()
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

//                    messages.append(
//                        ChatMessage(
//                            isUser: false,
//                            text: ""
//                        )
//                    )
                    
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
        pixelBuffer: nil,

        aiInfo: nil,
        isLoading: false,
        onLearnMore: {}

    )

}
