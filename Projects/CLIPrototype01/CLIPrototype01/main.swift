//
//  main.swift
//  CLIPrototype01
//
//  Created by kirby on 4/7/25.
//

import Foundation

print("\n🌊 Welcome to DiverCompass CLI 🌊")
print("아카데미 여정 속, 당신의 현재 위치를 확인해보세요!\n")

let today = Date()
let journeys = JourneySeed.list
let tracker = JourneyTracker(journeys: journeys, referenceDate: today)
let goalManager = GoalManager() // 🎯 목표 관리 객체 생성

// 현재 여정 출력
if let current = tracker.getCurrentJourneyInfo() {
    print("📍 현재 여정: \(current.name) (\(current.currentDay)/\(current.totalDays)일차)")
    print(current.progressBar)
    print("📌 여정 단계: \(current.stage) / \(journeys.count) (\(current.stagePercent)%)")
} else {
    print("⚠️ 현재 진행 중인 여정을 찾을 수 없습니다.")
}

// 전체 여정 출력
if let total = tracker.getTotalProgressInfo() {
    print("📊 전체 여정 진행률: \(total.passedDays)/\(total.totalDays)일차")
    print(total.progressBar)
}

// 전체 여정 목표 관리 메뉴
while true {
    print("""
🎯 전체 여정 목표 관리 메뉴
1. 목표 추가
2. 목표 목록 보기
3. 목표 수정
4. 목표 삭제
0. 종료
선택: 
""", terminator: "")

    guard let choice = readLine(), !choice.isEmpty else { continue }

    switch choice {
    case "1":
        print("✏️ 새 목표 입력: ", terminator: "")
        if let title = readLine(), !title.isEmpty {
            goalManager.addOverallGoal(title: title)
        }

    case "2":
        goalManager.listOverallGoals()

    case "3":
        goalManager.listOverallGoals()
        print("몇 번째 목표를 수정할까요? (번호 입력): ", terminator: "")
        if let input = readLine(), let index = Int(input), index > 0 {
            print("✏️ 새 내용 입력: ", terminator: "")
            if let newTitle = readLine(), !newTitle.isEmpty {
                goalManager.updateOverallGoal(index: index - 1, newTitle: newTitle)
            }
        }

    case "4":
        goalManager.listOverallGoals()
        print("몇 번째 목표를 삭제할까요? (번호 입력): ", terminator: "")
        if let input = readLine(), let index = Int(input), index > 0 {
            goalManager.deleteOverallGoal(index: index - 1)
        }

    case "0":
        print("\n✅ 목표를 잊지 말고, 오늘도 잠수 잘 하고 와! 🌊")
        exit(0)

    default:
        print("❌ 유효한 번호를 선택해주세요.")
    }
}
