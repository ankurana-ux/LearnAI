import SwiftUI

struct AppCard<Content: View>: View {

    let padding: CGFloat

    @ViewBuilder var content: Content

    init(
        padding: CGFloat = AppTheme.Spacing.large,
        @ViewBuilder content: () -> Content
    ) {
        self.padding = padding
        self.content = content()
    }

    var body: some View {

        content
            .padding(padding)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: AppTheme.Radius.card
                )
            )
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
