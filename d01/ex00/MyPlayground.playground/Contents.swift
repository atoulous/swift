//: Playground - noun: a place where people can play

import UIKit

enum Color : String {
    case heart = "heart"
    case club = "club"
    case spade = "spade"
    case diamond = "diamond"
    static let allColors : [Color] = [heart, club, spade, diamond]
}

enum Value : Int {
    case ace = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6
    case seven = 7
    case eight = 8
    case nine = 9
    case ten = 10
    case jack = 11
    case queen = 12
    case king = 13
    static let allValues : [Value] = [ace, two, three, four, five, six, seven, eight, nine, ten, jack, queen, king]
}

class Card : NSObject {
    var color : Color
    var value : Value
    
    init (color: Color, value: Value) {
        self.color = color
        self.value = value
    }
    
    override var description : String {
        return "\(value) of \(color)"
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let object = object as? Card {
            return value == object.value
        } else {
            return false
        }
    }
}

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
        var tab : [String] = cards.map({"\($0)"})
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

var deckSorted = Deck(shuffled: true)
var deckShuffled = Deck(shuffled:false)

print(deckSorted, "\n")
print("shuffled : ", "\n", deckShuffled, "\n")

print("draw sorted: ", deckSorted.draw()!)
print("draw shuffled: ", deckShuffled.draw()!)

print("draw sorted 2 : ", deckSorted.draw()!)
print("draw shuffled 2 : ", deckShuffled.draw()!)

print("outs sorted : ", deckSorted.outs)
print("outs shuffled : ", deckShuffled.outs)

let aceSpade = Card(color: Color.spade, value: Value.ace)

deckSorted.fold(c: aceSpade)
deckShuffled.fold(c :aceSpade)

print(deckSorted.discards)
print(deckShuffled.discards)
