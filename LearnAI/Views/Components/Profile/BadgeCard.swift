import SwiftUI

struct BadgeCard: View {

    let badge: Badge

    private var rarityColor: Color {

        switch badge.rarity {

        case .bronze:
            return Color(red: 181/255, green: 101/255, blue: 29/255)

        case .silver:
            return .gray

        case .gold:
            return .yellow

        case .diamond:
            return .blue

        }

    }

    private var rarityBackground: Color {

        rarityColor.opacity(0.15)

    }
    
    private var cardOpacity: Double {

        badge.isUnlocked ? 1.0 : 0.6

    }
    private var badgeImageOpacity: Double {

        badge.isUnlocked ? 1.0 : 0.45

    }

    private var badgeShadowColor: Color {

        switch badge.rarity {

        case .bronze:
            return Color(red: 181/255, green: 101/255, blue: 29/255)

        case .silver:
            return .gray

        case .gold:
            return .yellow

        case .diamond:
            return .blue

        }

    }
    
    var body: some View {

        AppCard {

            VStack(alignment: .leading, spacing: 18) {

                HStack(alignment: .top, spacing: 18) {

                    Image(badge.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 84, height: 84)
                        .opacity(badgeImageOpacity)
                        .shadow(
                            color: badge.isUnlocked
                                ? badgeShadowColor.opacity(0.35)
                                : .clear,
                            radius: 12
                        )

                    VStack(alignment: .leading, spacing: 8) {

                        HStack {

                            Text(String(format: "#%03d", badge.badgeNumber))
                                .font(.caption2.bold())
                                .foregroundStyle(.secondary)

                            Spacer()

                            Text(badge.rarity.rawValue.capitalized)
                                .font(.caption.bold())
                                .foregroundStyle(rarityColor)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(rarityBackground)
                                .clipShape(Capsule())
                        }

                        HStack {

                            Text(badge.title)
                                .font(.headline)

                            if badge.isUnlocked {

                                Image(systemName: "checkmark.seal.fill")
                                    .foregroundStyle(.green)
                                    .font(.subheadline)

                            }

                        }
                            

                        Text(badge.description)                            .font(.subheadline)
                            .foregroundStyle(.secondary)

                    }

                }

                ProgressView(
                    value: Double(badge.currentProgress),
                    total: Double(badge.requiredProgress)
                )
                    .tint(.orange)

                HStack {

                    Text("\(badge.currentProgress) / \(badge.requiredProgress) Completed")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Spacer()

                    Text("\(Int((Double(badge.currentProgress) / Double(badge.requiredProgress)) * 100))%")                        .font(.caption.bold())

                }

                Divider()

                HStack {

                    Label("+\(badge.reward) LP", systemImage: "star.fill")
                        .font(.caption.bold())
                        .foregroundStyle(.orange)

                    Spacer()

                    if badge.isUnlocked {

                        Label("Unlocked", systemImage: "checkmark.circle.fill")
                            .font(.caption)
                            .foregroundStyle(.green)

                    } else {

                        Image(systemName: "lock.fill")
                            .foregroundStyle(.secondary)

                    }

                }
                .opacity(cardOpacity)

            }

        }

    }

}

#Preview {

    BadgeCard(
        badge: BadgeService.shared.badges.first!
    )

}
