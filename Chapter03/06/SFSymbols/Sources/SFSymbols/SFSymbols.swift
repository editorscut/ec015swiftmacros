/// A macro that takes one or more strings and creates cases for
/// them in an enum named SFSymbol
///
/// ```
/// #SFSymbols("circle", "arrow.right")
/// ```
/// produces
/// ```
///    enum IconSymbols: String {
///
///      case circle = "circle"
///      case arrowRight = "arrow.right"
///
///      var name: String {
///        rawValue
///      }
///   }
/// ```
@freestanding(declaration, names: named(SFSymbol))
public macro SFSymbols(_ values: String...)
= #externalMacro(module: "SFSymbolsMacros",
                 type: "SFSymbolsMacro")
