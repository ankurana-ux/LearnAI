import SwiftUI

struct LearningCollectionsSection: View {

    var body: some View {

        VStack(alignment: .leading, spacing: 20) {

            HStack {

                AppSectionHeader(
                    title: "Collections",
                    icon: "square.grid.2x2.fill",
                    color: .green
                )

                Spacer()

                Button("View All") {

                }
                .font(.subheadline.weight(.semibold))

            }

            LearningCollectionCard()

            LearningCollectionCard()

            LearningCollectionCard()

        }

    }

}

#Preview {

    LearningCollectionsSection()

}
