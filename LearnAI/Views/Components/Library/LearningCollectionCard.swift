import SwiftUI

struct LearningCollectionCard: View {

    var body: some View {

        AppCard {

            VStack(alignment: .leading, spacing: 18) {

                HStack(alignment: .top, spacing: 16) {

                    Image("botany")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)

                    VStack(alignment: .leading, spacing: 6) {

                        Text("Spring Flowers")
                            .font(.headline)

                        Text("Botany")
                            .font(.caption)
                            .foregroundStyle(.secondary)

                    }

                    Spacer()

                }

                ProgressView(value: 12, total: 18)
                    .tint(.green)

                HStack {

                    Text("12 / 18 Discoveries")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Spacer()

                    Text("67%")
                        .font(.caption.bold())

                }

                HStack(spacing: 8) {

                    Image("badge_1")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 28, height: 28)
                        .clipShape(Circle())

                    Image("badge_1")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 28, height: 28)
                        .clipShape(Circle())

                    Image("badge_1")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 28, height: 28)
                        .clipShape(Circle())

                    ZStack {

                        Circle()
                            .fill(Color.gray.opacity(0.15))
                            .frame(width: 28, height: 28)

                        Image(systemName: "plus")
                            .font(.caption2.bold())

                    }

                    Spacer()

                    Image(systemName: "chevron.right")
                        .foregroundStyle(.secondary)

                }

            }

        }

    }

}

#Preview {

    LearningCollectionCard()

}
