//
//  Reflection.swift
//  DibyDot
//
//  Created by kirby on 4/17/25.
//
import Foundation

/// 특정 시점에 작성된 회고를 나타내는 구조체입니다.
/// 회고는 선택적으로 목표(CycleGoal 또는 GlobalGoal)와 연결될 수 있습니다.
struct Reflection: Identifiable, Codable, Equatable {
    let id: UUID
    var content: String
    let createdAt: Date  // 생성 시간은 불변이어야 함

    /// 이 회고가 작성된 날짜가 속한 사이클의 이름
    var cycleNameAtWrittenTime: String?

    /// 연결된 목표가 있을 경우 (CycleGoal 또는 GlobalGoal의 ID가 될 수 있음)
    var linkedGoalID: UUID?
    
    init(id: UUID = UUID(), content: String, createdAt: Date = Date(), cycleNameAtWrittenTime: String? = nil, linkedGoalID: UUID? = nil) {
        self.id = id
        self.content = content
        self.createdAt = createdAt
        self.cycleNameAtWrittenTime = cycleNameAtWrittenTime
        self.linkedGoalID = linkedGoalID
    }
}
