struct Controller {
  static let shared = Controller()
  
  let (numbers, numbersContinuation)
  = AsyncStream.makeStream(of: Int.self)
}

extension Controller {
  func nextNumber() {
    numbersContinuation.yield(Int.random(in: 1...99))
  }
}
