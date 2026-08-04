import SwiftUI

struct RankingRow: View {

    let rank: Int
    let name: String
    let level: String
    let xp: String

    var body: some View {

        HStack(spacing: 16) {

            Text("#\(rank)")
                .font(.headline)
                .frame(width: 36)

            Circle()
                .fill(Color.gray.opacity(0.2))
                .frame(width: 52, height: 52)
                .overlay {

                    Image(systemName: "person.fill")
                        .foregroundStyle(.gray)

                }

            VStack(alignment: .leading, spacing: 4) {

                Text(name)
                    .font(.headline)

                Text(level)
                    .font(.caption)
                    .foregroundStyle(.secondary)

            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {

                Text("\(xp) LP")
                    .font(.headline)

                HStack(spacing: 4) {

                    Image(systemName: "flame.fill")
                        .font(.caption2)
                        .foregroundStyle(.orange)

                    Text("18")
                        .font(.caption)

                }

            }

        }
        .padding(.vertical, 12)

    }

}

#Preview {

    RankingRow(
        rank: 1,
        name: "Marcus Thorne",
        level: "Level 12",
        xp: "11,200"
    )

}
