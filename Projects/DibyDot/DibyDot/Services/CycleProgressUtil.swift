import Foundation

struct CycleProgressUtil {
    static func generateProgressList(from cycles: [Cycle], today: Date = .now) -> [CycleProgress] {
        cycles.map { cycle in
            let totalDays = Calendar.current.dateComponents([.day], from: cycle.startDate, to: cycle.endDate).day! + 1
            let daysPassed = max(0, min(Calendar.current.dateComponents([.day], from: cycle.startDate, to: today).day! + 1, totalDays))
            let ratio = Double(daysPassed) / Double(totalDays)
            let isCurrent = (cycle.startDate...cycle.endDate).contains(today)

            return CycleProgress(
                name: cycle.name,
                progressRatio: ratio,
                daysPassed: daysPassed,
                totalDays: totalDays,
                isCurrent: isCurrent
            )
        }
    }

    static func currentCycle(from progressList: [CycleProgress]) -> CycleProgress? {
        return progressList.first(where: { $0.isCurrent })
    }
}

extension CycleProgressUtil {
    static func overallProgress(from cycles: [Cycle], today: Date = .now) -> CycleProgress {
        guard let first = cycles.first, let last = cycles.last else {
            return CycleProgress(name: "전체", progressRatio: 0, daysPassed: 0, totalDays: 1, isCurrent: false)
        }

        let totalDays = Calendar.current.dateComponents([.day], from: first.startDate, to: last.endDate).day! + 1
        let daysPassed = max(0, min(Calendar.current.dateComponents([.day], from: first.startDate, to: today).day! + 1, totalDays))
        let ratio = Double(daysPassed) / Double(totalDays)

        return CycleProgress(
            name: "전체",
            progressRatio: ratio,
            daysPassed: daysPassed,
            totalDays: totalDays,
            isCurrent: false
        )
    }
}
