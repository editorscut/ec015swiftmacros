import MakeStream

@MakeStream(of: Int.self,
            named: "numbers")
class Example {
  func useIt() {
    numbersContinuation.yield(3)
  }
}
