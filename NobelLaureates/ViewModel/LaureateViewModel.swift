

import Foundation


struct LaureateViewModel: Equatable, Comparable {
    let rank: Double
    let fullName: String
    let place: String
    let year: String
    let location: String
    
    static func < (lhs: LaureateViewModel, rhs: LaureateViewModel) -> Bool {
        return lhs.rank < rhs.rank
    }
}
