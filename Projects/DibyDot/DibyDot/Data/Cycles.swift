// MARK: - Data/Seed.swift
import Foundation

struct Cycles {
    static let list: [Cycle] = [
        Cycle(name: "Prelude", type: .bridge,
                startDate: DateFormatter.kst.date(from: "2025-03-10")!,
                endDate: DateFormatter.kst.date(from: "2025-03-15")!),

        Cycle(name: "Challenge 1", type: .challenge,
                startDate: DateFormatter.kst.date(from: "2025-03-17")!,
                endDate: DateFormatter.kst.date(from: "2025-03-29")!),

        Cycle(name: "Bridge 1", type: .bridge,
                startDate: DateFormatter.kst.date(from: "2025-03-31")!,
                endDate: DateFormatter.kst.date(from: "2025-04-05")!),

        Cycle(name: "Challenge 2", type: .challenge,
                startDate: DateFormatter.kst.date(from: "2025-04-07")!,
                endDate: DateFormatter.kst.date(from: "2025-04-25")!),

        Cycle(name: "Bridge 2", type: .bridge,
                startDate: DateFormatter.kst.date(from: "2025-04-28")!,
                endDate: DateFormatter.kst.date(from: "2025-05-07")!),
        Cycle(name: "Challenge 3", type: .challenge,
                startDate: DateFormatter.kst.date(from: "2025-05-08")!,
                endDate: DateFormatter.kst.date(from: "2025-06-13")!),
        Cycle(name: "Bridge 3", type: .bridge,
                startDate: DateFormatter.kst.date(from: "2025-06-16")!,
                endDate: DateFormatter.kst.date(from: "2025-06-20")!),
        Cycle(name: "Challenge 4", type: .challenge,
                startDate: DateFormatter.kst.date(from: "2025-06-23")!,
                endDate: DateFormatter.kst.date(from: "2025-08-01")!),
        Cycle(name: "Bridge 4", type: .bridge,
                startDate: DateFormatter.kst.date(from: "2025-08-04")!,
                endDate: DateFormatter.kst.date(from: "2025-08-08")!),
        Cycle(name: "Challenge 5", type: .challenge,
                startDate: DateFormatter.kst.date(from: "2025-08-11")!,
                endDate: DateFormatter.kst.date(from: "2025-08-22")!),
        Cycle(name: "Bridge 5", type: .bridge,
                startDate: DateFormatter.kst.date(from: "2025-08-25")!,
                endDate: DateFormatter.kst.date(from: "2025-08-29")!),
        Cycle(name: "Challenge 6", type: .challenge,
                startDate: DateFormatter.kst.date(from: "2025-09-01")!,
                endDate: DateFormatter.kst.date(from: "2025-11-28")!),
        Cycle(name: "Epilogue", type: .bridge,
                startDate: DateFormatter.kst.date(from: "2025-12-01")!,
                endDate: DateFormatter.kst.date(from: "2025-12-12")!)
    ]
}
// [
//   {
//     "name": "Prelude",
//     "type": "Bridge",
//     "startDate": "2025-03-10",
//     "endDate": "2025-03-15"
//   },
//   {
//     "name": "Challenge 1",
//     "type": "Challenge",
//     "startDate": "2025-03-17",
//     "endDate": "2025-03-29"
//   },
//   {
//     "name": "Bridge 1",
//     "type": "Bridge",
//     "startDate": "2025-03-31",
//     "endDate": "2025-04-05"
//   },
//   {
//     "name": "Challenge 2",
//     "type": "Challenge",
//     "startDate": "2025-04-07",
//     "endDate": "2025-04-26"
//   },
//   {
//     "name": "Bridge 2",
//     "type": "Bridge",
//     "startDate": "2025-04-28",
//     "endDate": "2025-05-08"
//   },
//   {
//     "name": "Challenge 3",
//     "type": "Challenge",
//     "startDate": "2025-05-08",
//     "endDate": "2025-06-14"
//   },
//   {
//     "name": "Bridge 3",
//     "type": "Bridge",
//     "startDate": "2025-06-16",
//     "endDate": "2025-06-21"
//   },
//   {
//     "name": "Challenge 4",
//     "type": "Challenge",
//     "startDate": "2025-06-23",
//     "endDate": "2025-08-02"
//   },
//   {
//     "name": "Bridge 4",
//     "type": "Bridge",
//     "startDate": "2025-08-04",
//     "endDate": "2025-08-09"
//   },
//   {
//     "name": "Challenge 5",
//     "type": "Challenge",
//     "startDate": "2025-08-11",
//     "endDate": "2025-08-30"
//   },
//   {
//     "name": "Challenge 6",
//     "type": "Challenge",
//     "startDate": "2025-09-01",
//     "endDate": "2025-11-29"
//   },
//   {
//     "name": "Epilogue",
//     "type": "Bridge",
//     "startDate": "2025-12-01",
//     "endDate": "2025-12-13"
//   }
// ]
