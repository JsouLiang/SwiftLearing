//: [Previous](@previous)

import Foundation

// 在Swift中我们也可以使用KVO，但仅限于NSObject子类
// 由于Swift为了效率，默认禁用了动态派发，因此想用Swift实现KVO我们还需要将要观测的对象标记为dynamic
class MyClass: NSObject {
    dynamic var date = Date()
}

private var myContext = 0

class Class: NSObject {
    var myObject: MyClass!
    
    override init() {
        super.init()
        myObject = MyClass()
        print("初始化 MyClass，当前日期：\(myObject.date)")
        myObject.addObserver(self,
                             forKeyPath: "date",
                             options: .new,
                             context: &myContext)
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        if let change = change, context == &myObject {
            let newDate = change[.newKey]
            print("日期变化\(newDate)")
        }
    }
}
let obj = Class()

// 有时候监听的类不一定是dynamic修饰，还可能无法修改观察类的源码，一个可行的方案是继承这个类，并将需要观察的属性用dynamic重写
class Parent: NSObject {
    var date = Date()
}

class Child: Parent {
    // 我们没有必要改变逻辑，在子类中简单的调用super相关属性就OK
    dynamic override var date: Date {
        get { return super.date}
        set {super.date = newValue}
    }
}


//: [Next](@next)
