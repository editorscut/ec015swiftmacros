
/// A macro that produces a URL from a String
/// if a valid URL can be constructed
///
///     #URLOrDie("http://example.com")
///
/// produces a URL
///
/// `URL(string: "http://example.com")`
///
/// unwrapped or a fatal error

import Foundation

@freestanding(expression)
public macro URLOrDie(_ string: String) -> (URL)
= #externalMacro(module: "URLOrDieMacros",
                 type: "URLOrDieMacro")
