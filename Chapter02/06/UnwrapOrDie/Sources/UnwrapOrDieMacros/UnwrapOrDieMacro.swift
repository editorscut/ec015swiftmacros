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
    let argumentList = node.argumentList
    
    guard let optional = argumentList.first?.expression else {
      fatalError("unwrapOrDie must have at least one argument")
    }
    
    var reason = "\(optional) is nil"
    
    if let message = argumentList
      .first(where: {$0.label?.text == "message"})?
      .expression
      .as(StringLiteralExprSyntax.self)?
      .representedLiteralValue {
      reason = message
    }

    return """
        {
          guard let x = \(raw: optional) else {
            fatalError("\(raw: reason)")
          }
          return x
        }()
        """
  }
}

@main
struct UnwrapOrDiePlugin: CompilerPlugin {
  let providingMacros: [Macro.Type] = [
    UnwrapOrDieMacro.self,
  ]
}
