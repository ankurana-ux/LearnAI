import SwiftUI

struct LearningCollectionsSection: View {

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {

        VStack(alignment: .leading, spacing: 20) {

            HStack {

                AppSectionHeader(
                    title: "Collections",
                    icon: "square.grid.2x2.fill",
                    color: .green
                )

                Spacer()

//                Button("View All") {
//
//                }
                NavigationLink {

                    CollectionsView()

                } label: {

                    Text("View All")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.blue)

                }
                .buttonStyle(.plain)

            }

            LazyVGrid(
                columns: columns,
                spacing: 20
            ) {

                ForEach(LearningCollectionService.shared.collections) { collection in

                    NavigationLink {

                        CollectionDetailView(
                            collection: collection
                        )

                    } label: {

                        LearningCollectionCard(
                            collection: collection
                        )

                    }
                    .buttonStyle(.plain)

                }

            }

        }

    }

}

#Preview {

    LearningCollectionsSection()

}
