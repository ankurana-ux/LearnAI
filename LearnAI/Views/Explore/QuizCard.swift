import SwiftUI

struct QuizCard: View {

    @ObservedObject private var learning = LearningProfileService.shared

    var body: some View {
        
        AppCard {
            
            VStack(alignment: .leading, spacing: 20) {
                
                AppSectionHeader(
                    title: "Quiz",
                    icon: "brain.head.profile",
                    color: .purple
                )
                
                Text("Want to take a quiz?")
                    .font(.title3.bold())
                
                Text("Whatever you've learned and scanned this week.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                HStack {
                    
                    Label("+10 LP", systemImage: "star.fill")
                        .font(.caption.bold())
                        .foregroundStyle(.orange)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        
                        HStack {
                            
                            Text("Take Quiz")
                            
                            Image(systemName: "arrow.right")
                            
                        }
                        
                        .font(.headline)
                        
                    }
                    
                }
                
            }
        }
    }

}

#Preview {

    QuizCard()

}
