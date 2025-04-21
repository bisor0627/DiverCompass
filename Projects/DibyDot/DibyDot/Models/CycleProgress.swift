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


extension Array where Element == Cycle {
    func generateProgressList(today: Date = .now) -> [CycleProgress] {
        return self.map { cycle in
            return cycle.generateProgress(today: today)
        }
    }
}

extension Cycle {
    func generateProgress(today: Date = .now) -> CycleProgress {
        let totalDays = Calendar.current.dateComponents([.day], from: self.startDate, to: self.endDate).day! + 1
        let daysPassed = Swift.max(0, Swift.min(Calendar.current.dateComponents([.day], from: self.startDate, to: today).day! + 1, totalDays))
        let ratio = Double(daysPassed) / Double(totalDays)
        let isCurrent = (self.startDate...self.endDate).contains(today)

        return CycleProgress(
            name: self.name,
            progressRatio: ratio,
            daysPassed: daysPassed,
            totalDays: totalDays,
            isCurrent: isCurrent
            )
        }
    }
