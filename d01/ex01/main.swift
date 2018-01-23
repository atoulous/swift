let card1 = Card(color: Color.spade, value: Value.ace)
let card2 = Card(color: Color.diamond, value: Value.two)

print("Card(color: Color.spade, value: Value.ace) -> ", card1)
print("Card(color: Color.diamond, value: Value.two) -> ", card2)
print("card1.isEqual(card2) -> ", card1 == card2)

let card3 = Card(color: Color.heart, value: Value.queen)
let card4 = Card(color: Color.heart, value: Value.queen)

print("\n", "Card(color: Color.heart, value: Value.queen) -> ", card3)
print("Card(color: Color.heart, value: Value.queen) -> ", card4)
print("card3.isEqual(card4) -> ", card3 == card4)
