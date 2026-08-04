import SwiftUI

struct BadgeTabView: View {
    
    @State private var selectedFilter = "All Badges"
    private var filteredBadges: [Badge] {

        switch selectedFilter {

        case "Unlocked":
            return BadgeService.shared.badges.filter(\.isUnlocked)

        case "In Progress":
            return BadgeService.shared.badges.filter { !$0.isUnlocked }

        case "Bronze":
            return BadgeService.shared.badges.filter { $0.rarity == .bronze }

        case "Silver":
            return BadgeService.shared.badges.filter { $0.rarity == .silver }

        case "Gold":
            return BadgeService.shared.badges.filter { $0.rarity == .gold }

        case "Diamond":
            return BadgeService.shared.badges.filter { $0.rarity == .diamond }

        default:
            return BadgeService.shared.badges

        }

    }
    var body: some View {

        VStack(spacing: 24) {

            AchievementCard()

            BadgeFilterTabs(
                selectedFilter: $selectedFilter
            )
            
            LazyVStack(spacing: 16) {

                ForEach(filteredBadges) { badge in

                    BadgeCard(
                        badge: badge
                    )

                }

            }

            VStack(alignment: .leading, spacing: 16) {

                Text("Themed Discovery Collections")
                    .font(.title3.bold())

                CollectionCard()

                CollectionCard()

                CollectionCard()

            }

        }

    }

}

#Preview {

    BadgeTabView()

}
