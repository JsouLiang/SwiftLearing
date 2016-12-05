//: [Previous](@previous)

import Foundation
// 我们可以不直接使用实例来调用这个实例的方法，而是通过类型取出这个类型的某个实例方法的签名，然后通过传递实例来拿到实际需要调用的方法
class MyClass {
    // func method, class func method, 如果通过Type.methodName获取到的将是类型方法，如果我们要取到实例方法的话，可以显示地在类型声明上加以区别
    func method(number: Int) -> Int {
        return number + 1
    }
    
    class func method(number: Int) -> Int {
        return number + 2
    }
}

// 调用method的普通方式
//let object = MyClass()
//let result = object.method(number: 1)

// Swift 中可以直接使用Type.instanceMethod的语法来生成一个柯里化的方法

let f1 = MyClass.method  // class func method 版本
let f2: (Int) -> Int = MyClass.method // 与f1相同
let f3: (MyClass) -> (Int) -> Int = MyClass.method // func method版本
let object = MyClass()
let result = f3(object)(1)

f2(1)



//: [Next](@next)
