import SwiftUI

struct ContentView {
  @State private var currentNumber = 0
}

extension ContentView: View {
  var body: some View {
    VStack {
      Text(currentNumber.description)
        .font(.largeTitle)
        .padding()
      Button("Next Number") {
        Controller.shared.nextNumber()
      }
    }
    .task {
      await updateNumber()
    }
  }
}

extension ContentView {
  private func updateNumber() async {
    for await number in Controller.shared.numbers {
      currentNumber = number
    }
  }
}

#Preview {
  ContentView()
}
