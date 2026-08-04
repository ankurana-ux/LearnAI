import SwiftUI

struct LeaderboardTabs: View {

    @Binding var selectedFilter: String

    let filters = ["Weekly", "Monthly", "All Time"]

    var body: some View {

        HStack(spacing: 28) {

            ForEach(filters, id: \.self) { filter in

                Button {

                    selectedFilter = filter

                } label: {

                    VStack(spacing: 10) {

                        Text(filter)
                            .font(.headline)
                            .foregroundStyle(
                                selectedFilter == filter ? .black : .gray
                            )

                        Rectangle()
                            .fill(
                                selectedFilter == filter ? Color.black : .clear
                            )
                            .frame(height: 2)

                    }

                }
                .buttonStyle(.plain)

            }

            Spacer()

        }

    }

}
