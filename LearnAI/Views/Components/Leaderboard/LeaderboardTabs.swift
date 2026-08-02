import SwiftUI

struct LeaderboardTabs: View {

    @Binding var selectedFilter: String

    let filters = ["Weekly", "Monthly", "All Time"]

    var body: some View {

        HStack(spacing: 24) {

            ForEach(filters, id: \.self) { filter in

                Button {

                    selectedFilter = filter

                } label: {

                    Text(filter)
                        .foregroundStyle(
                            selectedFilter == filter ? .black : .gray
                        )

                }

            }

        }

    }

}
