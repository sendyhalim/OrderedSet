
import PackageDescription

let package = Package(
  name: "OrderedSet",
  products: [
    .library(name: "OrderedSet", targets: ["OrderedSet"])
  ],
  dependencies: [],
  targets: [
    .target(
      name: "OrderedSet",
      dependencies: []
    )
  ]
)
