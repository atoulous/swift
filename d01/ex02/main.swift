print("spades deck :", "\n")
let spades = Deck.allSpades.map({ print($0) })
print("\n", "cards deck :", "\n")
let cards = Deck.allCards.map( {print($0) })
print("\n", Deck.allCards.count, "cards")
