import SwiftUI

struct AIStatusIndicator: View {

    @State private var pulse = false

    var body: some View {

        HStack(spacing: 8) {

            Circle()
                .fill(.green)
                .frame(width: 10, height: 10)
                .scaleEffect(pulse ? 1.4 : 1)
                .animation(
                    .easeInOut(duration: 1)
                    .repeatForever(autoreverses: true),
                    value: pulse
                )

            Text("AI Active")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.white)

        }
        .padding(.horizontal, 14)
        .padding(.vertical, 8)
        .background(.ultraThinMaterial)
        .clipShape(Capsule())
        .onAppear {
            pulse = true
        }

    }
}

#Preview {
    ZStack {
        Color.black
        AIStatusIndicator()
    }
}
