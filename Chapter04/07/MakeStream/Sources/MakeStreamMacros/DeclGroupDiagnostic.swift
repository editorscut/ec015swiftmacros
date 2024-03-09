import SwiftDiagnostics

public let declGroupDiagnostic = DeclGroupDiagnostic()

public struct DeclGroupDiagnostic {
}

extension DeclGroupDiagnostic: DiagnosticMessage {
  public var message: String {
    "@MakeStream can only be applied to a struct, class, or actor"
  }
  
  public var diagnosticID: MessageID {
    MessageID(domain: "MakeStreamMacros",
              id: "DeclGroupDiagnostic")
  }
  
  public var severity: DiagnosticSeverity {
    .error
  }
}
