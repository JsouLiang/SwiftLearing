//: [Previous](@previous)
import Foundation

// 泛型代码让你能够根据自定义的需求，编写出适用于任意类型、灵活可重用的函数及类型。
//: ----------
// 泛型所解决的问题
// 标准非泛型函数
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temp = a
    a = b
    b = temp
}

// 泛型版本
// 泛型版本使用了占位类型名(在这里用字母 T 来表示)来代替实际类型名
// 占位类型名没有指明 T 必须是什么类型，但是它指明了 a 和 b 必须是同一类型 T ，无论 T 代表什么类型。
// 另外一个不同之处在于这个泛型函数名( swapTwoValues(_:_:) )后面跟着占位类型名( T )，并用尖括号括起 来( <T> )。
// 这个尖括号告诉 Swift 那个 T 是 swapTwoValues(_:_:) 函数定义内的一个占位类型名，因此 S wift 不会去查找名为 T 的实际类型。
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temp = a
    a = b
    b = temp
}

//: -----------
// 泛型类型
// 非泛型版本 Int 栈
struct IntStack {
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    
    mutating func pop(item: Int) -> Int {
        return items.removeLast()
    }
}

// 泛型版本
struct Stack<Element> {
    var items = [Element]()
    mutating func push(item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

//: ----------
// 扩展一个泛型类型
// 当你扩展一个泛型类型的时候，你并不需要在扩展的定义中提供类型参数列表
// 原始类型定义中声明的类型参数列表在扩展中可以直接使用，
// 并且这些来自原始类型中的参数名称会被用作原始定义中类型参数的引用
extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}
// 这个扩展并没有定义一个类型参数列表。
// 相反的，Stack 类型已有的类型参数名称 Element，被用在扩 展中来表示计算型属性 topItem 的可选类型。

//: ----------
// 类型约束
// 类型约束语法
// 可以在一个类型参数名后面放置一个类名或者协议名，并用冒号进行分隔，来定义类型约束，它们将成为类型参数列表的一部分。

//func someFunction<T: SomeClass, U: SomeProtocl>(someT: T, someU: U) {
//    // 泛型函数部分
//}

// 这里有个名为 findStringIndex 的非泛型函数，该函数的功能是在一个 String 数组中查找给定 String 值 的索引。若查找到匹配的字符串，findStringIndex(_:_:) 函数返回该字符串在数组中的索引值，否则返回 nil
func findStringIndex(array: [String], _ valueToFind: String) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

// 下面展示了 findStringIndex(_:_:) 函数的泛型版本 findIndex(_:_:) 。请注意这个函数返回值的类型仍然是 Int? ，这是因为函数返回的是一个可选的索引数，而不是从数组中得到的一个可选值
//func findStringIndex<T>(array: [T], _ valueToFind: T) -> Int? {
//    for (index, value) in array.enumerated() {
//        if value == valueToFind {
//            return index
//        }
//    }
//}
// 上面所写的函数无法通过编译。问题出在相等性检查上，即 " if value == valueToFind "。不是所有的 Swift 类 型都可以用等式符( == )进行比较。

// Swift 标准库中定义了一个 Equatable 协议，该协议要求任何遵循 该协议的类型必须实现等式符( == )及不等符( != )，从而能对该类型的任意两个值进行比较。
func findStringIndex<T: Equatable>(array: [T], _ valueToFind: T) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}
// " findIndex(_:_:) 唯一的类型参数写做 T: Equatable ，也就意味着“任何符合 Equatable 协议的类型 T "

//: -----------
// 关联类型
// 定义一个协议时，有的时候声明一个或多个关联类型作为协议定义的一部分将会非常有用
// 关联类型为协议中的 某个类型提供了一个占位名(或者说别名)，其代表的实际类型在协议被采纳时才会被指定。
// 你可以通过 atedtype 关键字来指定关联类型。

protocol Container {
    associatedtype ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}
// 任何遵从 Container 协议的类型必须能够指定其存储的元素的类型
struct IntStackStruct: Container {
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    
    mutating func pop() -> Int {
        return items.removeLast()
    }
    
    // Container 协议实现部分
    // 指定 ItemType 为 Int 类型
    typealias ItemType = Int
    mutating func append(item: Int) {
        self.push(item: item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}

struct StackElement<Element>: Container {
    // Stack<Element> 原始部分
    var items = [Element]()
    mutating func push(item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
    
    // Container 协议部分
    mutating func append(item: Element) {
        self.push(item: item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> Element {
        return items[i]
    }
}

//: ----------
// Where 子句
// 可以在参数列表中通过  Where 子句为关联类型定义约束
// 通过 where 子句要求一个关联类型遵从某个特定的协议，以及某个特定的类型参数和关联类型必须类型相同。
func allItemMatch<C1: Container, C2: Container>(_ someContainer: C1, _ anotherContainer: C2) -> Bool
    where C1.ItemType == C2.ItemType, C1.ItemType: Equatable{
        // 检查两个容器含有相同数量的元素
        if someContainer.count != anotherContainer.count {
            return false
        }
        
        // 检查每一对元素是否相等
        for i in 0..<someContainer.count {
            if someContainer[i] != anotherContainer[i] {
                return false
            }
        }
        
        return true
}

// 上面的函数接收两个参数 someContainer, anotherContainer
// 参数 someContainer 类型为 C1, 参数 anotherContainer 类型为 C2
// C1, C2是容器的两个占位类型参数, 函数被调用时才能确定他们的具体类型
// 这个函数的类型参数列表还定义了对两个类型参数的要求:
// 1. C1必须符合 Container 协议( C1: Container)
// 2. C2必须符合 Container 协议( C2: Container)
// 3. C1的 ItemType 必须和 C2的 ItemType 类型相同( C1.ItemType == C2.ItemType)
// 4. C1的 ItemType 必须符合Equatable 协议( C1.ItemTpye: Equatable)
// C1, C2 的 ItemType 为关联类型, 所以可以通过 where 语句添加约束

//: [Next](@next)
