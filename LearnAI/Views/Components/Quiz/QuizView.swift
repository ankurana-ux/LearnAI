import SwiftUI

struct QuizView: View {

    @Environment(\.dismiss) private var dismiss

    @State private var currentQuestion = 0
    @State private var selectedAnswer: Int?

    @State private var correctAnswers = 0
    @State private var showResults = false

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

                    }

                    Text("Daily Quiz")
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

                }

                // MARK: Question

                Text(question.title)
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)

                Spacer()

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

                PrimaryButton(
                    title: currentQuestion == questions.count - 1
                        ? "Finish Quiz"
                        : "Next",
                    isEnabled: selectedAnswer != nil
                ) {

                    guard let selectedAnswer else { return }

                    if selectedAnswer == question.correctAnswer {

                        correctAnswers += 1

                    }

                    if currentQuestion < questions.count - 1 {

                        currentQuestion += 1
                        self.selectedAnswer = nil

                    } else {

                        showResults = true

                    }

                }

            }
            .padding(AppTheme.Spacing.large)
            .navigationBarHidden(true)

        }
        .fullScreenCover(isPresented: $showResults) {

            CongratulationsView(
                title: "Quiz Complete!",
                message: "You answered \(correctAnswers) out of \(questions.count) correctly.",
                xp: correctAnswers * 100,
                buttonTitle: "Continue"
            )

        }

    }

}

#Preview {

    QuizView()

}
