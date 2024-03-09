import SwiftDiagnostics

public struct NameClashDiagnostic {
  let name: String
  
  public init(name: String) {
    self.name = name
  }
}

extension NameClashDiagnostic: DiagnosticMessage {
  public var message: String {
    "\(name) is the name of an existing member"
  }
  
  public var diagnosticID: MessageID {
    MessageID(domain: "MakeStreamMacros",
              id: "NameClashDiagnostic")
  }
  
  public var severity: DiagnosticSeverity {
    .error
  }
}
