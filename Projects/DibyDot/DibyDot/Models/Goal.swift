import Foundation

struct Goal: Codable, Identifiable {
    let id = UUID()
    let goalType: GoalType // 전체 여정 or 특정 사이클
    let title: String
    let createdAt: Date = Date()

    enum GoalType: String, Codable {
        case overall = "전체 여정"
        case cycle = "사이클"
    }
}

