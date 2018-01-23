import Foundation

class Deck : NSObject {
    static let allSpades : [Card] = Value.allValues.map({ Card(color: Color.spade, value: $0) })
    static let allHearts : [Card] = Value.allValues.map({ Card(color: Color.heart, value: $0) })
    static let allClubs : [Card] = Value.allValues.map({ Card(color: Color.club, value: $0) })
    static let allDiamonds : [Card] = Value.allValues.map({ Card(color: Color.diamond, value: $0) })
    static let allCards : [Card] = allSpades + allHearts + allClubs + allDiamonds
}

extension Array {
    func shuffle() -> Array {
        if count < 2 { return self }
        var list = self
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            list.swapAt(i, j)
        }
        return list
    }
}
