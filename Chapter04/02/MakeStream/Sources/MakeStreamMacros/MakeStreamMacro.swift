import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

/// Implementation of the `MakeStream` macro,
///  that creates an AsyncStream and continuation
/// source code that generated the value. For example,
///
///     #MakeStream
///
/// produces the following (for now):
/// ```
///   public var numbers: AsyncStream<Int> { _numbers }
///   private let (_numbers, numbersContinuation)
///   = AsyncStream.makeStream(of: Int.self)
///```
///
public struct MakeStreamMacro: DeclarationMacro {
  public static func expansion(of node: some FreestandingMacroExpansionSyntax,
                               in context: some MacroExpansionContext)
  throws -> [DeclSyntax] {
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
