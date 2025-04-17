import Foundation

/// 사용자의 전체 여정에 대한 상위 목표를 나타내는 구조체입니다.
/// GlobalGoal은 전체 기간에 걸친 목표를 나타내며, 여러 개의 CycleGoal을 포함할 수 있습니다.
struct GlobalGoal: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    
    /// 목표의 전체 기간 (시작일부터 종료일까지, 양 끝 날짜 포함)
    let period: ClosedRange<Date>
    
    init(id: UUID = UUID(), title: String, period: ClosedRange<Date>) {
        self.id = id
        self.title = title
        self.period = period
    }
    
    /// 시작일과 종료일로 GlobalGoal을 생성하는 편의 이니셜라이저
    init(id: UUID = UUID(), title: String, startDate: Date, endDate: Date) {
        self.id = id
        self.title = title
        self.period = startDate...endDate
    }
}
