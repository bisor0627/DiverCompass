//
//  Reflection.swift
//  DibyDot
//
//  Created by kirby on 4/17/25.
//
import Foundation

struct Reflection: Identifiable {
    let id: UUID
    var content: String
    var createdAt: Date

    /// 이 회고가 작성된 날짜가 속한 사이클의 이름
    var cycleNameAtWrittenTime: String?

    /// 연결된 목표가 있을 경우 (nullable)
    var linkedGoalID: UUID?
}
