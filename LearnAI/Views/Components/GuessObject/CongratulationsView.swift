import SwiftUI

struct CongratulationsView: View {

    @Environment(\.dismiss) private var dismiss

    let title: String
    let message: String
    let xp: Int
    let buttonTitle: String

    var body: some View {

        NavigationStack {

            VStack(spacing: 32) {

                Spacer()

                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 90))
                    .foregroundStyle(.green)

                VStack(spacing: 12) {

                    Text(title)
                        .font(.largeTitle.bold())

                    Text(message)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)

                }

                AppCard {

                    VStack(spacing: 12) {

                        Text("+\(xp)")
                            .font(.system(size: 42, weight: .bold))

                        Text("Learning Points Earned")
                            .foregroundStyle(.secondary)

                    }

                }

                Spacer()

                PrimaryButton(
                    title: buttonTitle
                ) {

                    dismiss()

                }

            }
            .padding(.horizontal, AppTheme.Spacing.large)
            .padding(.vertical, 30)
            .navigationBarHidden(true)

        }

    }

}

#Preview {

    CongratulationsView(
        title: "Congratulations!",
        message: "You guessed the correct answer.",
        xp: 150,
        buttonTitle: "Continue"
    )

}
