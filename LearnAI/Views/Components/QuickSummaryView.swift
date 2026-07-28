import SwiftUI

struct QuickSummaryView: View {

    let object: DetectedObject

    var body: some View {

        VStack(alignment: .leading, spacing: 10) {

            Text("Quick Summary")
                .font(.headline)

            Text(object.detailedSummary)

        }

    }

}
