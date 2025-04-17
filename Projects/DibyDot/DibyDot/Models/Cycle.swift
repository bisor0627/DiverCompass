import Foundation

struct Cycle: Identifiable {
    let id = UUID()
    let name: String
    let type: CycleType
    let startDate: Date
    let endDate: Date
    
    var dateRange: ClosedRange<Date> {
        startDate...endDate
    }
    
    var totalDays: Int {
        Calendar.current.dateComponents([.day], from: startDate, to: endDate).day! + 1
    }
    
    init(name: String, type: CycleType, startDate: Date, endDate: Date) {
        self.name = name
        self.type = type
        self.startDate = startDate
        self.endDate = endDate
        
        assert(startDate <= endDate, "시작일은 종료일보다 이전이어야 합니다")
    }
}

enum CycleType: String {
    case challenge
    case bridge
    case other
}
