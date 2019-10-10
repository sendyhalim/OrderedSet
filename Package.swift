// swift-tools-version:5.0
import PackageDescription

let package = Package(
  name: "OrderedSet",
  products: [
    .library(name: "OrderedSet", targets: ["OrderedSet"])
  ],
  dependencies: [
    .package(url: "https://github.com/Quick/Quick", .upToNextMajor(from: "2.2.0")),
    .package(url: "https://github.com/Quick/Nimble", .upToNextMajor(from: "8.0.4")),
  ],
  targets: [
    .target(
      name: "OrderedSet",
      dependencies: [],
      path: "./Sources/"
    ),
    .testTarget(
      name: "OrderedSetTest",
      dependencies: ["Quick", "Nimble", "OrderedSet"],
      path: "./Tests/"
    )
  ]
)
