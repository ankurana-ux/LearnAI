import SwiftUI

struct CategoryCard: View {

    let category: ExploreCategory

    var body: some View {

        RoundedRectangle(cornerRadius: 22)
            .fill(category.color.opacity(0.15))
            .frame(height: 160)
            .overlay {

                VStack(spacing: 16) {

                    Image(systemName: category.icon)
                        .font(.system(size: 38))
                        .foregroundStyle(category.color)

                    Text(category.title)
                        .font(.headline)

                }

            }

    }

}
