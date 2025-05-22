import Foundation



extension Cycle {
    var dateRange: ClosedRange<Date> {
        self.startDate...self.endDate
    }
    
    var totalDays: Int {
        Calendar.current.dateComponents([.day], from: self.startDate, to: self.endDate).day! + 1
    }
    
    var period: (start: String, end: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd.yyyy"
        let start = formatter.string(from: self.startDate)
        let end = formatter.string(from: self.endDate)
        return (start : start, end: end)
    }
    var periodString: String {
       let period = self.period
        return "\(period.start) ~ \(period.end)"
    }

    func  isCurrent  (_ target: Date = .now) -> Bool {
        return (self.startDate...self.endDate).contains(target)
    }
    
    func daysPassed (_ target: Date = .now) -> Int {
        return max(0, min(Calendar.current.dateComponents([.day], from: self.startDate, to: target).day! + 1, self.totalDays))
    }
    
    func daysRemaining (_ target: Date = .now) -> Int {
        return totalDays - daysPassed(target)
    }
    
    func progressRatio(_ target: Date = .now) -> Double  {
        return Double(daysPassed(target)) / Double(totalDays)
    }
    
    func  progressPercentage(_ target: Date = .now) -> Int {
        return Int(progressRatio( target) * 100)
    }
    


}

