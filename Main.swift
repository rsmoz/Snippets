import Foundation

extension String {
	func replacing(mapping: [String:String]) -> String {
		return mapping.reduce(self) { acc, kv in
		  let (from, to) = kv
		  return acc.stringByReplacingOccurrencesOfString(from, withString: to)
		}
	}
	func removing(toRemove: String...) -> String {
		return self.replacing(Dictionary<String,String>(toRemove.map {($0, "")}))
	}
}

extension Dictionary { //From SwiftCheck
	init<S : SequenceType where S.Generator.Element == Element>(_ pairs : S) {
		self.init()
		var g = pairs.generate()
		while let (k, v) : (Key, Value) = g.next() {
			self[k] = v
		}
	}
}

extension Array {

	func separated() -> Array<(Element, Element)> {
		let withIndex: [(Int,Element)] = self.enumerate().map{ ($0.0 + 1, $0.1) }

		let separated: ([Element], [Element]) = withIndex.reduce(([],[])) { acc, elem in
			let (ind, value) = elem

			if ind % 2 == 0 {
				return (acc.0 + [value], acc.1)
			}
			else {
				return (acc.0, acc.1 + [value])
			}
		}

		return [(Element, Element)](Zip2Sequence(separated.1, separated.0))

	}
}


