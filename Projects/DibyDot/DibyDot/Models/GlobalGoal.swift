import Foundation

struct GlobalGoal: Identifiable {
    let id: UUID
    var title: String
    let period: ClosedRange<Date> // 전체 기간 자동 계산
}
