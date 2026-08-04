import SwiftUI

struct BadgeFilterTabs: View {

    @Binding var selectedFilter: String

    let filters = [
        "All Badges",
        "Unlocked",
        "In Progress",
        "Bronze",
        "Silver",
        "Gold",
        "Diamond"
    ]

    
    
    var body: some View {

        ScrollView(.horizontal, showsIndicators: false) {

            HStack(spacing: 10) {

                ForEach(filters, id: \.self) { filter in

                    Button {

                        selectedFilter = filter

                    } label: {

                        Text(filter)
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(
                                selectedFilter == filter ? .white : .secondary
                            )
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(
                                selectedFilter == filter
                                ? Color.black
                                : Color.gray.opacity(0.12)
                            )
                            .clipShape(Capsule())

                    }
                    .buttonStyle(.plain)

                }

            }

        }

    }

}

#Preview {

    BadgeFilterTabs(
        selectedFilter: .constant("All Badges")
    )

}
