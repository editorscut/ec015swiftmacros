import SwiftUI
import UnwrapOrDie

struct ContentView {
  private let sfSymbolName: String? = nil
}

extension ContentView: View {
  var body: some View {
    VStack {
      Image(systemName: #unwrapOrDie(sfSymbolName))
        .imageScale(.large)
        .foregroundStyle(.tint)
      Text("Hello, world!")
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
