//: [Previous](@previous)

import Foundation

// 相对于普通的Optional，在Swift中有一种特殊的Optional，在对他的成员或者方法进行访问时，编译器会帮助我们自动进行解包
// 我们可以在声明类型后面添加！，来声明一个隐式解包
class MyClass {
    var str: String!
//    init() {
//        self.str =
//    }
}

let myObc = MyClass()
myObc.str


//: [Next](@next)
