struct Controller {
  static let shared = Controller()
  
  public var numbers: AsyncStream<Int> { _numbers }
  private let (_numbers, numbersContinuation)
  = AsyncStream.makeStream(of: Int.self)
}

extension Controller {
  func nextNumber() {
    numbersContinuation.yield(Int.random(in: 1...99))
  }
}
