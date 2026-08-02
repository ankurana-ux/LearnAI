import Foundation
import SwiftUI
import Combine

@MainActor
final class LearningProfileService: ObservableObject {

    static let shared = LearningProfileService()

    @Published private(set) var profile = LearningProfile()

    private let key = "learning_profile"

    private init() {

        load()

    }

    // MARK: - Points

    func addPoints(_ points: Int) {

        profile.points += points

        updateLevel()

        save()

    }

    // MARK: - Scan

    func scanCompleted() {

        profile.totalScans += 1
        profile.scansThisMonth += 1

        addPoints(5)

    }

    // MARK: - Quiz

    func quizCompleted() {

        profile.quizzesCompleted += 1

        addPoints(10)

    }

    // MARK: - Rare Find

    func rareItemFound() {

        profile.rareFinds += 1

        addPoints(50)

    }

    // MARK: - Objective

    func objectiveProgress() {

        profile.currentObjectiveProgress += 1

        save()

    }

    // MARK: - Level

    private func updateLevel() {

        profile.level = max(1, (profile.points / 100) + 1)

    }

    // MARK: - Save

    private func save() {

        if let data = try? JSONEncoder().encode(profile) {

            UserDefaults.standard.set(data, forKey: key)

        }

    }

    // MARK: - Load

    private func load() {

        guard
            let data = UserDefaults.standard.data(forKey: key),
            let saved = try? JSONDecoder().decode(
                LearningProfile.self,
                from: data
            )
        else {

            return

        }

        profile = saved

    }

}
