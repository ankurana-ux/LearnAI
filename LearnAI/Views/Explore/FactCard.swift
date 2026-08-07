import SwiftUI

struct FactCard: View {

    var body: some View {
        
        AppCard {

        VStack(spacing: 18) {
            
            AppSectionHeader(
                title: "Fun Fact",
                icon: "sparkles",
                color: Color(
                    red: 156 / 255,
                    green: 163 / 255,
                    blue: 175 / 255
                )
            )
            
            Text("Honey never spoils. Archaeologists have found edible honey in Egyptian tombs over 3,000 years old.")
                .font(.headline)
                .multilineTextAlignment(.center)
            
            Image(systemName: "arrow.right")
                .font(.title2.weight(.semibold))
                .foregroundStyle(.black)
            
        }
    }

    }

}

#Preview {

    FactCard()

}
