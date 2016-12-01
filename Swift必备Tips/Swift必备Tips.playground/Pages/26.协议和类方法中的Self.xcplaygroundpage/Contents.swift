//: [Previous](@previous)

import Foundation

// 在一些协议中会有Self出现在类型的位置上，比如：
protocol IntervalType {
    // 该方法接收实现协议的自身类型，并返回同样的类型
    func clamp(intervalToClamp: Self) -> Self
}

protocol Copyable {
    func copy() -> Self
}

class MyClass: Copyable {
    var num = 1
    func copy() -> Self {
        // 这里需要通过一个和当前上下文无关（也就是和MyClass）无关，又能指代当前的类型的方式进行初始化
        // 如果要构建一个Self类型的对象，需要有require关键字修饰的初始化方法，这是因为Swif必须保证当前类和其子类都能相应这个方法
        let result = type(of: self).init()
        result.num = num
        return result
    }
    
    required init() {
        
    }
}

//: [Next](@next)
