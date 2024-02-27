import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(URLOrDieMacros)
import URLOrDieMacros

let testMacros: [String: Macro.Type] = [
    "URLOrDie": URLOrDieMacro.self,
]
#endif

final class URLOrDieTests: XCTestCase {
  func testMacro() throws {
#if canImport(URLOrDieMacros)
    assertMacroExpansion(
            """
            #URLOrDie("http://example.com")
            """,
            expandedSource: """
            URL(string: "http://example.com")!
            """,
            macros: testMacros
    )
#else
    throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
  }
}
