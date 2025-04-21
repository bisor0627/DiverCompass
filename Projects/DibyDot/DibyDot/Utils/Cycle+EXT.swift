import Foundation



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
    
}
