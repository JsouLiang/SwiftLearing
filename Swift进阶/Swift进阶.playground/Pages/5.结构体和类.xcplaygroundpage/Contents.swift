//: [Previous](@previous)

import UIKit

// 结构体和类的主要不同点：
// 1. 结构体和枚举是值类型，类是引用类型
// 2. 结构体可以被直接持有及访问，而类的实例只能通过引用来间接访问。结构体不会被引用，但会被复制，也就是说结构体的持有者是唯一的，而类却可以有很多个持有者
// 3. 使用类我们可以通过继承来共享代码，而结构体是不能被继承的
//: 值类型

//: 可变性
let mutableArray: NSMutableArray = [1, 2, 3]
// 当迭代一个NSMutableArray，你不能改变它，因为迭代器是基于原始的数组工作的，改变它将会破坏迭代器的内部状态
//for _ in mutableArray {
//    mutableArray.removeLastObject()
//}

var swiftMutableArray = [1, 2, 3]
for _ in swiftMutableArray {
    swiftMutableArray.removeAll()
}
swiftMutableArray

class BinaryScanner {
    var position: Int
    let data: Data
    init(data: Data) {
        self.position = 0
        self.data = data
    }
}

extension BinaryScanner {
    func scanByte() -> UInt8? {
        // 如果在一个线程(A)中判断position < data.endIndex 为真，此时切换到线程，执行操作到最后字节，此时再次切换到线程A，执行position += 1，从数组中取值发生越界
        guard position < data.endIndex else {
            return  nil
        }
        position += 1
        return data[position - 1]
    }
}

func scanRemainingBytes(scanner: BinaryScanner) {
    while let byte = scanner.scanByte() {
        print(byte)
    }
}

let scanner = BinaryScanner(data: "hi".data(using: .utf8)!)
scanRemainingBytes(scanner: scanner)

// 使用GCD来模拟竞态条件，从两个线程调用scanRemainingBytes
//for _ in 0..<Int.max {
//    let newScanner = BinaryScanner(data: "hi".data(using: .utf8)!)
//    DispatchQueue.global().async {
//        scanRemainingBytes(scanner: newScanner)
//    }
//    scanRemainingBytes(scanner: newScanner)
//}
// 如果我们BinaryScanner使用值类型(结构体)的话,这个问题就会出现了

//: 结构体
// 值类型意味着一个值变量被复制时，这个值本身也会被复制，不只限于对这个值的引用的复制
struct Point {
    var x: Int
    var y: Int
}
let origin = Point(x: 0, y: 0)
// origin.x = 10   // Error: Swift 中的结构体拥有值语义，对于使用 let 定义的结构体变量，我们不能改变它的任何 属性。
var thirdPoint = origin
thirdPoint.x += 10
thirdPoint
origin

// 如果我们有一个经常使用的结构体值，我们可以把它作为静态属性定义在拓展里
extension Point {
    static let origin = Point(x: 0, y: 0)
    
    static func +(lhs: Point, rhs: Point) -> Point {
        return Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

}
Point.origin

// 结构体包含其他结构体
struct Size {
    var width: Int
    var height: Int
}

struct Rectangle {
    var origin: Point
    var size: Size
}

extension Rectangle {
    mutating func translate(by offset: Point) {
        origin = origin + offset
        // Error: 不能赋值属性，self是不可变量(origin = origin = origin + offset 其实是 self.origin = origin + offset, 可以把self想象为一个传递给Rectangle所有方法的隐式参数)
        // 如果我们 想要改变 self，或是改变 self 自身或者嵌套的 (比如 self . origin . x) 任何属性，我们就需要将方 法标记为 mutating
    }
    
    func translated(by offset: Point) -> Rectangle {
        var copySelf = self
        copySelf.translate(by: offset)
        return copySelf
    }
}

Rectangle(origin: Point.origin, size: Size(width: 320, height: 480))

extension Rectangle {
    // 在拓展中自定义构造函数并不会将系统默认的构造函数给覆盖掉
    init(x: Int = 0, y: Int = 0, width: Int, height: Int) {
        origin = Point(x: x, y: y)
        size = Size(width: width, height: height)
    }
}

// 定义了一个可变变量 screen，我们可以为它添加 didSet，
// 这样每当 screen 改变时这 个代码块都将被调用。
var screen = Rectangle(width: 320, height: 480) {
    didSet {
        print("Screen changed: \(screen)")
    }
}
// 对结构体进行改变，在语义上来说，与重新为他进行赋值是相同的
screen.origin.x = 10

// 如果Rectangle是类的话，didSet就会被触发，因为数组存储的引用不会发生改变，只是引用指向的对象发生了改变
var screens = [Rectangle(width: 320, height: 480)] {
    didSet {
        print("Array changed")
    }
}
screens[0].origin.x += 100 // Array changed

/*
 for _ in 0..<Int.max{
     let newScanner = BinaryScanner(data: "hi".data(using: .utf8)!) DispatchQueue.global().async {
        scanRemainingBytes(scanner: newScanner)
    }
     scanRemainingBytes(scanner: newScanner)
 }

 */
//上述代码在BinaryScanner是一个类时出现内存溢出错误，如果BinaryScanner是一个结构体的话，每次scanRemainingBytes的调用都将获取自己的newScanner独立的复制，这样这些调用就能在数组上保持安全迭代，不必担心结构体被另一个方法或者线程所改变


//: 写时复制
var input: [UInt8] = [0x0b, 0xab, 0xf0, 0x0d]
var other: [UInt8] = [0x0d]
var d = Data(bytes: input)
var e = d
d.append(contentsOf: other)
d
e

var f = NSMutableData(bytes: &input, length: input.count)
// f, g引用了同样的对象(换句话说它们指向了同一块内存), 所以对其中一个进行改变也会影响另一个变量
var g = f
f.append(&other, length: other.count)
f
g
f === g     // 使用 === 来验证f，g是同一对象

struct MyData {
    let _data: NSMutableData
    init(_ data: NSData) {
        self._data = data.mutableCopy() as! NSMutableData
    }
}

extension MyData {
    func append(_ other: MyData) {
        _data.append(other._data as Data)
    }
}

let theData = NSData(base64Encoded: "wAEP/w==", options: [])!
let x = MyData(theData)
let y = x
x._data === y._data
x.append(x)
y

//: 实现写时复制(昂贵方式)
struct DataDemo {
    fileprivate var _data: NSMutableData
    // _dataForWriting会更改结构体（他对_data属性进行重新赋值）, 这个属性的getter需要被标记为mutating
    // 这意味着只能通过var方式来声明它
    var _dataForWriting: NSMutableData {
        mutating get {
            _data = _data.mutableCopy() as! NSMutableData
            return _data
        }
    }
    
    init(_ data: NSData) {
        self._data = data.mutableCopy() as! NSMutableData
    }
}

extension DataDemo {
    mutating func append(_ other: MyData) {
        _dataForWriting.append(other._data as Data)
    }
}

//: 写时复制(高效版本)
final class Box<A> {
    var unbox: A
    init(_ value: A) {
        self.unbox = value
    }
}
var box = Box(NSMutableData())
//  isKnownUniquelyReferenced 函数来检查引用的 唯一性。
// 如果你将一个 Swift 类的实例传递给这个函数，并且没有其他变量强引用这个对象的 话，函数将返回 true。
// 如果还有其他的强引用，则返回false。
isKnownUniquelyReferenced(&box)
var box_1 = box
isKnownUniquelyReferenced(&box)

struct CWData {
    fileprivate var _data: Box<NSMutableData>
    
    var _dataForWriting: NSMutableData {
        mutating get {
            // 如果存在多个引用，当改变时才会执行“写时复制”
            if !isKnownUniquelyReferenced(&_data) {
                _data = Box(_data.unbox.mutableCopy() as! NSMutableData)
                print("Making a copy")
            }
            return _data.unbox
        }
    }
    
    init(_ data: NSData) {
        self._data = Box(data.mutableCopy() as! NSMutableData)
    }
}

//: 写时复制陷阱
final class Empty {}
struct COWStruct {
    var ref = Empty()
    mutating func change() -> String {
        if isKnownUniquelyReferenced(&ref) {
            return "No copy"
        } else {
            return "Copy"
        }
    }
}

var s = COWStruct()
s.change()

var original = COWStruct()
var copy = original
original.change()
// 当我们将结构体放到数组中，我们可以直接改变数组元素，且不需要进行复制。这是因为我们
// 使用数组下标直接访问到了内存的位置:
var array = [COWStruct()]
array[0].change()

var otherArray = [COWStruct()]
var copyOtherArray = array[0]
copyOtherArray.change()

//: 闭包和可变性
var i = 0
func uniqueInteger() -> Int {
    i += 1
    return i
}
uniqueInteger()

let otherFunction: () -> Int = uniqueInteger
otherFunction()

func uniqueIntegerProvider() -> (() -> Int) {
    var i = 0
    return {
        i += 1
        return i
    }
}
let function = uniqueIntegerProvider()
function()
function()

func uniqueIntegerProvider_2() -> AnyIterator<Int> {
    var i = 0
    return AnyIterator {
        i += 1
        return i
    }
}

//: 使用值类型不用担心循环引用的问题
struct Person {
    let name: String
    var parents: [Person]
}
var john = Person(name: "John", parents: [])
// 当把john加入数组中时，其实它被复制了
john.parents = [john]
john

class Window {
    weak var rootView: View?    // weak引用的变量可以变为nil，所以它们必须是可选值类型
    
    var onRotate: (() -> ())?
    
    deinit {
        print("Deinit Window")
    }
}

class View {
//    unowned var window: Window  // unowned 这将不持有引用的对象，但却假定该引用会一直有效
    var window: Window
    init(window: Window) {
        self.window = window
    }
    
    deinit {
        print("Deinit View")
    }
}

var myWindow: Window? = Window()
myWindow = nil

var window: Window? = Window()
var view: View? = View(window: window!)
window?.rootView = view!
window?.onRotate = { [weak view] in // 捕获列表
    // 闭包里强引用 view， view强引用window造成循环引用
    print("We now also need to update the view: \(view)")
}

window?.onRotate = {
    // 捕获列表也可以用来初始化新的变量
    // 如果我们想要用一个 weak 变量来引用窗口，
    // 我们可以将它在捕获列表中进行初始化，我们甚至可以定义完全不相关的变量
    // 这些变量的作用域只在闭包内部，在闭包外面它们是不能使用的。
    [weak view, weak myWindow = window, x = 5 * 5] in
    
    print("We now also need to update the view: \(view)")
    print("Because the window \(myWindow) changed")
}

// class 实现
typealias USDCents = Int
/*
class Account {
    var funds: USDCents = 0
    init(funds: USDCents) {
        self.funds = funds
    }
}
// 对应transfer来说并不是线程安全的
func transfer(amount: USDCents, source: Account, destination: Account) -> Bool {
    guard source.funds >= amount else { return false }
    source.funds -= amount
    destination.funds += amount
    return true
}

let alice = Account(funds: 100)
let bob = Account(funds: 0) */

struct Account {
    var funds: USDCents
}

func transfer(amount: USDCents, source: Account, destination: Account) -> (source: Account, destination: Account)? {
    guard source.funds >= amount else { return nil }
    var newSource = source
    var newDestination = destination
    newSource.funds -= amount
    newDestination.funds += amount
    return (newSource, newDestination)
}

func transfer(amount: USDCents, source: inout Account, destination: inout Account) -> Bool {
    guard source.funds >= amount else { return false }
    source.funds -= amount
    destination.funds += amount
    return true
}

//: [Next](@next)
