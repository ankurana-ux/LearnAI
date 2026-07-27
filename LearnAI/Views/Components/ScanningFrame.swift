import SwiftUI

struct ScanningFrame: View {

    @State private var animate = false

    private let frameSize: CGFloat = 260
    private let lineHeight: CGFloat = 3

    var body: some View {

        RoundedRectangle(cornerRadius: 24)
            .stroke(.white.opacity(0.9), lineWidth: 3)
            .frame(width: frameSize, height: frameSize)
            .overlay {
                Rectangle()
                    .fill(.green)
                    .frame(width: frameSize - 6, height: lineHeight)
                    .offset(y: animate ? frameSize / 2 - lineHeight : -(frameSize / 2))
            }
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .onAppear {
                withAnimation(
                    .linear(duration: 2)
                    .repeatForever(autoreverses: false)
                ) {
                    animate = true
                }
            }

    }
}

#Preview {
    ZStack {
        Color.black
        ScanningFrame()
    }
}
