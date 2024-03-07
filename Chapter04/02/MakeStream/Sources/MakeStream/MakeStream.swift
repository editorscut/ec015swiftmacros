/// A macro that creates an AsyncStream and continuation
/// source code that generated the value. For example,
///
///     #MakeStream
///
/// produces the following (for now):
/// ```
///   public var numbers: AsyncStream<Int> { _numbers }
///   private let (_numbers, numbersContinuation)
///   = AsyncStream.makeStream(of: Int.self)
///```

@freestanding(declaration,
              names: named(numbers),
                     named(_numbers),
                     named(numbersContinuation))
public macro MakeStream()
= #externalMacro(module: "MakeStreamMacros",
                 type: "MakeStreamMacro")
