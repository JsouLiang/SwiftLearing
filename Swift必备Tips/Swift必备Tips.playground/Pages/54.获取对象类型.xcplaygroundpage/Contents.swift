//: [Previous](@previous)

import Foundation

let date = NSDate()
let name: AnyClass! = object_getClass(date)
print(name)
// 在Swift中获取一个NSObject或其子类的对象的实际类型可以使用type(of:)
let typeName = type(of: date)
print(typeName)

let string = "Hello"
let swiftObjType = type(of: string)
debugPrint(swiftObjType)    // 模块前缀.对象类型（Swift.String)

//: [Next](@next)
