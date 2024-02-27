import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import Foundation
import UnwrapOrDie

/// Implementation of the `URL` macro, which takes a String
/// and produces a URL if a valid URL can be constructed
///   #URLOrDie("http://example.com")
/// produces a URL
/// `URL(string: "http://example.com")`
/// unwrapped or a fatal error.

public struct URLOrDieMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) -> ExprSyntax {
      let string = #unwrapOrDie(node.argumentList.first?.expression
                                    .as(StringLiteralExprSyntax.self)?
                                    .representedLiteralValue,
                                message: "Argument must be a String literal")
//      let _ = #unwrapOrDie(URL(string: string),
//                           message: "Invalid URL")
      return """
        URL(string: "\(raw: string)")!
        """
    }
}

@main
struct URLPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        URLOrDieMacro.self,
    ]
}
