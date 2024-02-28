import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

/// Implementation of a macro that takes one or more strings and
/// creates cases for them in an enum
///
/// ```
/// #SFSymbols("circle", "arrow.right")
/// ```
/// produces
/// ```
///    enum SFSymbol: String {
///
///      case circle = "circle"
///      case arrowRight = "arrow.right"
///
///      var name: String {
///        rawValue
///      }
///   }
/// ```
public struct SFSymbolsMacro: DeclarationMacro {
  public static func expansion(of node: some FreestandingMacroExpansionSyntax,
                               in context: some MacroExpansionContext)
  throws -> [DeclSyntax] {
    return [
    """
    enum SFSymbol: String {
      case circle = "circle"
      case arrowRight = "arrow.right"
    
      var name: String {
        rawValue
      }
    }
    """
    ]
  }
}

@main
struct SFSymbolsPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        SFSymbolsMacro.self,
    ]
}
