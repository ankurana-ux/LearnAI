import Foundation

final class DailyCuriosityCache {

    static let shared = DailyCuriosityCache()

    private init() {}

    private let key = "daily_curiosity_cache"


    func save(
        _ topic: LearningTopic
    ) {

        let encoder = JSONEncoder()

        if let data = try? encoder.encode(topic) {

            UserDefaults.standard.set(
                data,
                forKey: key
            )

        }

    }


    func load() -> LearningTopic? {

        guard let data = UserDefaults.standard.data(
            forKey: key
        ) else {
            return nil
        }


        return try? JSONDecoder()
            .decode(
                LearningTopic.self,
                from: data
            )

    }


    func isToday() -> Bool {

        guard
            let savedDate = UserDefaults.standard.object(
                forKey: "\(key)_date"
            ) as? Date
        else {
            return false
        }


        return Calendar.current.isDateInToday(
            savedDate
        )

    }


    func saveDate() {

        UserDefaults.standard.set(
            Date(),
            forKey: "\(key)_date"
        )

    }

}
