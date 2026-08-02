import SwiftUI

struct MysteryObjectCard: View {

    var body: some View {

        AppCard {
            
            VStack(alignment: .leading, spacing: 20) {
                
                AppSectionHeader(
                    title: "Mystery Object",
                    icon: "questionmark.circle.fill",
                    color: .purple
                )
                
                HStack(spacing: 18) {
                    
                    RoundedRectangle(cornerRadius: 18)
                        .fill(.gray.opacity(0.2))
                        .frame(width: 110, height: 110)
                        .overlay {
                            
                            Image(systemName: "photo")
                                .font(.largeTitle)
                                .foregroundStyle(.secondary)
                            
                        }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text("Guess today's object")
                            .font(.headline)
                        
                        Text("Can you identify this mystery object before revealing the answer?")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        Button {
                            
                        } label: {
                            
                            HStack {
                                
                                Text("Let's Go")
                                
                                Image(systemName: "arrow.right")
                                
                            }
                            
                        }
                        .buttonStyle(.borderedProminent)
                        
                    }
                    
                }
                
            }
        }

    }

}

#Preview {

    MysteryObjectCard()

}
