import SwiftUI

struct DetailView: View {

    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 24) {

                RoundedRectangle(cornerRadius: 24)
                    .fill(.gray.opacity(0.3))
                    .frame(height: 280)

                Text("Snake Plant")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("""
Snake Plant is one of the most popular indoor plants.

It requires very little maintenance and is known for helping improve indoor air quality.

Future versions of LearnAI will generate this explanation using AI.
""")

                Spacer()

            }
            .padding()

        }
        .navigationBarTitleDisplayMode(.inline)

    }
}

#Preview {

    NavigationStack {
        DetailView()
    }

}
