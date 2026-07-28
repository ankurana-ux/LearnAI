import SwiftUI

struct ObjectHeaderView: View {

    let object: DetectedObject

    var body: some View {

        VStack(alignment: .leading, spacing: 24) {

            Capsule()
                .fill(.secondary.opacity(0.4))
                .frame(width: 42, height: 5)
                .frame(maxWidth: .infinity)

            HStack(alignment: .top) {

                Image(systemName: object.icon)
                    .font(.system(size: 42))
                    .foregroundStyle(.green)

                VStack(alignment: .leading, spacing: 6) {

                    Text(object.name)
                        .font(.largeTitle.bold())

                    Text("AI identified this object with high confidence.")
                        .foregroundStyle(.secondary)

                }

                Spacer()

            }

            Divider()

        }

    }

}
