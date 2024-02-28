import SwiftDiagnostics

public struct SFSymbolsDiagnostic {
  public let inputString: String
  
  public init(inputString: String) {
    self.inputString = inputString
  }
}

extension SFSymbolsDiagnostic: DiagnosticMessage {
  public var message: String {
    "Cannot find SF Symbol corresponding to \(inputString)."
  }
  
  public var diagnosticID: MessageID {
    MessageID(domain: "SFSymbolsMacros",
              id: "Invalid Input String")
  }
  
  public var severity: DiagnosticSeverity {
    .error
  }
}
