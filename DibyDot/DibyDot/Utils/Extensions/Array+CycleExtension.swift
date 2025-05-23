import Foundation

extension Array where Element == Cycle {

    /// 기준 날짜가 속한 Cycle 또는 가장 가까운 미래 Cycle의 index 반환
    func closestAccurateCycleIndex(from date: Date = .now) -> Int {
        // 1️⃣ 날짜가 포함된 Cycle 우선
        if let matchIndex = self.firstIndex(where: { $0.dateRange.contains(date) }) {
            return matchIndex
        }
        
        // 2️⃣ 미래 시작일 중 가장 가까운 Cycle
        if let futureIndex = self.enumerated()
            .filter({ $0.element.startDate > date })
            .min(by: { $0.element.startDate < $1.element.startDate })?.offset {
            return futureIndex
        }
        
        // 3️⃣ 모든 Cycle이 지난 경우
        return self.count - 1
    }
    
    /// 기준 날짜가 속한 Cycle 또는 가장 가까운 미래 Cycle 반환
    func closestAccurateCycle(from date: Date = .now) -> Cycle {
        // 1️⃣ 날짜가 포함된 Cycle 우선
        if let cycle = self.first(where: { $0.dateRange.contains(date) }) {
            return cycle
        }
        
        // 2️⃣ 미래 시작일 중 가장 가까운 Cycle
        if let cycle = self.enumerated()
            .filter({ $0.element.startDate > date })
            .min(by: { $0.element.startDate < $1.element.startDate })?.element {
            return cycle
        }
        
        // 3️⃣ 모든 Cycle이 지난 경우 마지막 Cycle 반환
        return self.last!
    }
}
