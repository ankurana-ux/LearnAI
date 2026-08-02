import SwiftUI

enum AppTab {

    case explore
    case library
    case scan
    case search
    case profile

}

struct BottomTabBar: View {

    @Binding var selectedTab: AppTab

    var body: some View {

        HStack {

            tabButton(
                .explore,
                defaultIcon: "home_default",
                activeIcon: "home_active"
            )

            Spacer()

            tabButton(
                .library,
                defaultIcon: "library_default",
                activeIcon: "library_active",
                
            )

            Spacer()

            tabButton(
                .scan,
                defaultIcon: "scan_default",
                activeIcon: "scan_active"
            )

            Spacer()

            tabButton(
                .search,
                defaultIcon: "search_default",
                activeIcon: "search_active"
            )

            Spacer()

            tabButton(
                .profile,
                defaultIcon: "profile_default",
                activeIcon: "profile_active"
            )

        }
        .padding(.horizontal, 30)
        .padding(.vertical, 18)
        .background(.ultraThinMaterial)
        .clipShape(Capsule())
        .padding()

    }

    @ViewBuilder
    private func tabButton(
        _ tab: AppTab,
        defaultIcon: String,
        activeIcon: String
    ) -> some View {

        Button {

            selectedTab = tab

        } label: {

            Image(selectedTab == tab ? activeIcon : defaultIcon)
                .resizable()
                .renderingMode(.original)
                .scaledToFit()
                .frame(width: 28, height: 28)

        }

    }

}

#Preview {

    BottomTabBar(
        selectedTab: .constant(.scan)
    )

}
