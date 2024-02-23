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

@freestanding(expression)
public macro unwrapOrDie<Wrapped>(_ value: Wrapped?) -> Wrapped
= #externalMacro(module: "UnwrapOrDieMacros",
                 type: "UnwrapOrDieMacro")
