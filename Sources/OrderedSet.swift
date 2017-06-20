//
//  OrderedSet.swift
//  OrderedSet
//
//  Created by Sendy Halim on 6/16/17.
//  Copyright © 2017 Sendy Halim. All rights reserved.
//

import Foundation

public struct OrderedSet<T: Hashable>: ExpressibleByArrayLiteral {
  fileprivate var indexByElement: [T: Int] = [:]
  fileprivate var elements: Array<T> = []

  public var count: Int {
    return elements.count
  }

  public init(elements: [T]) {
    append(elements: elements)
  }

  public init(arrayLiteral elements: T...) {
    append(elements: elements)
  }

  ///  Check if element exists in set
  ///
  ///  - parameter element: Element to be checked
  ///
  ///  - returns: Boolean
  public func has(element: T) -> Bool {
    return indexByElement[element] != nil
  }

  ///  Insert element at the given index
  ///  - If inserted at the first index, it will prepend element to the set
  ///  - If inserted at the end index, it iwll append element to the set
  ///  - If inserted at the middle it will shift elements
  ///    around it (will not replace another element at the given index)
  ///
  ///  - parameter element: Element to be inserted
  ///  - parameter atIndex: The index where the element should be inserted
  public mutating func insert(element: T, atIndex: Int) {
    if atIndex == 0 {
      elements = [element] + elements
    } else if atIndex == count {
      elements.append(element)
    } else {
      let head = elements[0..<atIndex]
      let tail = elements[atIndex..<count]

      elements = head + [element] + tail
    }

    // Just update all elements index for simplicity sake's,
    // because the elements count in this app should be relatively low, it's ok to be O(n)
    for (index, element) in elements.enumerated() {
      indexByElement[element] = index
    }
  }

  ///  Append elements to the set
  ///
  ///  - parameter elements: elements to be appended
  public mutating func append(elements: [T]) {
    for element in elements {
      append(element: element)
    }
  }

  ///  Append element to the set
  ///
  ///  - parameter element: Element to be appended
  public mutating func append(element: T) {
    if indexByElement[element] != nil {
      return
    }

    indexByElement[element] = elements.count
    elements.append(element)
  }

  ///  Swap position of elements
  ///
  ///  - parameter fromIndex: Index of first element to be swapped from
  ///  - parameter toIndex:   Index of second element to be swapped to
  public mutating func swap(fromIndex: Int, toIndex: Int) {
    guard validIndex(index: fromIndex) && validIndex(index: toIndex) else {
      return
    }

    let fromElement = elements[fromIndex]
    let toElement = elements[toIndex]

    indexByElement[fromElement] = toIndex
    indexByElement[toElement] = fromIndex

    elements[fromIndex] = toElement
    elements[toIndex] = fromElement
  }

  private func validIndex(index: Int) -> Bool {
    return index > -1 && index < elements.count
  }

  ///  Remove element from the set
  ///
  ///  - parameter element: Element to be removed
  ///
  ///  - returns: Removed element
  @discardableResult
  public mutating func remove(element: T) -> T? {
    guard let index = indexByElement[element] else {
      return .none
    }

    return remove(element: element, index: index)
  }

  ///  Remove element at the given index
  ///
  ///  - parameter index: Index of element to be removed
  ///
  ///  - returns: Removed element
  @discardableResult
  public mutating func remove(index: Int) -> T? {
    guard validIndex(index: index) else {
      return .none
    }

    let element = elements[index]

    return remove(element: element, index: index)
  }

  mutating private func remove(element: T, index: Int) -> T {
    indexByElement[element] = nil

    return elements.remove(at: index)
  }
}

extension OrderedSet: CustomStringConvertible {
  public var description: String {
    return elements.reduce("OrderedSet \(count) objects: ") {
      "\($0), \($1)"
    }
  }
}

extension OrderedSet: MutableCollection {
  /// Returns the position immediately after the given index.
  ///
  /// - Parameter i: A valid index of the collection. `i` must be less than
  ///   `endIndex`.
  /// - Returns: The index value immediately after `i`.
  public func index(after i: Int) -> Int {
    return i + 1
  }

  public typealias Index = Int

  public var startIndex: Int {
    return 0
  }

  public var endIndex: Int {
    return elements.count
  }

  public subscript(index: Index) -> T {
    get {
      return elements[index]
    }

    set {
      let oldValue = elements[index]
      indexByElement[oldValue] = nil
      indexByElement[newValue] = index
      elements[index] = newValue
    }
  }
}

extension OrderedSet: Sequence {
  public typealias Iterator = OrderedSetGenerator<T>

  public func makeIterator() -> Iterator {
    return OrderedSetGenerator(set: self)
  }
}

public struct OrderedSetGenerator<T: Hashable>: IteratorProtocol {
  public typealias Element = T

  var generator: IndexingIterator<Array<T>>

  init(set: OrderedSet<T>) {
    generator = set.elements.makeIterator()
  }

  public mutating func next() -> T? {
    return generator.next()
  }
}
