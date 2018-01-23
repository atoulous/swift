var deckSorted = Deck(shuffled: false)
var deckShuffled = Deck(shuffled:true)

print("sorted : ", "\n", deckSorted, "\n")
print("shuffled : ", "\n", deckShuffled, "\n")

print("draw sorted: ", deckSorted.draw()!)
print("draw shuffled: ", deckShuffled.draw()!, "\n")

print("draw sorted 2 : ", deckSorted.draw()!)
print("draw shuffled 2 : ", deckShuffled.draw()!, "\n")

print("outs sorted : ", deckSorted.outs)
print("outs shuffled : ", deckShuffled.outs, "\n")

let aceSpade = Card(color: Color.spade, value: Value.ace)

deckSorted.fold(c: aceSpade)
deckShuffled.fold(c :aceSpade)

print(deckSorted.discards)
print(deckShuffled.discards)
