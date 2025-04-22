import Foundation

struct Cycle: Identifiable {
    var id = UUID()
    let name: String
    let type: CycleType
    let startDate: Date
    let endDate: Date
    let parentID: UUID? 
    
    init(_ id: UUID = UUID(), name: String, type: CycleType, startDate: Date, endDate: Date, parentID: UUID? = nil) {
        self.id = id
        self.name = name
        self.type = type
        self.startDate = startDate
        self.endDate = endDate
        self.parentID = parentID
        
        assert(startDate <= endDate, "시작일은 종료일보다 이전이어야 합니다")
    }
}

enum CycleType: String {
    case overall
    case challenge
    case bridge
    case other
}
