//: [Previous](@previous)

import Foundation

protocol MyProtocol {
    func method()
}

// protocol extension为protocol定义的方法提供了一个默认实现
extension MyProtocol {
    func method() {
        print("called")
    }
}

struct MyStruct: MyProtocol {
    
}
MyStruct().method()

protocol A1 {
    func method1() -> String
}

struct B1: A1 {
    func method1() -> String {
        return "helloB1"
    }
}

let b1 = B1()
b1.method1()

let a1: A1 = B1()
a1.method1()

protocol AA {
    func method()
}

extension AA {
    func method() {
        print("AA method")
    }
    
    func method2() {
        print("AA extension method2")
    }
}

struct B2: AA {
    func method() {
        print("B2 method")
    }
    func method2() {
        print("B2 method2")
    }
}

let b2 = B2()
b2.method()
b2.method2()

// a2和b2是同一个对象，只不过我们通过as的方式告诉编译器这里a2的类型是AA并且需要的类型是AA
let a2: AA = b2 as AA
a2.method()
// 对a2调用method2实际时调用了协议拓展中的实现而不是B2中的实现
a2.method2()

// 总结：
// 1. 如果类型推断得到的是实际类型
// 那么类型中的实现被调用；如果类型中没有实现的话，那么协议拓展中的默认实现将被调用
// 2. 如果类型推断的类型是协议，而不是实际类型
// 如果方法在协议中定义了，那么类型中的实现被调用；如果类型中没有实现，那么使用默认实现
// 如果方法在协议中没有定义，拓展中的默认实现被调用

//: [Next](@next)
