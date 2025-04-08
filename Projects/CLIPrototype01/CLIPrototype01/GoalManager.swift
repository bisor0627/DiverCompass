
import Foundation


class GoalManager {
    private var goals: [Goal] = []

    // MARK: - 전체 여정 목표 전용 CRUD
    func addOverallGoal(title: String) {
        let newGoal = Goal(type: .overall, title: title)
        goals.append(newGoal)
        print("✅ 전체 여정 목표가 등록되었어요!")
    }

    func listOverallGoals() {
        let overallGoals = goals.filter { $0.type == .overall }

        guard !overallGoals.isEmpty else {
            print("🫥 아직 전체 여정 목표가 없어요.")
            return
        }

        print("\n🌱 전체 여정 목표")
        for (index, goal) in overallGoals.enumerated() {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd"
            let dateStr = dateFormatter.string(from: goal.createdAt)
            print("\(index + 1). \(goal.title) (작성일: \(dateStr))")
        }
    }

    func updateOverallGoal(index: Int, newTitle: String) {
        let overallGoals = goals.enumerated().filter { $0.element.type == .overall }
        guard index >= 0, index < overallGoals.count else {
            print("⚠️ 수정할 목표 인덱스가 잘못되었어요.")
            return
        }
        let goalIndex = overallGoals[index].offset
        goals[goalIndex].title = newTitle
        print("🔄 전체 여정 목표가 수정되었어요!")
    }

    func deleteOverallGoal(index: Int) {
        let overallGoals = goals.enumerated().filter { $0.element.type == .overall }
        guard index >= 0, index < overallGoals.count else {
            print("⚠️ 삭제할 목표 인덱스가 잘못되었어요.")
            return
        }
        let goalIndex = overallGoals[index].offset
        goals.remove(at: goalIndex)
        print("🗑️ 전체 여정 목표가 삭제되었어요!")
    }
}
