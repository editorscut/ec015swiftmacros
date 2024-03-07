import MakeStream

@MakeStream(of: Int.self,
            named: "numbers")
struct Example {
  func useIt() {
    numbersContinuation.yield(3)
  }
}
