import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import Foundation

/// Implementation of the `URL` macro, which takes a String
/// and produces a URL if a valid URL can be constructed
///   #URL("http://example.com")
/// produces a URL
/// `URL(string: "http://example.com")`
/// unwrapped or an error.

public struct URLMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        guard let stringLiteral
                = node.argumentList.first?.expression
                      .as(StringLiteralExprSyntax.self),
              stringLiteral.segments.count == 1 else {
          throw URLMacroError.argumentMustBeASingleStringLiteral
        }
      
      guard let string = stringLiteral.representedLiteralValue,
            let _ = URL(string: string)
      else {
        throw URLMacroError.invalidURL
      }

      return """
        URL(string: "\(raw: string)")!
        """
    }
}

@main
struct URLPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        URLMacro.self,
    ]
}
