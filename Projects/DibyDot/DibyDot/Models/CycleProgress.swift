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
    func generateProgressList(target: Date = .now) -> [CycleProgress] {
        return self.map { cycle in
            return cycle.generateProgress(target: target)
        }
    }
}

extension Cycle {
    var dateRange: ClosedRange<Date> {
        self.startDate...self.endDate
    }

    var totalDays: Int {
        Calendar.current.dateComponents([.day], from: self.startDate, to: self.endDate).day! + 1
    }
    
    func  isCurrent  (target: Date = .now) -> Bool {
        return (self.startDate...self.endDate).contains(target)
    }
    
    func daysPassed (target: Date = .now) -> Int {
       return max(0, min(Calendar.current.dateComponents([.day], from: self.startDate, to: target).day! + 1, self.totalDays))
    }
    
    func daysRemaining (target: Date = .now) -> Int {
        return totalDays - daysPassed(target: target)
    }
    
    func progressRatio(target: Date = .now) -> Double  {
        return Double(daysPassed(target: target)) / Double(totalDays)
    }
    
    func  progressPercentage(target: Date = .now) -> Int {
        return Int(progressRatio(target: target) * 100)
    }
    
    func generateProgress(target: Date = .now) -> CycleProgress {

       return CycleProgress(
           name: name,
           progressRatio: progressRatio(target: target),
           daysPassed: daysPassed(target: target),
           totalDays: totalDays,
           isCurrent: isCurrent(target: target)
       )
        
    }
}
