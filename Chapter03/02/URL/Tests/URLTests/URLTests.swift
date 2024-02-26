import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import Foundation

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(URLMacros)
import URLMacros

let testMacros: [String: Macro.Type] = [
    "URL": URLMacro.self,
]
#endif

final class URLTests: XCTestCase {
  func testMacro() throws {
#if canImport(URLMacros)
    assertMacroExpansion(
            """
            #URL("http://example.com")
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
  func testInvalidStringInMacro() throws {
#if canImport(URLMacros)
    assertMacroExpansion(
          """
          #URL("http://example .com")
          """,
          expandedSource: """
          #URL("http://example .com")
          """,
          diagnostics: [DiagnosticSpec(message: "invalidURL",
                                       line: 1,
                                       column: 1,
                                       severity: .error)],
          macros: testMacros
    )
#else
    throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
  }
  func testMultiSegmentStringLiteral() throws {
#if canImport(URLMacros)
    assertMacroExpansion(
          """
          #URL("http://" + "example.com")
          """,
          expandedSource: """
            #URL("http://" + "example.com")
            """,
          diagnostics: [DiagnosticSpec(message: "argumentMustBeASingleStringLiteral",
                                       line: 1,
                                       column: 1,
                                       severity: .error)],
          macros: testMacros
    )
#else
    throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
  }
  
}
