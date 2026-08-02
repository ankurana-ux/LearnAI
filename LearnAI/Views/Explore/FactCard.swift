import SwiftUI

struct FactCard: View {

    var body: some View {
        
        AppCard {

        VStack(spacing: 18) {
            
            AppSectionHeader(
                title: "Fun Fact",
                icon: "sparkles",
                color: .orange
            )
            
            Text("Honey never spoils. Archaeologists have found edible honey in Egyptian tombs over 3,000 years old.")
                .font(.headline)
                .multilineTextAlignment(.center)
            
            Image(systemName: "arrow.right.circle.fill")
                .font(.title2)
            
        }
    }

    }

}

#Preview {

    FactCard()

}
