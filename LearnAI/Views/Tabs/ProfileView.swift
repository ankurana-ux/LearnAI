import SwiftUI

struct ProfileView: View {

    @State private var selectedTab: ProfileSection = .progress

    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(spacing: 0) {

                    // MARK: Header Section

                    VStack(spacing: AppTheme.Spacing.section) {

                        ProfileHeader()

                        XPProgressCard()

                        LeaderboardCard()

                        ProfileTabs(
                            selectedTab: $selectedTab
                        )

                    }
                    .padding(.horizontal, AppTheme.Spacing.large)
                    .padding(.top, 24)
                    .padding(.bottom, 24)
                    .background(
                        Color(
                            red: 251 / 255,
                            green: 251 / 255,
                            blue: 251 / 255
                        )
                    )

                    // MARK: Content Section

                    VStack(spacing: AppTheme.Spacing.section) {

                        if selectedTab == .progress {

                            StatsGrid()

                            AvailablePointsCard()

                        }

                    }
                    .padding(.horizontal, AppTheme.Spacing.large)
                    .padding(.top, 24)
                    .padding(.bottom, 120)

                }

            }
            .background(.white)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .navigationBar)

        }

    }

}

#Preview {

    ProfileView()

}
