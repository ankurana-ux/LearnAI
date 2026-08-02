import SwiftUI

struct DailyCuriositySection: View {

    var body: some View {

        AppCard {

            VStack(alignment: .leading, spacing: 16) {
                
                Text("Daily Curiosity")
                    .font(.title3.bold())
                
                VStack(alignment: .leading, spacing: 12) {
                    
                    Image("tesla")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 180)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 20)
                        )
                    
                    Text("Why do leaves change colour?")
                        .font(.headline)
                    
                    Text("Discover the science behind one of nature's most beautiful transformations.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                }
            }

        }

    }

}

#Preview {
    DailyCuriositySection()
}
