import Foundation

struct LearningProfile: Codable {

    // MARK: Points

    var points: Int = 0
    var level: Int = 1

    // MARK: Learning

    var totalScans: Int = 0
    var scansThisMonth: Int = 0

    // MARK: Streak

    var currentStreak: Int = 0
    var longestStreak: Int = 0

    // MARK: Quizzes

    var quizzesCompleted: Int = 0

    // MARK: Discoveries

    var rareFinds: Int = 0

    // MARK: Progress

    var currentObjectiveProgress: Int = 0

    // MARK: Leaderboard

    var rank: Int = 9999
    
    var progressToNextLevel: Double {

        let currentLevelStart = (level - 1) * 100
        let currentProgress = points - currentLevelStart

        return Double(currentProgress) / 100.0

    }

    var pointsToNextLevel: Int {

        (level * 100) - points

    }

}
