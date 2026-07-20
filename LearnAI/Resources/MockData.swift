import Foundation

enum MockData {

    static let snakePlant = DetectedObject(

        name: "Snake Plant",
        category: "Indoor Plant",
        shortSummary: "Thrives in low light and requires minimal watering.",
        detailedSummary: "Snake plants are resilient indoor plants known for air purification and drought tolerance.",
        confidence: 0.98,
        icon: "leaf.fill",

        facts: [

            ObjectFact(
                icon: "drop.fill",
                title: "Water",
                value: "Every 2–3 weeks"
            ),

            ObjectFact(
                icon: "sun.max.fill",
                title: "Light",
                value: "Bright indirect light"
            ),

            ObjectFact(
                icon: "thermometer.medium",
                title: "Difficulty",
                value: "Easy"
            )

        ]

    )

    static let rose = DetectedObject(

        name: "Rose",
        category: "Flower",

        shortSummary: "A flowering plant admired for its colorful blooms and pleasant fragrance.",

        detailedSummary: "Roses are one of the world's most popular flowering plants, valued for their beauty, fragrance, and symbolic meaning. They thrive in full sunlight with regular watering and proper pruning.",

        confidence: 0.96,

        icon: "rose.fill",

        facts: [

            ObjectFact(
                icon: "drop.fill",
                title: "Water",
                value: "2–3 times a week"
            ),

            ObjectFact(
                icon: "sun.max.fill",
                title: "Light",
                value: "Full Sun"
            ),

            ObjectFact(
                icon: "heart.fill",
                title: "Meaning",
                value: "Love"
            )

        ]

    )

}
