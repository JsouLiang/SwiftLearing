//: [Previous](@previous)

import Foundation

// Swift 中单项链表
class Node<T> {
    let value: T?
    let next: Node<T>?
    init(value: T?, next: Node<T>?) {
        self.value = value
        self.next = next
    }
}

let list = Node(value: 1,
                next: Node(value: 2,
                           next: Node(value: 3,
                                      next: Node(value: 4, next: nil))))

indirect enum LinkedList<Element: Comparable> {
    case empty
    case node(Element, LinkedList<Element>)
    
    func removing(_ element: Element) -> LinkedList<Element> {
        guard case let .node(value, next) = self else {
            return .empty
        }
        // 如果是当前点，就把下一个node作为上一个next
        return value == element ?
            next : LinkedList.node(value, next.removing(element))
    }
    
    func insert(_ element: Element) {
        
    }
    
    func console(_ link: LinkedList<Element>) {
        guard case let .node(value, next) = link else {
            return
        }
        print("\(value)")
        console(next)
    }
}

let linkedList = LinkedList.node(1, LinkedList.node(2, LinkedList.node(3, LinkedList.node(4, .empty))))
print(linkedList)

let result = linkedList.removing(2)
print(result)

linkedList.console(linkedList)

//: [Next](@next)
