import SwiftUI

struct ChatSectionView: View {

    let messages: [ChatMessage]
    let isAskingAI: Bool

    var body: some View {

        Divider()

        ScrollViewReader { proxy in

            ScrollView {

                LazyVStack(alignment: .leading, spacing: 16) {

                    ForEach(messages) { message in

                        HStack {

                            if message.isUser {

                                Spacer(minLength: 50)

                                VStack(alignment: .trailing, spacing: 4) {

                                    Text("You")
                                        .font(.caption2)
                                        .foregroundStyle(.secondary)

                                    MarkdownText(text: message.text)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 12)
                                        .foregroundStyle(.white)
                                        .background(Color.accentColor)
                                        .clipShape(
                                            RoundedRectangle(cornerRadius: 22)
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

                                    MarkdownText(text: message.text)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 12)
                                        .background(.ultraThinMaterial)
                                        .clipShape(
                                            RoundedRectangle(cornerRadius: 22)
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

    }

}
