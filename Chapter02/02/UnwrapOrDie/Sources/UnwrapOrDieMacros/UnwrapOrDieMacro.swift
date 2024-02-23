import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

/// Implementation of the `unwrapOrDie` macro, which takes an optional
/// of any type and produces the unwrapped value or a fatalError().
///
/// If `y` is an Optional, `unwrapOrDie(y)` expands to:
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
public struct UnwrapOrDieMacro: ExpressionMacro {
  public static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) -> ExprSyntax {
    guard let argument = node.argumentList.first?.expression else {
      fatalError("compiler bug: the macro does not have any arguments")
    }
    return "\(argument)!"
  }
}

@main
struct UnwrapOrDiePlugin: CompilerPlugin {
  let providingMacros: [Macro.Type] = [
    UnwrapOrDieMacro.self,
  ]
}
