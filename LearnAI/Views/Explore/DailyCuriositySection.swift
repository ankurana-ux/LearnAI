import SwiftUI

struct DailyCuriositySection: View {

    var body: some View {

        AppCard(padding: 0) {

            VStack(spacing: 0) {

                Image("tesla")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .frame(height: 220)
                    .clipped()

                VStack(alignment: .leading, spacing: 10) {

                    AppSectionHeader(
                        title: "Daily Curiosity",
                        icon: "bolt.fill",
                        color: Color(
                            red: 156 / 255,
                            green: 163 / 255,
                            blue: 175 / 255
                        )
                    )

                    Text("The Secret of Orchid Pollination")
                        .font(.title3.bold())

                    Text("Recent AI analysis reveals that certain orchids use complex pheromonal signals that were previously unknown...")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    Button {

                    } label: {

                        Text("Learn More")
                            .font(.headline)

                    }

                }
                .padding(24)

            }

        }

    }

}

#Preview {
    DailyCuriositySection()
}
