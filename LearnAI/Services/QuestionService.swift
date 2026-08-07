import Foundation

final class QuestionService {

    static let shared = QuestionService()

    let guessQuestions: [Question] = [

        Question(
            title: "What unique feature helps this orchid attract pollinators?",
            image: "guess_object",
            answers: [
                "Iridescent petal colors",
                "Complex pheromonal signals",
                "Edible nectar traps",
                "Symbiotic fungal spores"
            ],
            correctAnswer: 1
        ),

        Question(
            title: "Which part of this flower produces pollen?",
            image: "guess_object",
            answers: [
                "Petal",
                "Stem",
                "Anther",
                "Sepal"
            ],
            correctAnswer: 2
        ),

        Question(
            title: "Which adaptation helps desert plants survive?",
            image: "guess_object",
            answers: [
                "Large soft leaves",
                "Thick water-storing stems",
                "Bright blue flowers",
                "Floating roots"
            ],
            correctAnswer: 1
        )

    ]

}
