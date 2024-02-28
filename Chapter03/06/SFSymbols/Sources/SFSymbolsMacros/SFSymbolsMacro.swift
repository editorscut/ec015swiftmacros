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
    let firstArgument = firstArgument(node: node)
    let userEnteredStrings = strings(from: firstArgument)
    let allCases = allCases(from: userEnteredStrings)
    
    return [
    """
    enum SFSymbol: String {
      \(raw: allCases)
      var name: String {
        rawValue
      }
    }
    """
    ]
  }
}

extension SFSymbolsMacro {
  private static func firstArgument(node: some FreestandingMacroExpansionSyntax)
  -> LabeledExprListSyntax {
    guard let argument
            = node.argumentList.as(LabeledExprListSyntax.self) else {
      fatalError("SFSymbols requires one argument")
    }
    return argument
  }
  
  private static func strings(from argument: LabeledExprListSyntax)
  -> [String] {
    argument
      .children(viewMode: .all)
      .compactMap{$0.as(LabeledExprSyntax.self)}
      .map(\.expression)
      .compactMap {$0.as(StringLiteralExprSyntax.self)}
      .compactMap {$0.representedLiteralValue}
  }
  
  private static func enumCase(from string: String) -> String {
    var components = string.split(separator: ".")
    let base = components.removeFirst()
    let camelCase = components.reduce(base) { $0 + $1.capitalized}
    return """
    case \(camelCase) = "\(string)"
    """
  }
  
  private static func allCases(from strings: [String]) -> String {
    strings
      .map{ enumCase(from: $0) }
      .reduce(""){ $0 + $1 + "\n" }
  }
}

@main
struct SFSymbolsPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        SFSymbolsMacro.self,
    ]
}
