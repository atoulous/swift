import Foundation

class Deck : NSObject {
    static let allSpades : [Card] = Value.allValues.map({ Card(color: Color.spade, value: $0) })
    static let allHearts : [Card] = Value.allValues.map({ Card(color: Color.heart, value: $0) })
    static let allClubs : [Card] = Value.allValues.map({ Card(color: Color.club, value: $0) })
    static let allDiamonds : [Card] = Value.allValues.map({ Card(color: Color.diamond, value: $0) })
    static let allCards : [Card] = allSpades + allHearts + allClubs + allDiamonds

    var cards : [Card] = allCards
    var discards : [Card] = []
    var outs : [Card] = []

    init (shuffled: Bool) {
        if (shuffled) {
            cards = cards.shuffle()
        }
    }

    override var description: String {
        let tab : [String] = cards.map({"\($0)"})
        return tab.joined(separator: "\n")
    }

    // Créer la méthode draw () -> Card? qui pioche la première carte de cards et la place dans outs.
    func draw() -> Card? {
        let card : Card? = cards.removeFirst()
        if (card != nil) {
            outs.append(card!)
            return card
        }
        return nil
    }

    // Créer la méthode fold(c : Card) qui place la carte c dans discards si elle appartient bien à outs.
    func fold(c : Card) {
        if let i = outs.index(of: c) {
            let card = outs.remove(at: i)
            discards.append(card)
        }
    }
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
