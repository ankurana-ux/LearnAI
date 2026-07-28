import SwiftUI

struct AIInformationView: View {

    let aiInfo: AIObjectInfo?
    let object: DetectedObject

    var body: some View {

        if let aiInfo {

            VStack(alignment: .leading, spacing: 20) {

                Text("AI Information")
                    .font(.headline)

                Text(aiInfo.summary)

                Divider()

                Text("History")
                    .font(.headline)

                Text(aiInfo.history)

                Divider()

                Text("Uses")
                    .font(.headline)

                ForEach(aiInfo.uses, id: \.self) { use in
                    Label(use, systemImage: "checkmark.circle.fill")
                }

                Divider()

                Text("Fun Facts")
                    .font(.headline)

                ForEach(aiInfo.funFacts, id: \.self) { fact in
                    Label(fact, systemImage: "sparkles")
                }

                Divider()

                Text("Safety")
                    .font(.headline)

                Text(aiInfo.safety)

            }

        } else {

            VStack(alignment: .leading, spacing: 10) {

                Text("About")
                    .font(.headline)

                Text(object.shortSummary)
                    .foregroundStyle(.secondary)

            }

        }

    }

}
