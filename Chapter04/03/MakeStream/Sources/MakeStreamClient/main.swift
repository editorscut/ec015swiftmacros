import MakeStream

@MakeStream
struct Example {
  func useIt() {
    numbersContinuation.yield(Int.random(in: 1...99))
  }
}
