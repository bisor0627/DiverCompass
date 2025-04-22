import Foundation

func childCycles(of parent: Cycle?, in cycles: [Cycle]) -> [Cycle] {
    guard let parent = parent else { return [] }
    return cycles.filter { $0.parentID == parent.id }
}
