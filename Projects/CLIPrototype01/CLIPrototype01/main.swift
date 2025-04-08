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

// 현재 여정 출력
if let current = tracker.getCurrentJourneyInfo() {
    print("📍 현재 여정: \(current.name) (\(current.currentDay)/\(current.totalDays)일차)")
    print("📌 여정 단계: \(current.stage) / \(journeys.count) (\(current.stagePercent)%)")
    print(current.progressBar)
} else {
    print("⚠️ 현재 진행 중인 여정을 찾을 수 없습니다.")
}

// 전체 여정 출력
if let total = tracker.getTotalProgressInfo() {
    print("📊 전체 여정 진행률: \(total.passedDays)/\(total.totalDays)일차")
    print(total.progressBar)
}


print("\n✅ 목표를 잊지 말고, 오늘도 잠수 잘 하고 와! 🌊")