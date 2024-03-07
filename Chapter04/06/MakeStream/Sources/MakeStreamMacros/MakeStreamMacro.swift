import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftDiagnostics

/// Implementation of the `MakeStream` macro, 
/// that creates an AsyncStream of a given type
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
public struct MakeStreamMacro: MemberMacro {
  public static func expansion(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    check(declaration,
          in: node,
          context: context)
    let (typeArgument, nameArgument) = arguments(from: node)
    guard let type = type(from: typeArgument),
          let name = name(from: nameArgument) else {
      fatalError("Arguments are incorrect")
    }
    return [
      "public var \(raw: name): AsyncStream<\(type)> { _\(raw: name)}",
    """
    private let (_\(raw: name), \(raw: name)Continuation)
    = AsyncStream.makeStream(of: \(type).self)
    """
    ]
  }
}

extension MakeStreamMacro {
  private static func arguments(from node: AttributeSyntax) 
  -> (LabeledExprSyntax, LabeledExprSyntax) {
    guard case let .argumentList(argumentList) = node.arguments,
          let typeArgument 
            = argumentList.first(where: { $0.label?.text == "of"}),
          let nameArgument 
            = argumentList.first(where: { $0.label?.text == "named"})
    else {
      fatalError("Incorrect arguments")
    }
    return (typeArgument, nameArgument)
  }
  
  private static func type(from typeArgument: LabeledExprSyntax) -> ExprSyntax? {
    typeArgument
      .expression
      .as(MemberAccessExprSyntax.self)?
      .base
  }
  
  private static func name(from nameArgument: LabeledExprSyntax) -> String? {
    nameArgument
      .expression
      .as(StringLiteralExprSyntax.self)?
      .representedLiteralValue
  }
}

extension MakeStreamMacro {
  private static func check(_ declaration: some DeclGroupSyntax,
                            in node: AttributeSyntax,
                            context: some MacroExpansionContext) {
    guard declaration.is(ActorDeclSyntax.self) ||
            declaration.is(ClassDeclSyntax.self) ||
            declaration.is(StructDeclSyntax.self) else {
      context.diagnose(Diagnostic(node: node,
                                  message: declGroupDiagnostic))
      return
    }
  }
}



@main
struct MakeStreamPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        MakeStreamMacro.self,
    ]
}
