import SwiftUI

struct ExploreData {

    static let categories = CategoryData.categories

    static let trendingObjects = TrendingData.objects
    
    static var dailyObject: TrendingObject {

        let day = Calendar.current.ordinality(
            of: .day,
            in: .year,
            for: Date()
        ) ?? 0

        return trendingObjects[
            day % trendingObjects.count
        ]

    }

}
