import SwiftUI

struct AppCard<Content: View>: View {

    @ViewBuilder var content: Content

    var body: some View {

        content
            .padding(AppTheme.Spacing.large)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: AppTheme.Radius.card
                )            )
            .shadow(
                color: .black.opacity(AppTheme.Shadow.opacity),
                radius: AppTheme.Shadow.radius,
                x: 0,
                y: 6
            )

    }

}

#Preview {

    AppCard {

        Text("LearnAI")

    }

}
