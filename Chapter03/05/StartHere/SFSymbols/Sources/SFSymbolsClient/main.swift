import SFSymbols

let a = 17
let b = 25

let (result, code) = #SFSymbols(a + b)

print("The value \(result) was produced by the code \"\(code)\"")
