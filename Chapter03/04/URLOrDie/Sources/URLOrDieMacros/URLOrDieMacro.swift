import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import Foundation

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
        guard let argument = node.argumentList.first?.expression else {
            fatalError("compiler bug: the macro does not have any arguments")
        }

        return "URL(string: \(argument))!"
    }
}

@main
struct URLPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        URLOrDieMacro.self,
    ]
}
