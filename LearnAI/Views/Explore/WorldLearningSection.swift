import SwiftUI

struct WorldLearningSection: View {

    var body: some View {


        VStack(alignment: .leading, spacing: 16) {

            Text("World is Learning")
                .font(.title3.bold())

            HStack {

                Image("tesla")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 90, height: 90)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 16)
                    )

                VStack(alignment: .leading) {

                    Text("People are discovering")
                        .font(.headline)

                    Text("12,420 objects today")
                        .foregroundStyle(.secondary)

                }

                Spacer()

            }
            .padding()
            .background(.white)
            .clipShape(
                RoundedRectangle(cornerRadius: 28)
            )

        }

    }

}

#Preview {
    WorldLearningSection()
}
