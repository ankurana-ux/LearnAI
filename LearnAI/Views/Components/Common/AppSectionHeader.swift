import SwiftUI

struct AppSectionHeader: View {

    let title: String
    let icon: String
    let color: Color

    var body: some View {

        Label(title.uppercased(), systemImage: icon)
            .font(.caption.weight(.bold))
            .foregroundStyle(color)

    }

}

#Preview {

    AppSectionHeader(
        title: "Daily Momentum",
        icon: "flame.fill",
        color: .orange
    )

}
