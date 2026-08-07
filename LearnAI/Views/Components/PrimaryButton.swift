import SwiftUI

struct PrimaryButton: View {

    let title: String

    var isEnabled: Bool = true

    let action: () -> Void

    var body: some View {

        Button(action: action) {

            Text(title)
                .font(.headline)
                .foregroundStyle(
                    isEnabled ? .white : Color.gray.opacity(0.8)
                )
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    isEnabled ? Color.blue : Color.gray.opacity(0.4)
                )
                .clipShape(RoundedRectangle(cornerRadius: 16))

        }
        .buttonStyle(.plain)
        .disabled(!isEnabled)
        .opacity(isEnabled ? 1 : 0.6)

    }

}

#Preview {

    VStack(spacing: 20) {

        PrimaryButton(
            title: "Continue"
        ) {

        }

        PrimaryButton(
            title: "Disabled",
            isEnabled: false
        ) {

        }

    }
    .padding()

}
