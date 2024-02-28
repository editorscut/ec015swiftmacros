import URLOrDie
import Foundation

let exampleURL = #URLOrDie("http://example.com")

print("exampleURL = \(exampleURL)")

//let invalidURL = #URLOrDie("http://example .com")
