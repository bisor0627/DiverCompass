import Foundation


struct Journey: Identifiable {
    let id = UUID()
    let name: String
    let type: JourneyType
    let startDate: Date
    let endDate: Date
}

enum JourneyType: String {
    case challenge
    case bridge
    case other
}