import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

/// Implementation of the `MakeStream` macro,
/// that creates an AsyncStream and continuation
/// source code that generates the value inside a struct, class or actor.
/// For example,
///     ```
///     @MakeStream
///     class Example {
///     }
///     ```
///
/// produces the following (for now):
///   ```
///   class Example {
///     public var numbers: AsyncStream<Int> { _numbers }
///     private let (_numbers, numbersContinuation)
///     = AsyncStream.makeStream(of: Int.self)
///   }
///   ```
public struct MakeStreamMacro: MemberMacro {
  public static func expansion(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    return [
    """
    public var numbers: AsyncStream<Int> { _numbers }
    private let (_numbers, numbersContinuation)
    = AsyncStream.makeStream(of: Int.self)
    """
    ]
  }
}

@main
struct MakeStreamPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        MakeStreamMacro.self,
    ]
}
