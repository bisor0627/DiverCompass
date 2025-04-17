import Foundation

struct CycleProgress: Codable, Equatable {
    let name: String
    let progressRatio: Double
    let daysPassed: Int
    let totalDays: Int
    let isCurrent: Bool
    
    var progressPercentage: Int {
        return Int(progressRatio * 100)
    }
    
    init(name: String, progressRatio: Double, daysPassed: Int, totalDays: Int, isCurrent: Bool) {
        precondition(progressRatio >= 0 && progressRatio <= 1, "progressRatio must be between 0 and 1")
        self.name = name
        self.progressRatio = progressRatio
        self.daysPassed = daysPassed
        self.totalDays = totalDays
        self.isCurrent = isCurrent
    }
}