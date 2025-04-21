//
//  Reflection.swift
//  DibyDot
//
//  Created by kirby on 4/17/25.
//
import Foundation

/// 특정 시점에 작성된 회고를 나타내는 구조체입니다.
/// 회고는 선택적으로 목표(Goal 또는 GlobalGoal)와 연결될 수 있습니다.
struct Reflection: Identifiable, Codable, Equatable {
    let id: UUID
    let createdAt: Date
    var content: String
    /// 이 회고가 작성된 날짜가 속한 사이클
    var cycleID: UUID?
    /// 이 회고가 작성된 날짜가 속한 사이클의 목표
    var goalID: UUID?
    
    init(content: String, cycleID: UUID? = nil, goalID: UUID? = nil) {
        self.id = UUID()
        self.createdAt = Date()
        self.content = content
        self.cycleID = cycleID
        self.goalID = goalID
    }
}
