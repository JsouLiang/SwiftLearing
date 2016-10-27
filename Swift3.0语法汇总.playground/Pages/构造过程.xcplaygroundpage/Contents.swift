//: [Previous](@previous)

import Foundation

// 初始化包括: 1. 设置实例中每个存储型属性的初始值 2.执行其他必须的设置或初始化工作。
//: 存储属性的初始化
// 类和结构体在创建实例时, 必须为所有存储属性设置合适的初始值, 存储属性不能处于一个未知的状态
// 可以在构造器中为存储属性设置初始值, 也可以在定义属性时为其设置默认值
// 当你为存储型属性设置默认值或者在构造器中为其赋值时，它们的值是被直接设置的，不会触发任何属性观察者( property observers )。
// 构造器设置初始值
struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature)° Fahrenheit")

// 默认属性
//struct FahrenheitDefault {
//    var temperature = 32.0
//}

//: 自定义构造过程
struct Celsius {
    var temperatureInCelsius: Double
    
    /// 构造函数, 拥有一个构造参数, 其外部名称为 fromFahrenheit, 内部名称为 fahrenheit
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
let freezingPointOfWater = Celsius(fromKelvin: 273.15)

// 参数的内部和外部名称
// 跟方法和函数参数相同, 构造参数也拥有一个在构造器内部使用的参数名字和一个在调用时候使用的外部参数名称
// 但是, 构造器并不像参数和方法那样在括号前有一个可辨识的名字, 因此在调用构造器时，主要通过构造器中的 参数名和类型来确定应该被调用的构造器
// 如果你在定义构造器时没有提供参数的外部名字，Swift 会为构造器的每个参数自动生成一个跟内部名字相同的外部名。
struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
}

// 不带外部名的构造器参数
// 如果你不希望为某个参数提供外部名字, 可以使用 _ 来显示描述它的外部名
struct Celsius_2 {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double){
        temperatureInCelsius = celsius
    }
}

// 可选属性类型
// 如果你定制的类型包含一个逻辑上允许取值为空的存储型属性——无论是因为它无法在初始化时赋值，还是因为 它在之后某个时间点可以赋值为空——你都需要将它定义为 可选类型 (optional type)。
// 可选类型的属性将自 动初始化为 nil ，表示这个属性是有意在初始化时设置为空的。
// 构造过程中常量属性的修改
// 你可以在构造过程中的任意时间点给常量属性指定一个值，只要在构造过程结束时是一个确定的值。一旦常量属性被赋值，它将永远不可更改。
// 对于类的实例来说，它的常量属性只能在定义它的类的构造过程中修改;   不能在子类中修改。
class SurveyQuestion {
    let text: String
    var response: String?
    init(text: String) {
        // 尽管 text 属性现在是常量，我们仍然可以在类的构造器中设置它的值:
        self.text = text
    }
    
    func ask() {
        print(text)
    }
}

//: 默认构造器
// 如果结构体或类的所有属性都有默认值，同时没有自定义的构造器，那么 Swift 会给这些结构体或类提供一个默 认构造器
// 默认构造器将简单地创建一个所有属性值都设置为默认值的实例
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
// 由于 ShoppingListItem 类中的所有属性都有默认值，且它是没有父类的基类，它将自动获得一个可以为所有属性 设置默认值的默认构造器
var item = ShoppingListItem()   // name为可选类型默认设置为 nil

//: 结构体逐一成员构造器
// 如果结构体没有提供自定义的构造器, 那么它将自动获得一个逐一成员构造器, 即使结构体的存储属性没有默认值
// 逐一成员构造器是用来初始化结构体新实例里成员属性的快捷方法。我们在调用逐一成员构造器时，通过与成员属性名相同的参数名进行传值来完成对成员属性的初始赋值。
struct Size {
    var width = 0.0, height = 0.0
}
var twoByTwo = Size(width: 2.0, height: 2.0)

//: 值类型的构造器的构造器代理
// 构造器可以通过调用其它构造器来完成实例的部分构造过程。这一过程称为构造器代理，它能减少多个构造器间的代码重复。
// 值类型(结构体和枚举类型)不支持继承，所以构 造器代理的过程相对简单，因为它们只能代理给自己的其它构造器
// 对于值类型，你可以使用 self.init 在自定义的构造器中引用相同类型中的其它构造器。并且你只能在构造器内 部调用 self.init 。
// 如果你为某个值类型定义了一个自定义的构造器，你将无法访问到默认构造器(如果是结构体，还将无法访问逐 一成员构造器)。
// 假如你希望默认构造器、逐一成员构造器以及你自己的自定义构造器都能用来创建实例，可以将自定义的构造器 写到扩展( extension )中，而不是写在值类型的原始定义中
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    init() {}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    
    init(center: Point, size: Size) {
        let originX = center.x - size.width * 0.5
        let originY = center.y - size.height * 0.5
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

//: 类的继承构造过程
// 类里面的所有存储型属性——包括所有继承自父类的属性——都必须在构造过程中设置初始值。
// Swift 为类类型提供了两种构造器来确保实例中所有存储型属性都能获得初始值，它们分别是指定构造器和便利 构造器。
// 指定构造器
// 指定构造器将初始化类中提供的所有属性, 并根据继承链往上调用父类的构造器来实现父类的初始化
// 每一个类都必须拥有至少一个指定构造器。
// 在某些情况下，许多类通过继承了父类中的指定构造器而满足了这个 条件


// 便利构造器
// 便利构造器(convenience initializers)是类中比较次要的、辅助型的构造器。
// 你可以定义便利构造器来调用 同一个类中的指定构造器，并为其参数提供默认值。
// 你也可以定义便利构造器来创建一个特殊用途或特定输入值 的实例。
/*
 规则 1 指定构造器必须调用其直接父类的的指定构造器。
 规则 2 便利构造器必须调用同一类中定义的其它构造器。
 规则 3 便利构造器必须最终导致一个指定构造器被调用。
 一个更方便记忆的方法是:
 • 指定构造器必须总是向上代理 • 便利构造器必须总是横向代理
 
 */

//: [Next](@next)
