import SwiftUI

struct ExploreData {

    static let categories = CategoryData.categories

    static let trendingTopics = TrendingData.objects
    
    static var dailyTopic: LearningTopic {
        
        let day = Calendar.current.ordinality(
            of: .day,
            in: .year,
            for: Date()
        ) ?? 0

        return trendingTopics[
            day % trendingTopics.count
        ]

    }

}
