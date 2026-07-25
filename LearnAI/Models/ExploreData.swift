import SwiftUI

struct ExploreData {

    static let categories = [
        ExploreCategory(title: "Animals", icon: "pawprint.fill", color: .orange),
        ExploreCategory(title: "Plants", icon: "leaf.fill", color: .green),
        ExploreCategory(title: "Technology", icon: "laptopcomputer", color: .blue),
        ExploreCategory(title: "Food", icon: "fork.knife", color: .red),
        ExploreCategory(title: "Vehicles", icon: "car.fill", color: .purple),
        ExploreCategory(title: "Space", icon: "sparkles", color: .indigo)
    ]

    static let trendingObjects = [

        TrendingObject(
            name: "Panda",
            imageName: "Panda",

            summary: "Why do pandas eat bamboo?",
            description: """
            Giant pandas are native to China and spend most of their day eating bamboo. Despite belonging to the bear family, over 99% of their diet consists of bamboo. They can eat for up to 14 hours a day.
            """
        ),

        TrendingObject(
            name: "Saturn",
            imageName: "Saturn",


            summary: "The planet with the most spectacular rings.",
            description: """
            Saturn is the sixth planet from the Sun and is famous for its bright rings made of billions of pieces of ice and rock.
            """
        ),

        TrendingObject(
            name: "Volcano",
            imageName: "Volcano",


            summary: "How does lava reach Earth's surface?",
            description: """
            Volcanoes form when molten rock rises from deep inside Earth through cracks in the crust and erupts onto the surface.
            """
        ),

        TrendingObject(
            name: "Octopus",
            imageName: "Octopus",


            summary: "One of the smartest animals in the ocean.",
            description: """
            Octopuses can solve puzzles, escape enclosures, and instantly change colour and texture to camouflage themselves.
            """
        ),

        TrendingObject(
            name: "Tesla Model S",
            imageName: "Tesla",


            summary: "How do electric vehicles work?",
            description: """
            The Tesla Model S is a fully electric car powered by rechargeable batteries instead of a petrol engine.
            """
        ),

        TrendingObject(
            name: "Blue Whale",
            imageName: "BlueWhale",


            summary: "The largest animal to have ever lived.",
            description: """
            Blue whales can grow over 30 metres long and weigh more than 170 tonnes while feeding almost entirely on tiny krill.
            """
        )

    ]
    
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
