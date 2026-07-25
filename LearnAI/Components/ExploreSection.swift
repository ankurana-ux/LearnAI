import SwiftUI

struct ExploreSection<Content: View>: View {

    let title: String
    let systemImage: String
    @ViewBuilder let content: Content

    var body: some View {

        VStack(alignment: .leading, spacing: 16) {

            Label(title, systemImage: systemImage)
                .font(.title3.bold())
                .padding(.horizontal)

            content

        }

    }

}
