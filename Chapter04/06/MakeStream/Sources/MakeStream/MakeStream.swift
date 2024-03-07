/// A  member macro that creates an AsyncStream of a given type
/// and its associated continuation as well as a computed property for
/// the AsyncStream to a struct, class or actor.
/// For example,
///     ```
///     @MakeStream(of: Int.self,
///                 named: "numbers")
///     class Example {
///     }
///     ```
///
/// produces the following:
///   ```
///   class Example {
///
///       public var numbers: AsyncStream<Int> {
///           _numbers
///       }
///
///       private let (_numbers, numbersContinuation)
///       = AsyncStream.makeStream(of: Int.self)
///   }
///   ```

@attached(member,
          names: arbitrary)
public macro MakeStream<T>(of: T.Type,
                           named: String)
= #externalMacro(module: "MakeStreamMacros",
                 type: "MakeStreamMacro")
