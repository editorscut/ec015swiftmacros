import SwiftDiagnostics

struct NameClashFixIt {
  let name: String
  
  public init(name: String) {
    self.name = name
  }
}

extension NameClashFixIt: FixItMessage {
  var message: String {
    "Replace \(name) with \(name)AsyncStream"
  }
  
  var fixItID: MessageID {
    MessageID(domain: "MakeStreamMacros",
              id: "NameClashFixIt")
  }
}
