import SwiftUI

struct TrendingSection: View {

    var body: some View {

        
        VStack(alignment: .leading, spacing: 16) {

            Text("Trending Today")
                .font(.title3.bold())

            HStack(spacing: 16) {

                ForEach(0..<3, id: \.self) { _ in

                    VStack(alignment: .leading) {

                        Image("tesla")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 18)
                            )

                        Text("Trending Object")
                            .font(.headline)

                    }

                }

            }

        }

    }

}

#Preview {
    TrendingSection()
}
