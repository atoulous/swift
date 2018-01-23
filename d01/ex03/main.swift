let shuffled = Deck.allSpades.shuffle()
let map = Deck.allSpades.map({print($0.value)})
print("\n", "Shuffle spades :")
let map2 = shuffled.map({print($0.value)})
