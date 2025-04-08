//
//  JourneyTracker.swift
//  CLIPrototype01
//
//  Created by kirby on 4/7/25.
//

import Foundation

class JourneyTracker {
    private let journeys: [Journey]
    private let referenceDate: Date

    init(journeys: [Journey], referenceDate: Date) {
        self.journeys = journeys
        self.referenceDate = referenceDate
    }

    func getCurrentJourneyInfo() -> (name: String, currentDay: Int, totalDays: Int, progressBar: String, stage: Int, stagePercent: Int)? {
        guard let current = journeys.first(where: { referenceDate >= $0.startDate && referenceDate <= $0.endDate }) else {
            return nil
        }

        let (currentDay, totalDays, percent) = calculateDayProgress(for: current)
        if let currentIndex = journeys.firstIndex(where: { $0.id == current.id }) {
            let stagePercent = Int(Double(currentIndex + 1) / Double(journeys.count) * 100)
            return (current.name, currentDay, totalDays, generateProgressBar(percent: percent), currentIndex + 1, stagePercent)
        }
        return nil
    }

    func getTotalProgressInfo() -> (passedDays: Int, totalDays: Int, progressBar: String)? {
        guard let first = journeys.first, let last = journeys.last else {
            return nil
        }

        let (passedDays, totalDays, percent) = calculateTotalProgress(start: first.startDate, end: last.endDate)
        return (passedDays, totalDays, generateProgressBar(percent: percent))
    }

    private func calculateDayProgress(for journey: Journey) -> (current: Int, total: Int, percent: Int) {
        let totalDays = Calendar.current.dateComponents([.day], from: journey.startDate, to: journey.endDate).day! + 1
        let currentDay = Calendar.current.dateComponents([.day], from: journey.startDate, to: referenceDate).day! + 1
        let percent = Int(Double(currentDay) / Double(totalDays) * 100)
        return (currentDay, totalDays, percent)
    }

    private func calculateTotalProgress(start: Date, end: Date) -> (passed: Int, total: Int, percent: Int) {
        let totalDays = Calendar.current.dateComponents([.day], from: start, to: end).day! + 1
        let passedDays = Calendar.current.dateComponents([.day], from: start, to: referenceDate).day! + 1
        let percent = Int(Double(passedDays) / Double(totalDays) * 100)
        return (passedDays, totalDays, percent)
    }

    private func generateProgressBar(percent: Int, width: Int = 10) -> String {
        let filled = Int(Double(width) * Double(percent) / 100.0)
        let swimmerLine = String(repeating: "  ", count: filled) + "🚣"
        let waveLine = String(repeating: "🌊", count: width)
        return "\(swimmerLine)\n\(waveLine) (\(percent)%)"
    }
}
