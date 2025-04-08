
import Foundation

struct Goal: Codable, Identifiable {
    var id = UUID()
    var type: GoalType // 전체 여정 or 특정 사이클
    var title: String
    var createdAt: Date = Date()

    enum GoalType: String, Codable {
        case overall = "전체 여정"
        case cycle = "사이클"
    }
}  

