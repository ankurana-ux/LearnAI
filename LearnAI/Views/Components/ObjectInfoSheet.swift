import SwiftUI

struct ObjectInfoSheet: View {

    let object: DetectedObject
    let aiInfo: AIObjectInfo?
    let isLoading: Bool
    let onLearnMore: () -> Void
    @State private var question = ""
    @State private var messages: [ChatMessage] = []
    @State private var isAskingAI = false
    
    var body: some View {
        
    ScrollViewReader { proxy in

        ScrollView {

            VStack(alignment: .leading, spacing: 24) {
                
                // MARK: Handle
                
                Capsule()
                    .fill(.secondary.opacity(0.4))
                    .frame(width: 42, height: 5)
                    .frame(maxWidth: .infinity)
                
                // MARK: Header
                
                HStack(alignment: .top) {
                    
                    Image(systemName: object.icon)
                        .font(.system(size: 42))
                        .foregroundStyle(.green)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        
                        Text(object.name)
                            .font(.largeTitle.bold())
                        
                        Text("AI identified this object with high confidence.")
                            .foregroundStyle(.secondary)
                        
                    }
                    
                    Spacer()
                    
                }
                
                Divider()
                
                ScrollView {
                    
                    LazyVStack(alignment: .leading, spacing: 18) {
                        
                        ForEach(messages) { message in
                            
                            HStack {

                                if message.isUser {

                                    Spacer(minLength: 50)

                                    VStack(alignment: .trailing, spacing: 4) {

                                        Text("You")
                                            .font(.caption2)
                                            .foregroundStyle(.secondary)

                                        Text(message.text)
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 12)
                                            .foregroundStyle(.white)
                                            .background(Color.accentColor)
                                            .clipShape(
                                                RoundedRectangle(cornerRadius: 18)
                                            )
                                    }

                                } else {

                                    VStack(alignment: .leading, spacing: 4) {

                                        HStack(spacing: 6) {

                                            Image(systemName: "sparkles")
                                                .foregroundStyle(.blue)

                                            Text("LearnAI")
                                                .font(.caption2)
                                                .foregroundStyle(.secondary)

                                        }

                                        Text(message.text)
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 12)
                                            .background(.ultraThinMaterial)
                                            .clipShape(
                                                RoundedRectangle(cornerRadius: 18)
                                            )

                                    }

                                    Spacer(minLength: 50)

                                }

                            }
                            .id(message.id)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                            
                        }
                        
                        if isAskingAI {
                            
                            HStack {

                                Image(systemName: "sparkles")
                                    .foregroundStyle(.blue)

                                ProgressView()

                                Text("LearnAI is thinking...")
                                    .foregroundStyle(.secondary)

                                Spacer()

                            }
                            .padding(.horizontal)
                            
                        }
                        
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                    
                }
                .frame(maxHeight: 250)
                .onChange(of: messages.count) { _, _ in

                    guard let last = messages.last else { return }

                    withAnimation {

                        proxy.scrollTo(last.id, anchor: .bottom)

                    }

                }
                
            }
                // MARK: Summary

                VStack(alignment: .leading, spacing: 10) {

                    Text("Quick Summary")
                        .font(.headline)

                    Text(object.detailedSummary)

                }

                // MARK: Quick Facts

                VStack(alignment: .leading, spacing: 16) {

                    Text("Quick Facts")
                        .font(.headline)

                    ForEach(object.facts) { fact in

                        factRow(
                            icon: fact.icon,
                            color: .accentColor,
                            title: fact.title,
                            value: fact.value
                        )

                    }

                }

                // MARK: AI Information

                if let aiInfo {

                    VStack(alignment: .leading, spacing: 20) {


                        Text("AI Information")
                            .font(.headline)

                        Text(aiInfo.summary)

                        Divider()

                        Text("History")
                            .font(.headline)

                        Text(aiInfo.history)

                        Divider()

                        Text("Uses")
                            .font(.headline)

                        ForEach(aiInfo.uses, id: \.self) { use in
                            Label(use, systemImage: "checkmark.circle.fill")
                        }

                        Divider()

                        Text("Fun Facts")
                            .font(.headline)

                        ForEach(aiInfo.funFacts, id: \.self) { fact in
                            Label(fact, systemImage: "sparkles")
                        }

                        Divider()

                        Text("Safety")
                            .font(.headline)

                        Text(aiInfo.safety)

                    }

                } else {

                    VStack(alignment: .leading, spacing: 10) {

                        Text("About")
                            .font(.headline)

                        Text(object.shortSummary)
                            .foregroundStyle(.secondary)

                    }

                }

                Divider()

                Text("Ask AI")
                    .font(.headline)

                HStack {

                    TextField(
                        "Ask a question...",
                        text: $question
                    )
                    .textFieldStyle(.roundedBorder)

                    Button("Send") {

                        guard !question.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                            return
                        }

                        Task {

                            let userQuestion = question.trimmingCharacters(in: .whitespacesAndNewlines)

                            guard !userQuestion.isEmpty else { return }

                            messages.append(
                                ChatMessage(
                                    isUser: true,
                                    text: userQuestion
                                )
                            )

                            question = ""
                            isAskingAI = true

                            do {

                                let reply = try await AIService.shared.askQuestion(
                                    about: object.name,
                                    question: userQuestion
                                )

                                messages.append(
                                    ChatMessage(
                                        isUser: false,
                                        text: reply
                                    )
                                )

                            } catch {

                                messages.append(
                                    ChatMessage(
                                        isUser: false,
                                        text: "Sorry, something went wrong."
                                    )
                                )

                            }

                            isAskingAI = false

                        }

                    }
                    .disabled(
                        question.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isAskingAI
                    )

                }
                
                // MARK: Learn More Button

                Button {

                    guard !isLoading else { return }
                    onLearnMore()

                } label: {

                    Group {

                        if isLoading {

                            ProgressView()

                        } else {

                            Label(
                                aiInfo == nil ? "Learn More with AI" : "AI Information Loaded",
                                systemImage: aiInfo == nil ? "sparkles" : "checkmark.circle.fill"
                            )


                        }

                    }
                    .frame(maxWidth: .infinity)

                }
                .font(.headline)
                .padding()
                .background(aiInfo == nil ? Color.blue : Color.green)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 18))
                .disabled(isLoading || aiInfo != nil)

            }
            .padding(24)

        }
        .presentationCornerRadius(30)

    }

    @ViewBuilder
    private func factRow(
        icon: String,
        color: Color,
        title: String,
        value: String
    ) -> some View {

        HStack(spacing: 14) {

            Image(systemName: icon)
                .foregroundStyle(color)
                .frame(width: 26)

            Text(title)

            Spacer()

            Text(value)
                .foregroundStyle(.secondary)

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
        isLoading: false,
        onLearnMore: {}

    )

}
