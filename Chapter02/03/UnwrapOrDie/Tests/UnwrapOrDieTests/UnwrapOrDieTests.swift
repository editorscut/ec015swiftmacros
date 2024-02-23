import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(UnwrapOrDieMacros)
import UnwrapOrDieMacros

let testMacros: [String: Macro.Type] = [
  "unwrapOrDie": UnwrapOrDieMacro.self,
]
#endif

final class UnwrapOrDieTests: XCTestCase {
  func testMacro() throws {
#if canImport(UnwrapOrDieMacros)
    assertMacroExpansion(
      """
      #unwrapOrDie(y)
      """, 
      expandedSource:
      """
      {
        guard let x = y else {
          fatalError("y is nil")
        }
        return x
      }()
      """,
      macros: testMacros
    )
#else
    throw XCTSkip("macros require tests run on the host platform")
#endif
  }
}
