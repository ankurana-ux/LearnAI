import SwiftUI

struct BadgeProgressCard: View {

    var body: some View {

        AppCard {

            VStack(alignment: .leading, spacing: 10) {

                HStack(alignment: .top, spacing: 18) {

                    Image("badge_unavailable")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 82, height: 82)

                    VStack(alignment: .leading, spacing: 8) {

                        HStack(alignment: .top) {

                            Text("EXPLORER")
                                .font(.caption.bold())
                                .foregroundStyle(
                                    Color(
                                        red: 156 / 255,
                                        green: 163 / 255,
                                        blue: 175 / 255
                                    )
                                )

                            Spacer()

                            Text("SILVER")
                                .font(.caption.bold())
                                .foregroundStyle(
                                    Color(
                                        red: 156 / 255,
                                        green: 163 / 255,
                                        blue: 175 / 255
                                    )
                                )
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(Color.gray.opacity(0.08))
                                .clipShape(Capsule())

                        }

                        Text("Scan 5 Currencies")
                            .font(.title3.bold())
                            .lineLimit(1)

                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                }

                Text("Scan 3 more currencies to get this badge.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                HStack {

                    Text("2 / 5")
                        .font(.caption.bold())
                        .foregroundStyle(.secondary)

                    Spacer()

                    Text("+20 LP")
                        .font(.caption.bold())
                        .foregroundStyle(.orange)

                }

                ProgressView(value: 0.4)
                    .tint(.blue)

            }

        }

    }

}

#Preview {

    BadgeProgressCard()

}
