import Foundation

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
			return value == object.value && color == object.color
		} else {
			return false
		}
	}

	static func ==(left: Card, right: Card) -> Bool {
		return left.isEqual(right)
	}
}
