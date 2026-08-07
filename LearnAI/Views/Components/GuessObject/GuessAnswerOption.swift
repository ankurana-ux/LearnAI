import SwiftUI

struct GuessAnswerOption: View {

    let letter: String
    let answer: String

    let isSelected: Bool

    let action: () -> Void

    var body: some View {

        Button(action: action) {

            HStack(spacing: 18) {

                Text(letter)
                    .font(.headline.weight(.bold))
                    .frame(width: 36, height: 36)
                    .background(
                        isSelected ? Color.black : Color(.systemGray6)
                    )
                    .foregroundStyle(
                        isSelected ? .white : .primary
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                Text(answer)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.leading)

                Spacer()

            }
            .padding(18)
            .background(.white)
            .overlay {

                RoundedRectangle(cornerRadius: 18)
                    .stroke(
                        isSelected ? .black : Color.gray.opacity(0.15),
                        lineWidth: isSelected ? 2 : 1
                    )

            }
            .clipShape(RoundedRectangle(cornerRadius: 18))

        }
        .buttonStyle(.plain)

    }

}

#Preview {

    VStack(spacing: 16) {

        GuessAnswerOption(
            letter: "A",
            answer: "Iridescent petal colors",
            isSelected: false
        ) {

        }

        GuessAnswerOption(
            letter: "B",
            answer: "Complex pheromonal signals",
            isSelected: true
        ) {

        }

    }
    .padding()

}
