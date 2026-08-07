import SwiftUI

struct GuessObjectView: View {

    @Environment(\.dismiss) private var dismiss

    @State private var currentQuestion = 0
    @State private var selectedAnswer: Int?
    @State private var showResults = false
    @State private var correctAnswers = 0

    private let questions = QuestionService.shared.guessQuestions

    private var question: Question {
        questions[currentQuestion]
    }

    private let letters = ["A", "B", "C", "D"]

    var body: some View {

        NavigationStack {

            VStack(spacing: 28) {

                // MARK: Header

                HStack {

                    Button {

                        dismiss()

                    } label: {

                        Image(systemName: "xmark")
                            .font(.title3.weight(.semibold))
                            .foregroundStyle(.primary)

                    }

                    Text("Guess the Object")
                        .font(.title2.bold())

                    Spacer()

                }

                // MARK: Progress

                VStack(alignment: .leading, spacing: 10) {

                    HStack {

                        Text("Question \(currentQuestion + 1) of \(questions.count)")
                            .font(.subheadline.weight(.semibold))

                        Spacer()

                        Text("\(Int((Double(currentQuestion + 1) / Double(questions.count)) * 100))%")
                            .font(.caption)
                            .foregroundStyle(.secondary)

                    }

                    ProgressView(
                        value: Double(currentQuestion + 1),
                        total: Double(questions.count)
                    )
                    .tint(.blue)

                }

                // MARK: Question

                Text(question.title)
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                // MARK: Image

                Image(question.image ?? "guess_object")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 190)
                    .clipShape(RoundedRectangle(cornerRadius: 28))

                // MARK: Answers

                VStack(spacing: 16) {

                    ForEach(question.answers.indices, id: \.self) { index in

                        GuessAnswerOption(
                            letter: letters[index],
                            answer: question.answers[index],
                            isSelected: selectedAnswer == index
                        ) {

                            selectedAnswer = index

                        }

                    }

                }

                Spacer()

                // MARK: Button

                PrimaryButton(
                    title: currentQuestion == questions.count - 1
                        ? "Finish"
                        : "Next",
                    isEnabled: selectedAnswer != nil
                ) {

                    guard selectedAnswer != nil else { return }

                    if selectedAnswer == question.correctAnswer {

                        correctAnswers += 1

                    }

                    if currentQuestion < questions.count - 1 {

                        currentQuestion += 1
                        selectedAnswer = nil

                    } else {

                        showResults = true

                    }

                }

            }
            .padding(.horizontal, AppTheme.Spacing.large)
            .padding(.top, 20)
            .padding(.bottom, 30)
            .navigationBarHidden(true)
            

        }
        .fullScreenCover(isPresented: $showResults) {

            CongratulationsView(
                title: "Challenge Complete!",
                message: "You answered \(correctAnswers) out of \(questions.count) correctly.",
                xp: correctAnswers * 50,
                buttonTitle: "Continue"
            )

        }

    }

}

#Preview {

    GuessObjectView()

}
