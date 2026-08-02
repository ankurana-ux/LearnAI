import SwiftUI

struct RankingRow: View {

    let name: String
    let level: String
    let xp: String

    var body: some View {

        AppCard {

            HStack {

                Circle()
                    .frame(width: 45, height: 45)

                VStack(alignment: .leading) {

                    Text(name)
                        .font(.headline)

                    Text(level)
                        .font(.caption)
                        .foregroundStyle(.secondary)

                }

                Spacer()

                Text("\(xp) XP")
                    .font(.caption.bold())

            }

        }

    }

}
