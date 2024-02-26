
/// A macro that produces a URL from a String
/// if a valid URL can be constructed
///
///     #URL("http://example.com")
///
/// produces a URL
///
/// `URL(string: "http://example.com")`
///
/// unwrapped or an error.

import Foundation

@freestanding(expression)
public macro URL(_ string: String) -> URL
= #externalMacro(module: "URLMacros",
                 type: "URLMacro")
