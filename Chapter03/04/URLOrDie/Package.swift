// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of
// Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
  name: "URLOrDie",
  platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), 
              .watchOS(.v6), .macCatalyst(.v13)],
  products: [
    .library(
      name: "URLOrDie",
      targets: ["URLOrDie"]
    ),
    .executable(
      name: "URLOrDieClient",
      targets: ["URLOrDieClient"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-syntax.git",
             from: "509.0.0"),
    .package(path: "../UnwrapOrDie")
  ],
  targets: [
    .macro(
      name: "URLOrDieMacros",
      dependencies: [
        .product(name: "SwiftSyntaxMacros", 
                 package: "swift-syntax"),
        .product(name: "SwiftCompilerPlugin", 
                 package: "swift-syntax"),
        .product(name: "UnwrapOrDie",
                 package: "UnwrapOrDie")
      ]
    ),
    .target(name: "URLOrDie", 
            dependencies: ["URLOrDieMacros",
                           "UnwrapOrDie"]),
    .executableTarget(name: "URLOrDieClient",
                      dependencies: ["URLOrDie"]),
    .testTarget(
      name: "URLOrDieTests",
      dependencies: [
        "URLOrDieMacros",
        .product(name: "SwiftSyntaxMacrosTestSupport", 
                 package: "swift-syntax"),
      ]
    ),
  ]
)
