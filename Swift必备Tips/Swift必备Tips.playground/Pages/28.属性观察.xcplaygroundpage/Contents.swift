//: [Previous](@previous)

import Foundation

// 通过属性观察我们可以在当前类型內监视属性的设置，并作出一些响应
// Swift 提供了两种属性观察方法 willSet和didSet
class MyClass {
    let oneYearInSecond: TimeInterval = 365 * 24 * 60 * 60
    var date: NSDate {
        // 在willSet和didSet中我们分别可以使用newValue和oldValue来获取将要设置和已经设置的值
        willSet {
            let d = date
            print("即将从\(d)设置到\(newValue)")
        }
        
        didSet {
            // 在didSet中做属性值验证
            if(date.timeIntervalSinceNow > oneYearInSecond) {
                print("设置的时间太晚")
                date = NSDate().addingTimeInterval(oneYearInSecond)
            }
            print("已经从\(oldValue)设置到\(date)")
        }
    }
    
    init() {
        // 在初始化中对属性进行设置不会触发属性观察的调用
        // 在didSet和willSet中也不会触发
        date = NSDate()
    }
}
let foo = MyClass()
foo.date = foo.date.addingTimeInterval(10086)

// 在Swift中声明的属性包括存储属性和计算属性两种
// 存储属性会在内存中实际分配地址对属性进行存储
// 计算属性则不包括背后的存储，只提供set和get
// 要想在同一个属性中同时定义属性观察和set，get是不行的
// 如果我们无法修改这个类，又想通过属性观察做些事情，需要子类化这个类，并重写它的属性
// 重写属性并不知道父类属性的具体情况，之从父类继承名字和类型，因此在子类的重载属性我们可以对父类的属性任意填加属性观察，不用在意父类中到到底是存储属性还是计算属性
class A {
    var number: Int {
        get {
            print("get")
            return 1
        }
        
        set {
            print("set")
        }
    }
}

class B: A {
    override var number: Int {
        willSet {
            print("willSet")
        }
        
        didSet {
            print("didSet")
        }
    }
}
let b = B()
b.number = 0
/**
 get
 willSet
 set
 didSet
 其中调用了一次get，这是因为我们在didSet中使用了oldValue，这个oldValue的取值需要调用get，由于这个值需要在整个set动作之前进行获取并存储待用，才能保证oldValue的正确性
 */

//: [Next](@next)
