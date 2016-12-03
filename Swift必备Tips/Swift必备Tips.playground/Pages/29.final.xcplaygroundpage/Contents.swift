//: [Previous](@previous)

import Foundation

// final 关键字可以用在class func 或者var前面修饰，表示不允许对该内容进行继承或者重新操作
class Parent {
    final func method() {
        print("开始配置")
        methodImpl()
        
    }
    func methodImpl() {
        
    }
}

class Child: Parent {
    override func methodImpl() {
        
    }
}
// 这样无论我们如何使用method，都可以保证需要的代码一定被运行

//: [Next](@next)
