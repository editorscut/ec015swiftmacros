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
            #unwrapOrDie(a + b)
            """,
            expandedSource: """
            (a + b, "a + b")
            """,
            macros: testMacros
    )
#else
    throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
  }
}
