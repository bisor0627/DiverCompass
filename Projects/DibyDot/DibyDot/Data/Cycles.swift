import Foundation

let apple4th = UUID()
let kCycles: [Cycle] = [
    Cycle(apple4th, name: "ADA 4th", type: .other,
          startDate: DateFormatter.kst.date(from: "2025-03-10")!,
          endDate: DateFormatter.kst.date(from: "2025-12-12")!,
          parentID: nil),
                            
Cycle(name: "Prelude", type: .bridge,
        startDate: DateFormatter.kst.date(from: "2025-03-10")!,
      endDate: DateFormatter.kst.date(from: "2025-03-15")!, parentID: apple4th),

Cycle(name: "Challenge 1", type: .challenge,
        startDate: DateFormatter.kst.date(from: "2025-03-17")!,
        endDate: DateFormatter.kst.date(from: "2025-03-29")!, parentID: apple4th),

Cycle(name: "Bridge 1", type: .bridge,
        startDate: DateFormatter.kst.date(from: "2025-03-31")!,
        endDate: DateFormatter.kst.date(from: "2025-04-05")!, parentID: apple4th),

Cycle(name: "Challenge 2", type: .challenge,
        startDate: DateFormatter.kst.date(from: "2025-04-07")!,
        endDate: DateFormatter.kst.date(from: "2025-04-25")!, parentID: apple4th),

Cycle(name: "Bridge 2", type: .bridge,
        startDate: DateFormatter.kst.date(from: "2025-04-28")!,
        endDate: DateFormatter.kst.date(from: "2025-05-07")!, parentID: apple4th),
Cycle(name: "Challenge 3", type: .challenge,
        startDate: DateFormatter.kst.date(from: "2025-05-08")!,
        endDate: DateFormatter.kst.date(from: "2025-06-13")!, parentID: apple4th),
Cycle(name: "Bridge 3", type: .bridge,
        startDate: DateFormatter.kst.date(from: "2025-06-16")!,
        endDate: DateFormatter.kst.date(from: "2025-06-20")!, parentID: apple4th),
Cycle(name: "Challenge 4", type: .challenge,
        startDate: DateFormatter.kst.date(from: "2025-06-23")!,
        endDate: DateFormatter.kst.date(from: "2025-08-01")!, parentID: apple4th),
Cycle(name: "Bridge 4", type: .bridge,
        startDate: DateFormatter.kst.date(from: "2025-08-04")!,
        endDate: DateFormatter.kst.date(from: "2025-08-08")!, parentID: apple4th),
Cycle(name: "Challenge 5", type: .challenge,
        startDate: DateFormatter.kst.date(from: "2025-08-11")!,
        endDate: DateFormatter.kst.date(from: "2025-08-22")!, parentID: apple4th),
Cycle(name: "Bridge 5", type: .bridge,
        startDate: DateFormatter.kst.date(from: "2025-08-25")!,
        endDate: DateFormatter.kst.date(from: "2025-08-29")!, parentID: apple4th),
Cycle(name: "Challenge 6", type: .challenge,
        startDate: DateFormatter.kst.date(from: "2025-09-01")!,
        endDate: DateFormatter.kst.date(from: "2025-11-28")!, parentID: apple4th),
Cycle(name: "Epilogue", type: .bridge,
        startDate: DateFormatter.kst.date(from: "2025-12-01")!,
        endDate: DateFormatter.kst.date(from: "2025-12-12")!, parentID: apple4th),
]
