import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(MakeStreamMacros)
import MakeStreamMacros

let testMacros: [String: Macro.Type] = [
    "MakeStream": MakeStreamMacro.self,
]
#endif

final class MakeStreamTests: XCTestCase {
    func testMacro() throws {
        #if canImport(MakeStreamMacros)
        assertMacroExpansion(
            """
            @MakeStream
            struct Example {
            }
            """,
            expandedSource: """
            struct Example {

                public var numbers: AsyncStream<Int> {
                    _numbers
                }
                private let (_numbers, numbersContinuation)
                = AsyncStream.makeStream(of: Int.self)
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}
