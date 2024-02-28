import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(SFSymbolsMacros)
import SFSymbolsMacros

let testMacros: [String: Macro.Type] = [
    "SFSymbols": SFSymbolsMacro.self,
]
#endif

final class SFSymbolsTests: XCTestCase {
    func testMacro() throws {
        #if canImport(SFSymbolsMacros)
        assertMacroExpansion(
            """
            #SFSymbols("circle", "arrow.right")
            """,
            expandedSource: """
            enum SFSymbol: String {
              case circle = "circle"
              case arrowRight = "arrow.right"

              var name: String {
                rawValue
              }
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }

    func testMacroWithNonSymbolName() throws {
        #if canImport(SFSymbolsMacros)
        assertMacroExpansion(
            """
            #SFSymbols("circle", "arrow.right", "glob")
            """,
            expandedSource: """
            enum SFSymbol: String {
              case circle = "circle"
              case arrowRight = "arrow.right"
              case glob = "glob"

              var name: String {
                rawValue
              }
            }
            """,
            diagnostics:
              [DiagnosticSpec(message: SFSymbolsDiagnostic(inputString: "glob")
                                         .message,
                              line: 1,
                              column: 1)],
            
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}
