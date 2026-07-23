import SwiftUI

struct ExploreCategory: Identifiable {

    let id = UUID()
    let title: String
    let icon: String
    let color: Color

}

struct ExploreView: View {

    let categories = [

        ExploreCategory(title: "Animals", icon: "pawprint.fill", color: .orange),
        ExploreCategory(title: "Plants", icon: "leaf.fill", color: .green),
        ExploreCategory(title: "Technology", icon: "laptopcomputer", color: .blue),
        ExploreCategory(title: "Food", icon: "fork.knife", color: .red),
        ExploreCategory(title: "Vehicles", icon: "car.fill", color: .purple),
        ExploreCategory(title: "Space", icon: "sparkles", color: .indigo)

    ]

    let columns = [

        GridItem(.flexible()),
        GridItem(.flexible())

    ]

    var body: some View {

        NavigationStack {

            ScrollView {

                LazyVGrid(columns: columns, spacing: 18) {

                    ForEach(categories) { category in

                        RoundedRectangle(cornerRadius: 22)
                            .fill(category.color.opacity(0.15))
                            .frame(height: 160)
                            .overlay {

                                VStack(spacing: 16) {

                                    Image(systemName: category.icon)
                                        .font(.system(size: 38))

                                    Text(category.title)
                                        .font(.headline)

                                }

                            }

                    }

                }
                .padding()

            }
            .navigationTitle("Explore")

        }

    }

}

#Preview {
    ExploreView()
}
