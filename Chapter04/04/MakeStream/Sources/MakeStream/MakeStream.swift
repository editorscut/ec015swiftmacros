/// A  member macro that creates an AsyncStream and continuation
/// source code that generate the values inside a struct, class or actor.
/// For example,
///     ```
///     @MakeStream
///     class Example {
///     }
///     ```
///
/// produces the following (for now):
///   ```
///   class Example {
///     public var numbers: AsyncStream<Int> { _numbers }
///     private let (_numbers, numbersContinuation)
///     = AsyncStream.makeStream(of: Int.self)
///   }
///   ```

@attached(member,
          names: named(numbers),
                 named(_numbers),
                 named(numbersContinuation))
public macro MakeStream()
= #externalMacro(module: "MakeStreamMacros",
                 type: "MakeStreamMacro")
