import SwiftUI

struct CollectionsView: View {

    @State private var selectedCategory = "Botany"

    private let categories = [
        "Botany",
        "Technology",
        "Marine",
        "Birds",
        "Mammals"
    ]

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(alignment: .leading, spacing: 24) {

                    ScrollView(.horizontal, showsIndicators: false) {

                        HStack(spacing: 24) {

                            ForEach(categories, id: \.self) { category in

                                Button {

                                    selectedCategory = category

                                } label: {

                                    VStack(spacing: 8) {

                                        Text(category)
                                            .font(.headline)
                                            .foregroundStyle(
                                                selectedCategory == category
                                                ? .primary
                                                : .secondary
                                            )

                                        Rectangle()
                                            .fill(
                                                selectedCategory == category
                                                ? .black
                                                : .clear
                                            )
                                            .frame(height: 2)

                                    }

                                }
                                .buttonStyle(.plain)

                            }

                        }

                    }

                    LazyVGrid(columns: columns, spacing: 20) {

                        ForEach(LearningCollectionService.shared.collections) { collection in

                            NavigationLink {

                                CollectionDetailView(collection: collection)

                            } label: {

                                LearningCollectionCard(
                                    collection: collection
                                )

                            }
                            .buttonStyle(.plain)

                        }

                    }

                }
                .padding(24)

            }
            .navigationTitle("Categories")
            .navigationBarTitleDisplayMode(.inline)

        }

    }

}

#Preview {

    CollectionsView()

}
