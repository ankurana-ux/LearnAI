import SwiftUI

enum ProfileSection {

    case progress
    case badges

}

struct ProfileTabs: View {

    @Binding var selectedTab: ProfileSection

    var body: some View {

        HStack(spacing: 32) {

            tabButton("Progress", .progress)

            tabButton("Badges", .badges)

            Spacer()

        }

    }

    @ViewBuilder
    private func tabButton(
        _ title: String,
        _ tab: ProfileSection
    ) -> some View {

        Button {

            selectedTab = tab

        } label: {

            VStack(spacing: 10) {

                Text(title)
                    .font(.headline)
                    .foregroundStyle(
                        selectedTab == tab ? .black : .gray
                    )

                Rectangle()
                    .fill(
                        selectedTab == tab ? Color.black : .clear
                    )
                    .frame(height: 2)

            }

        }
        .buttonStyle(.plain)

    }

}

#Preview {

    ProfileTabs(
        selectedTab: .constant(.progress)
    )

}
