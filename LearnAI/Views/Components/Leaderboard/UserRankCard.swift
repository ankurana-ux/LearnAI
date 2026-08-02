import SwiftUI

struct UserRankCard: View {

    var body: some View {

        AppCard {

            HStack {

                Circle()
                    .frame(width: 50, height: 50)

                VStack(alignment: .leading) {

                    Text("Curiosity Spark")
                        .font(.headline)

                    Text("Level 1 Explorer")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                }

                Spacer()

                VStack(alignment: .trailing) {

                    Text("180 XP")
                        .bold()

                    Text("Top 12%")
                        .font(.caption)

                }

            }

        }

    }

}
