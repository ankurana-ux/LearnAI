import SwiftUI

struct RareFindsCard: View {

    var body: some View {

        AppCard {

            VStack(spacing: 24) {

                AppSectionHeader(
                    title: "Rare Finds",
                    icon: "diamond.fill",
                    color: Color(
                        red: 156 / 255,
                        green: 163 / 255,
                        blue: 175 / 255
                    )
                )

                Text("Find rare objects and earn points")
                    .font(.title3.bold())
                    .multilineTextAlignment(.center)

                // MARK: Stats Card

                HStack(spacing: 0) {

                    VStack(spacing: 6) {

                        Text("20/300")
                            .font(.system(size: 34, weight: .bold))

                        Text("SCANNED")
                            .font(.caption.bold())
                            .foregroundStyle(.secondary)

                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 120)
                    .background(Color.white)

                    VStack(spacing: 6) {

                        Text("+450")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundStyle(.white)

                        Text("XP POINTS")
                            .font(.caption.bold())
                            .foregroundStyle(.white)

                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 120)
                    .background(.orange)

                }
                .clipShape(
                    RoundedRectangle(cornerRadius: 24)
                )
                .shadow(
                    color: .black.opacity(0.08),
                    radius: 8,
                    y: 4
                )

                // MARK: Progress

                ProgressView(value: 20, total: 300)
                    .tint(.orange)

                Text("RARE FINDS TOTAL GAIN")
                    .font(.caption.bold())
                    .foregroundStyle(
                        Color(
                            red: 156 / 255,
                            green: 163 / 255,
                            blue: 175 / 255
                        )
                    )

                // MARK: Button

                Button {

                } label: {

                    Text("Let's Scan & Learn")
                        .font(.headline.weight(.semibold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(.blue)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 16)
                        )

                }

            }

        }

    }

}

#Preview {

    RareFindsCard()

}
