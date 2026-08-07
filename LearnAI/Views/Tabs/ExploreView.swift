import SwiftUI

struct ExploreView: View {
    
    @StateObject private var history = HistoryService.shared
    @EnvironmentObject private var router: AppRouter
    
    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(spacing: 32) {

                    ExploreHeaderView()

                    DailyMomentumCard()
                        .padding(.horizontal, 5)

                    NavigationLink {

                        CollectionDetailView(
                            collection: LearningCollectionService.shared.collections.first!
                        )

                    } label: {

                        CurrentObjectiveCard()
                            .padding(.horizontal, 5)

                    }
                    .buttonStyle(.plain)
                    
                    
                    Button {

                        router.destination = .quiz

                    } label: {

                        QuizCard()
                            .padding(.horizontal, 5)

                    }
                    .buttonStyle(.plain)

                    DailyCuriositySection()
                        .padding(.horizontal, 5)

                    WorldLearningSection()

                    TrendingSection()

                    FunFactCard()
                        .padding(.horizontal, 5)

                    Button {

                        router.destination = .guessObject

                    } label: {

                        MysteryObjectCard()
                            .padding(.horizontal, 5)

                    }
                    .buttonStyle(.plain)
                    
                    BadgeProgressCard()
                        .padding(.horizontal, 5)

                    FactCard()
                        .padding(.horizontal, 5)

                    RareFindsCard()
                        .padding(.horizontal, 5)

                }
                .padding(.horizontal, 20)
                .padding(.top)
                .padding(.bottom, 100)

            }
        }
        
    }
}

#Preview {

    ExploreView()

}
