# OrderedSet
Swift ordered set data structure

# Installation
## Carthage
Add the following to your Cartfile:

```
github "sendyhalim/OrderedSet"
```

Then run `carthage update`

# Quick Usage
```swift
import OrderedSet

let users = OrderedSet(elements: ["john", "doe"])
users.has(element: "john") // true

// Add element to set
users.append(element: "foo")
users.append(elements: ["foo", "bar"])

// Insert element at index, wont' do anything if "foo" is already in the set
users.insert(element: "foo", atIndex: 1)

// Remove element
users.remove(index: 1)
users.remove(element: "foo")

// Get number of elements
users.count

// Swap element position
users.swap(fromIndex: 1, toIndex: 3)

// For loop
for user in users {
  print(user)
}
```

# License
MIT

![Yeay](https://media.giphy.com/media/l4FGGIIZWoH1AhPIQ/giphy.gif)
