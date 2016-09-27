//: [Previous](@previous)

import Foundation

// 属性将值跟特定的类、结构或枚举关联。
// 1. 存储属性存储常量或变量作为实例的一部分
// 2. 计算属性计算(不是存储)一个值
// 3. 计算属性可以用于类、结构体和枚举，存储属性只能用于类和结构体
// 4. 存储属性和计算属性通常与特定类型的实例关联
// 5. 属性也可以直接作用于类型本身，这种属性称为类型属性。
// 6. 定义属性观察器来监控属性值的变化，以此来触发一个自定义的操作
// 7. 属性观察器可以添加到自己定义的存储属性上，也可以添加到从父类继承的属性上

//: ------------
//: 存储属性
// 存储属性就是存储在特定类或结构体实例里的一个常量或者变量
// 可以再定义存储属性时定义默认值, 也可以在构造过程中设置或者修改存储属性的值, 甚至修改存储属性的值
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}

var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
rangeOfThreeItems.firstValue = 6

// 如果创建一个 常量结构体, 则无法修改该实例的任何属性, 即使属性被声明为变量
let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
//rangeOfFourItems.firstValue = 6
// 因为 rangeOfFourItems 被声明为常量, 即使 firstValue 是一个变量属性, 也无法修改它

// 这是因为由于结构体 struct 是属于值类型, 当值类型的实例被声明为常量的时候, 它的所有属性也就成了常量
// 引用类型, 当把引用类型赋值给一个常量, 仍然可以修改该实例的变量属性

//: ---------
//: 延迟存储属性
// 延迟存储属性是指当第一次被调用时才会计算其初始值的属性, 在属性声明前使用 lazy 来标示一个延迟存储属性
// 必须将延迟存储属性声明为 var, 因为属性的值可能在实例构造完成后才会得到
class DataImporter {
    // DataImporter 是一个负责将外部文件中数据导入的类, 这个类的初始化会消耗不少时间
    var fileName = "data.txt"
    // 导入数据功能
}

class DataManager {
    lazy var importer = DataImporter()
    
    var data = [String]()
    // 提供数据管理功能
}
let manager = DataManager()
manager.data.append("Some Data")
manager.data.append("Some more data")
// 由于使用了 lazy, importer 属性只有在第一次被访问的时候才会被创建
print(manager.importer.fileName)
// 多线程问题:
// 如果一个被标记为 lazy 的属性在没有初始化时就同时被多个线程访问，则无法保证该属性只会被初始化一 次。

//: ----------
// 计算属性
// 计算属性提供一个 getter 和一个可选的 setter 来间接获取和设置其他属性或变量值
struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    // 计算属性
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.x + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        
        // 如果计算属性的 setter 没有定义新的参数名, 则可以使用默认名称 newValue
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}

var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at \(square.origin.x), \(square.origin.y)")

// 只读计算属性, 只有 getter 没有 setter 的计算属性就是只读属性, 只读属性总是返回一个值, 可以通过 . 访问, 但不能设置新值
// 必须使用 var 关键字定义计算属性, 包括只读属性, 因为他们的值不是固定的
// let 只能声明常量属性, 表示初始化后再无法修改的值
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    // 只读属性
    var volume: Double {
        return width * height * depth
    }
}

//: -----------
// 属性观察器
// 属性观察器监控和影响属性的变化, 每次属性被设置值的时候都会调用属性观察器, 即使当新值和当前值相同的时候也不例外
// 可以为除了 延迟存储属性之外的 其他存储属性 添加属性观察器, 也可以通过重写属性的方法为继承的属性(包括存储和计算属性)添加
// 不必为计算属性添加属性观察器, 因为他们可以通过 setter 和 getter 来监控

// • willSet 在新的值被设置之前调用
//      willSet 观察器会将新的属性值作为常量参数传入，
//      在 willSet 的实现代码中可以为这个参数指定一个名 称，如果不指定则参数仍然可用，这时使用默认名称 newValue 表示

// • didSet 在新的值被设置之后立即调用
//      didSet 观察器会将旧的属性值作为参数传入，可以为该参数命名或者使用默认参数名 oldValue。
//      如果 在 didSet 方法中再次对该属性赋值，那么新值会覆盖旧的值。

// 父类的属性在子类的构造器中被赋值时，它在父类中的 willSet 和 didSet 观察器会被调用，随后才会调用 子类的观察器。
// 在父类初始化方法调用之前，子类给属性赋值时，观察器不会被调用。
class StepCounter {
    var totalSteps: Int = 0 {
        willSet (newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        
        didSet {
            if totalSteps > oldValue {
                print("Add \(totalSteps - oldValue) steps")
            }
        }
    }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200
// About to set totalSteps to 200
// Added 200 steps
stepCounter.totalSteps = 360
// About to set totalSteps to 360
// Added 160 steps
stepCounter.totalSteps = 896
// About to set totalSteps to 896
// Added 536 steps

// 如果将属性通过 in-out 方式传入函数， willSet 和 didSet 也会调用。
// 这是因为 in-out 参数采用了拷入 拷出模式:即在函数内部使用的是参数的 copy，函数结束后，又对参数重新赋值

//:-----------
// 全局变量和局部变量
// 计算属性和属性观察器所描述的功能也可以用于全局变量和局部变量。全局变量是在函数、方法、闭包或任何类
// 型之外定义的变量。局部变量是在函数、方法或闭包内部定义的变量。

// 在全局或局部范围都可以定义计算型变量和为存储型变量定义观察器。计算型变量跟计算属性一样，返回
// 一个计算结果而不是存储值，声明格式也完全一样。

// 全局的常量或变量都是延迟计算的，跟延迟存储属性相似，不同的地方在于，全局的常量或变量不需要 标记lazy 修饰符。
// 局部范围的常量或变量从不延迟计算。


//: ----------
// 类型属性
// 在 C 或 Objective-C 中，与某个类型关联的静态常量和静态变量，是作为全局(global)静态变量定义的。
// 但 是在 Swift 中，类型属性是作为类型定义的一部分写在类型最外层的花括号内，因此它的作用范围也就在类型支 持的范围内
// 使用关键字 static 来定义类型属性。在为类定义计算型类型属性时，可以改用关键字 class 来支持子类对父 类的实现进行重写。
struct SomeStructure {
    static var storeTypeProperty = "Some Value"
    static var computedTypeProperty: Int {
        return 1
    }
}

enum SomeEnumeration {
    static var storedTypeProperty = "Some Value"
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    static var storedTypeProperty = "Some Value"
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}
print(SomeStructure.storeTypeProperty)


//: [Next](@next)
