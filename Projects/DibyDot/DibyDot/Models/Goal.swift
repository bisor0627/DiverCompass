//
//  Goal.swift
//  DibyDot
//
//  Created by kirby on 4/17/25.
//

import Foundation

/// 특정 사이클에 대한 목표를 나타내는 구조체입니다.
/// GlobalGoal이 전체 기간에 대한 목표를 나타낸다면, CycleGoal은 특정 사이클(기간)에 대한 세부 목표를 나타냅니다.
struct Goal: Identifiable, Codable, Equatable {
    let id: UUID
    let cycleID: UUID
    var title: String
    let createdAt: Date
    
    init(cycleID: UUID, title: String) {
        self.id = UUID()
        self.cycleID = cycleID
        self.title = title
        self.createdAt = Date()
    }
}

extension Goal { 
    func cycleName() -> String {
      return  kCycles.first(where: { $0.id == cycleID })?.name ?? "Unknown"
    }
}
