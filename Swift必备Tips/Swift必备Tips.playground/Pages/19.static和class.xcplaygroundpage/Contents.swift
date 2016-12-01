//: [Previous](@previous)

import Foundation
// 类型范围作用域有两个关键字：static，class
// 在非class的类型上下文中，我们统一使用static描述类型作用域，包括enum和struct
struct Point {
    let x: Double
    let y: Double
    
    // 存储属性
    static let zero = Point(x: 0, y: 0)
    
    // 计算属性
    static var ones: [Point] {
        return [Point(x: 1, y: 1),
                Point(x: -1, y: 1),
                Point(x: 1, y: -1),
                Point(x: -1, y: -1)]
    }
    
    // 类型方法
    static func add(p1: Point, p2: Point) -> Point {
        return Point(x: p1.x + p2.x, y: p1.y + p2.y)
    }
}

class MyClass {
    // class(范围作用域声明) 可以用来修饰类方法以及类的计算属性
    // class(范围作用域声明) 不能出现在class(类)的存储属性中
//    class var bar: Bool?
    // 使用static声明类作用域存储属性
    static var bar: Bool?
}

// 在protocol中我们使用static定义一个类型域上的方法或者计算属性
protocol MyProtocol {
    static func foo() -> String
}

struct MyStruct: MyProtocol {
    static func foo() -> String {
        return ""
    }
}

class Class: MyProtocol {
    static func foo() -> String {
        return ""
    }
}




//: [Next](@next)
