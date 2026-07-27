import SwiftUI

struct WorldLearningCard: View {

    let object: WorldLearning

    var body: some View {

        HStack(spacing: 16) {

            Image(object.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 70, height: 70)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 6) {

                Text(object.name)
                    .font(.headline)

                Text(object.learners)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text(object.summary)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)

            }

            Spacer()
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

#Preview {
    WorldLearningCard(object: WorldLearningData.objects.first!)
}
