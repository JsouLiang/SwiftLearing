//: Playground - noun: a place where people can play
import UIKit
/*
About Protocols

A Protocol specifies initialisers, properties, functions, subscripts and associated types required of a Swift object type (class, struct or enum) conforming to the protocol. In some languages similar ideas for requirement specifications of subsequent objects are known as ‘interfaces’.

A declared and defined Protocol is a Type, in and of itself, with a signature of its stated requirements, somewhat similar to the manner in which Swift Functions are a Type based on their signature of parameters and returns.

Swift Protocol specifications can be optional, explicitly required and/or given default implementations via a facility known as Protocol Extensions. A Swift Object Type (class, struct or enum) desiring to conform to a Protocol that’s fleshed out with Extensions for all its specified requirements needs only state its desire to conform to be in full conformance. The default implementations facility of Protocol Extensions can suffice to fulfil all obligations of conforming to a Protocol.

Protocols can be inherited by other Protocols. This, in conjunction with Protocol Extensions, means Protocols can and should be thought of as a significant feature of Swift.

Protocols and Extensions are important to realising Swift’s broader objectives and approaches to program design flexibility and development processes. The primary stated purpose of Swift’s Protocol and Extension capability is facilitation of compositional design in program architecture and development. This is referred to as Protocol Oriented Programming. Crusty old timers consider this superior to a focus on OOP design.
 */
protocol MyProtocol {
    init(value: Int)
    func doSomething() -> Bool
    var message: String {get}
    var value: Int {get set}
    subscript(index: Int) -> Int {get}
    static func instractions() -> String
    static var max: Int {get}
    static var total: Int {get set}
}

//: Protocol 中的属性(Property)必须被指定为 {get} 或者 {get set}。 {get}意味着 { get } means that the property must be gettable, and therefore it can be implemented as any kind of property. { get set } means that the property must be settable as well as gettable.

//: struct, class, enum 都可以遵循protocol
struct MyStruct : MyProtocol {
    internal static var total: Int {
        set {
            
        }
        
        get {
            return 10
        }
    }

    internal static var max: Int {
        return 100
    }

    internal static func instractions() -> String {
        return ""
    }

    internal subscript(index: Int) -> Int {
        return 1
    }

    internal var value: Int  {
        set {
            
        }
        
        get {
            return 10
        }
    }


    internal var message: String

    internal init(value: Int) {
        message = ""
        self.value = value
    }

    // Implement the protocol's requirements here
}
class MyClass : MyProtocol {
    // Implement the protocol's requirements here
    internal static var total: Int {
        set {
            
        }
        
        get {
            return 10
        }
    }
    
    internal static var max: Int {
        return 100
    }
    
    internal static func instractions() -> String {
        return ""
    }
    
    internal subscript(index: Int) -> Int {
        return 1
    }
    
    internal var value: Int  {
        set {
            
        }
        
        get {
            return 10
        }
    }

    
    internal var message: String
    
    internal required init(value: Int) {
        message = ""
        self.value = value
    }
}
enum MyEnum : MyProtocol {
    internal init(value: Int) {
        self = .caseA
    }

    case caseA, caseB, caseC

    internal var value: Int {
        set(newValue) {
            
        }
        get {
            return 10
        }
    }

    internal var message: String {
        return ""
    }

    internal static var total: Int {
        set {
            
        }
        
        get {
            return 10
        }
    }
    
    internal static var max: Int {
        return 100
    }
    
    internal static func instractions() -> String {
        return ""
    }
    
    internal subscript(index: Int) -> Int {
        return 1
    }
    
}

//: protocol 同样可以通过extension 定义默认实现（default implementation）
extension MyProtocol {
    func doSomething() -> Bool {
        print("do something")
        return true
    }
}

//: protocol 可以被当做类型去使用
func doStuff(object: MyProtocol) {
    print(object.message)
    print(object.doSomething())
}
let items: [MyProtocol] = [MyStruct(value: 10), MyClass(value: 10), MyEnum.caseA]

protocol AnotherProtocol {
    func doSomethingElse()
}

struct AnotherStruct : AnotherProtocol, MyProtocol {
    internal static var total: Int {
        set {
            
        }
        
        get {
            return 10
        }
    }
    
    internal static var max: Int {
        return 100
    }
    
    internal static func instractions() -> String {
        return ""
    }
    
    internal subscript(index: Int) -> Int {
        return 1
    }
    
    internal var value: Int  {
        set {
            
        }
        
        get {
            return 10
        }
    }
    
    
    internal var message: String
    
    internal init(value: Int) {
        message = ""
        self.value = value
    }
    
    func doSomethingElse() {
        
    }
}

func doStuffelse(objcet: MyProtocol & AnotherProtocol) {
    // TODO:
}
let otherItems: [MyProtocol & AnotherProtocol] = [AnotherStruct(value: 10)]


//: 代理模式
// 假设有两个类 Parent，Child
// 当Child发生改变时你想通知Parent
protocol ChildDelegate: class {
    func childDidSomething()
}

class Child {
    weak var delegate: ChildDelegate?
    func change() -> Void {
        delegate?.childDidSomething()
    }
}

class Parent: ChildDelegate {
    func childDidSomething() {
        print("koned the child changed")
    }
}
let child = Child()
child.delegate = Parent()

//: 可选Protocol 
//@objc public protocol OptionalProtocol {
//    optional func optionalDoSomeThing()
//}

//: Protocol 关联类型 （Associated Type requirements）
// Protocols may define associated type requirements using the associatedtype keyword
protocol Container {
    associatedtype Element
    var count: Int {get}
    subscript(index: Int) -> Element { get set }
}

func displayValues<T: Container>(container: T) {
    
}

class MyClassAss<T: Container> {
    let container: T
    init(container: T) {
        self.container = container
    }
}

/*
A type which conforms to the protocol may satisfy an associatedtype 
requirement implicitly, by providing a given type where the protocol expects the 
associatedtype to appear:*/

struct ContainerOfStruct<T>: Container {
    let count = 1
    var value: T
    subscript(index: Int) -> T {
        get {
            precondition(index == 0)
            return value
        }
        
        set {
            precondition(index == 0)
            value = newValue
        }
    }
}
let container = ContainerOfStruct(value: "sss")
/*
 (Note that to add clarity to this example, the generic placeholder type is named T – a more suitable name would be Element, which would shadow the protocol's associatedtype Element. The compiler will still infer that the generic placeholder Element is used to satisfy the associatedtype Element requirement.)
 */

struct ContainerOfOne<T>: Container {
    typealias Element = T
    let count = 1
    var value: T
    subscript(index: Int) -> Element {
        get {
            precondition(index == 0)
            return value
        }
        
        set {
            precondition(index == 0)
            value = newValue
        }
    }
}

// Expose an 8-bit integer as a collection of boolean values (one for each bit).
extension UInt8: Container {
    
    // as noted above, this typealias can be inferred
    typealias Element = Bool
    
    var count: Int { return 8 }
    subscript(index: Int) -> Bool {
        get {
            precondition(0 <= index && index < 8)
            return self & 1 << UInt8(index) != 0
        }
        set {
            precondition(0 <= index && index < 8)
            if newValue {
                self |= 1 << UInt8(index)
            } else {
                self &= ~(1 << UInt8(index))
            }
        }
    }
}
// If the conforming type already satisfies the requirement, no implementation is needed:

extension Array: Container {}  // Array satisfies all requirements, including Element

//: 类类型的Protocol
// 通过class关键字指定protocol只能类遵循
protocol ClassOnlyProtocol: class {
    
}

//struct MyStruct: ClassOnlyProtocol {
//    // Error
//}

// Using a class-only protocol allows for reference semantics when the conforming type is unknown.
protocol Foo: class {
    var bar: String {get set}
}

func taskAFoo(foo: Foo) {
    foo.bar = "new Value"
}

/*protocol Foo {
    var bar : String { get set }
}

func takesAFoo(foo:Foo) {
    foo.bar = "new value" // error: Cannot assign to property: 'foo' is a 'let' constant
}*/

protocol FooOther {
    var bar: String {get set}
}
func taskAnFoo(foo: FooOther) {
    var foo = foo  // mutable copy of foo
    foo.bar = "new value"
}

// When applying the weak modifier to a variable of protocol type, 
// that protocol type must be class-only, as weak can only be applied to reference types.


//: 给指定的类做 Protocol extension
protocol SpecificProtocol {
    func specificProtocol()
}

extension SpecificProtocol where Self : UIViewController {
    func specificProtocol() {
        print("UIViewController default protocol implemention")
    }
}

class MyViewController: UIViewController, SpecificProtocol {
    
}

let vc = MyViewController()
vc.specificProtocol()

