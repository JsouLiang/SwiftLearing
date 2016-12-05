//: [Previous](@previous)

import Foundation
// 使用@objc的协议只能被class实现
@objc protocol OptionalProtocol {
    // optionalMethod类型：(()->())?
    @objc optional func optionalMethod()    // 可选
    func neccessaryMethod() // 必选
    @objc optional func anotherOptionalMethod() // 可选
}

// 使用protocol extension，将可选的协议进行默认实现
protocol OptionalProtocolExtension {
    func optionalMethod()
    func neccessaryMethod()
    func anotherOptionalMethod()
}

extension OptionalProtocolExtension {
    func optionalMethod() {
        print("Implement in extenstion")
    }
    
    func anotherOptionalMethod() {
        print("Implement in extenstion")
    }
}

class MyClass: OptionalProtocolExtension {
    func neccessaryMethod() {
        print("Implement in MyClass")
    }
    
    func optionalMethod() {
        print("Implement in MyClass")
    }
}

let obj = MyClass()
obj.neccessaryMethod()
obj.optionalMethod()
obj.anotherOptionalMethod()

//: [Next](@next)
