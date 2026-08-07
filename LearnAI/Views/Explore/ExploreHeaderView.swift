import SwiftUI

struct ExploreHeaderView: View {

    var body: some View {

        HStack {

            Text("Explore")
                .font(.largeTitle.bold())
            Spacer()

            NavigationLink {

                NotificationView()

            } label: {

                ZStack(alignment: .topTrailing) {

                    Image(systemName: "bell")
                        .font(.title3)
                        .foregroundStyle(.black)
                        .frame(width: 42, height: 42)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.06), radius: 10, y: 4)

                    Circle()
                        .fill(.red)
                        .frame(width: 10, height: 10)
                        .offset(x: -2, y: 2)

                }

            }
            .buttonStyle(.plain)

        }
        .padding(.horizontal)
        .padding(.top, 8)

    }

}

#Preview {
    ExploreHeaderView()
}
