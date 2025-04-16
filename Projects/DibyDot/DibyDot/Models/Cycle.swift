import Foundation


struct Cycle: Identifiable {
    let id = UUID()
    let name: String
    let type: CycleType
    let startDate: Date
    let endDate: Date
}

enum CycleType: String {
    case challenge
    case bridge
    case other
}
