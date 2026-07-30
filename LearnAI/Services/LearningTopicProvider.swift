import Foundation

protocol LearningTopicProvider {

    func fetchTopics() async throws -> [LearningTopic]

}
