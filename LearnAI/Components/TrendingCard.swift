import SwiftUI

struct TrendingCard: View {

    let title: String
    let emoji: String

    var body: some View {

        VStack(spacing: 12) {

            Text(emoji)
                .font(.system(size: 42))

            Text(title)
                .font(.headline)

        }
        .frame(width: 120, height: 140)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 22))

    }

}

#Preview {

    TrendingCard(
        title: "Panda",
        emoji: "🐼"
    )

}
