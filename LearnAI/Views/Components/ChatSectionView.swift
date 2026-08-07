import SwiftUI

struct ChatSectionView: View {

    let messages: [ChatMessage]
    let isAskingAI: Bool

    var body: some View {

        VStack(alignment: .leading, spacing: 16) {

            Text("CONVERSATION")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
                .tracking(1)

            ScrollViewReader { proxy in

                ScrollView {

                    LazyVStack(alignment: .leading, spacing: 16) {

                        ForEach(messages) { message in

                            HStack {

                                if message.isUser {

                                    Spacer(minLength: 50)

                                    VStack(alignment: .trailing, spacing: 6) {

                                        Text("YOU")
                                            .font(.caption2.weight(.semibold))
                                            .foregroundStyle(.secondary)
                                            .tracking(1)

                                        if message.text.isEmpty {

                                            HStack(spacing: 4) {

                                                Circle()
                                                    .frame(width: 6, height: 6)

                                                Circle()
                                                    .frame(width: 6, height: 6)

                                                Circle()
                                                    .frame(width: 6, height: 6)

                                            }
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 14)
                                            .background(.white)
                                            .clipShape(
                                                RoundedRectangle(cornerRadius: 22)
                                            )

                                        } else {

                                            MarkdownText(text: message.text)
                                                .padding(.horizontal, 16)
                                                .padding(.vertical, 12)
                                                .background(.white)
                                                .clipShape(
                                                    RoundedRectangle(cornerRadius: 22)
                                                )

                                        }

                                    }

                                } else {

                                    VStack(alignment: .leading, spacing: 6) {

                                        HStack(spacing: 6) {

                                            Image(systemName: "sparkles")
                                                .foregroundStyle(.blue)

                                            Text("LEARNAI")
                                                .font(.caption2.weight(.semibold))
                                                .foregroundStyle(.secondary)
                                                .tracking(1)

                                        }

                                        MarkdownText(text: message.text)
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 12)
                                            .background(
                                                Color(
                                                    red: 207 / 255,
                                                    green: 226 / 255,
                                                    blue: 243 / 255
                                                )
                                            )
                                            .clipShape(
                                                RoundedRectangle(cornerRadius: 22)
                                            )

                                    }

                                    Spacer(minLength: 50)

                                }

                            }
                            .id(message.id)
                            .transition(
                                .move(edge: .bottom)
                                .combined(with: .opacity)
                            )

                        }

                    }
                    .padding(.horizontal)
                    .padding(.vertical, 12)

                }
                .frame(maxHeight: 250)
                .background(
                    Color(
                        red: 246 / 255,
                        green: 246 / 255,
                        blue: 246 / 255
                    )
                )
                .clipShape(
                    RoundedRectangle(cornerRadius: 24)
                )
                .onChange(of: messages.count) { _, _ in

                    guard let last = messages.last else { return }

                    withAnimation {

                        proxy.scrollTo(last.id, anchor: .bottom)

                    }

                }

            }

        }

    }

}
