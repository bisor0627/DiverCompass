//
//  DibyDotTests.swift
//  DibyDotTests
//
//  Created by kirby on 4/17/25.
//

import XCTest
@testable import DibyDot

final class GoalTests: XCTestCase {
    func testGlobalGoalPeriodRange() {
        let goal = GlobalGoal(
            id: UUID(),
            title: "성장 여정 되돌아보기",
            period: Calendar.current.date(from: DateComponents(year: 2025, month: 1, day: 1))!...Date()
        )
        XCTAssertFalse(goal.period.isEmpty)
    }

    func testCycleGoalCreation() {
        let goal = Goal(
            id: UUID(),
            cycleName: "Challenge 2",
            title: "마음을 지키는 연습",
            createdAt: Date()
        )
        XCTAssertEqual(goal.cycleName, "Challenge 2")
    }

    func testReflectionWithoutGoal() {
        let reflection = Reflection(
            id: UUID(),
            content: "오늘은 목표 없이 회고만 해봤다",
            createdAt: Date(),
            cycleNameAtWrittenTime: "Challenge 2",
            linkedGoalID: nil
        )
        XCTAssertNil(reflection.linkedGoalID)
    }

    func testReflectionWithLinkedGoal() {
        let goalID = UUID()
        let reflection = Reflection(
            id: UUID(),
            content: "목표와 연결된 회고 작성",
            createdAt: Date(),
            cycleNameAtWrittenTime: "Challenge 2",
            linkedGoalID: goalID
        )
        XCTAssertEqual(reflection.linkedGoalID, goalID)
    }
}
