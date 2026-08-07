import SwiftUI

struct FunFactCard: View {

    var body: some View {

        AppCard {

            VStack(alignment: .leading, spacing: 10) {

                HStack(alignment: .top) {

                    AppSectionHeader(
                        title: "Fun Fact",
                        icon: "sparkles",
                        color: Color(
                            red: 156 / 255,
                            green: 163 / 255,
                            blue: 175 / 255
                        )
                    )

                    Spacer()

                    Text("+1 LP")
                        .font(.caption.bold())
                        .foregroundStyle(.orange)

                }

                Text("Did you know the all electronic items have gold in them.")
                    .font(.title3.bold())

                Text("Was this information fun?")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                HStack(spacing: 14) {

                    Button("Yes") {

                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.green.opacity(0.18))
                    .foregroundStyle(.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 18))

                    Button("No") {

                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.red.opacity(0.16))
                    .foregroundStyle(.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 18))

                }

            }

        }

    }

}

#Preview {

    FunFactCard()

}
