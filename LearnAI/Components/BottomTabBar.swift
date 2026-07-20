import SwiftUI

enum AppTab {
    case lens
    case history
    case saved
    case settings
}

struct BottomTabBar: View {

    @Binding var selectedTab: AppTab

    var body: some View {

        HStack {

            tabButton(.lens, "camera.viewfinder")
            Spacer()
            tabButton(.history, "clock")
            Spacer()
            tabButton(.saved, "heart")
            Spacer()
            tabButton(.settings, "gearshape")

        }
        .padding(.horizontal, 30)
        .padding(.vertical, 18)
        .background(.ultraThinMaterial)
        .clipShape(Capsule())
        .padding()
    }

    @ViewBuilder
    private func tabButton(_ tab: AppTab, _ icon: String) -> some View {

        Button {

            selectedTab = tab

        } label: {

            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(selectedTab == tab ? .blue : .white)

        }

    }
}

#Preview {

    BottomTabBar(selectedTab: .constant(.lens))

}
