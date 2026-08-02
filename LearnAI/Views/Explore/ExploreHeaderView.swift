import SwiftUI

struct ExploreHeaderView: View {

    var body: some View {

        HStack {

            HStack(spacing: 10) {

                Image("AppIcon")

                    .resizable()
                    .frame(width: 34, height: 34)
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                Text("LearnAI")
                    .font(.title3.bold())

            }

            Spacer()

            Button {

            } label: {

                Image(systemName: "bell")
                    .font(.title3)
                    .foregroundStyle(.black)
                    .frame(width: 42, height: 42)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.06), radius: 10, y: 4)

            }

        }
        .padding(.horizontal)
        .padding(.top, 8)

    }

}

#Preview {

    ExploreHeaderView()

}
