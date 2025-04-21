//
//  CycleGoal.swift
//  DibyDot
//
//  Created by kirby on 4/17/25.
//

import Foundation

/// 특정 사이클에 대한 목표를 나타내는 구조체입니다.
/// GlobalGoal이 전체 기간에 대한 목표를 나타낸다면, CycleGoal은 특정 사이클(기간)에 대한 세부 목표를 나타냅니다.
struct CycleGoal: Identifiable, Codable, Equatable {
    let id: UUID
    let cycleID: UUID
    let cycleName: String
    var title: String
    let createdAt: Date
    
    init(cycleID: UUID, cycleName: String, title: String) {
        self.id = UUID()
        self.cycleID = cycleID
        self.cycleName = cycleName
        self.title = title
        self.createdAt = Date()
    }
}
