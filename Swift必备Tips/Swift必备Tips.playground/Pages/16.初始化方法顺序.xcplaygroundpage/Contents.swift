//: [Previous](@previous)

import Foundation

// Swift 初始化需要保证类型的所有属性都被初始化
// 初始化中的语句顺序不是随意的，他们需要保证当前子类实例成员初始化完成后才能调用父类初始化方法
class Cat {
    var name: String
    init() {
        name = "Cat"
    }
}

class Tiger: Cat {
    let power: Int
    override init() {
        // 1. 设置子类自己需要初始化的参数
        power = 10
        // 2. 调用父类相应的初始化
        super.init()
        // 3. 对父类的需要改变的成员进行设置
        name = "Tiger"
    }
}

//: [Next](@next)
