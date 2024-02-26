/// A macro that unwraps an optional or results in a fatalError()
///
/// For example, the expression
/// `let x = #unwrapOrDie(y)`
///
/// is equivalent to
/// ```
/// guard let x = y else {
///   fatalError("y is nil")
/// }
/// ```
///
/// So `#unwrapOrDie(y)` expands to:
///
/// ```
/// {
///   guard let x = y else {
///     fatalError("y is nil")
///   }
///   return x
/// }()
/// ```
///
/// The macro can also accept a message it uses in the fatalError()
///
/// For example, the expression
/// ```
/// let x = #unwrapOrDie(y,
///                      message: "some reason")
/// ```
///
/// expands to:
///
///
/// ```
/// {
///   guard let x = y else {
///     fatalError("some reason")
///   }
///   return x
/// }()
/// ```
///

@freestanding(expression)
public macro unwrapOrDie<Wrapped>(_ value: Wrapped?,
                                  message: String = "") -> Wrapped
= #externalMacro(module: "UnwrapOrDieMacros",
                 type: "UnwrapOrDieMacro")
