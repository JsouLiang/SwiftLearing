//: [Previous](@previous)

import Foundation

// Swift 中不加修饰的init方法都需要在方法中保证所有的非optional实例变量都要被赋值初始化
// 子类中也强制显示或者隐式调用super的Designated初始化，无论何种路劲，初始化的对象总是可以完整初始化的
class ClassA {
    let numA: Int
    init(num: Int) {
        numA = num
    }
    // convenience 初始化必须调用同一个类中的designated初始化完成设置，
    // convenience 初始化不能被子类重写或者从子类中以super方式调用
    convenience init(bigNum: Bool) {
        self.init(num: bigNum ? 10000 : 1)
    }
}

class ClassB: ClassA {
    let numB: Int
    override init(num: Int) {
        numB = num + 1
        super.init(num: num)
    }
}

// 只要子类重写了父类convenience方法所需的init的方法，我们在子类中就可以使用父类的convenience初始化方法
let anObj = ClassB(bigNum: true)

// 初始化永远遵循以下两个原则
// 1. 初始化路径必须保证对象全部初始化，可以通过调用被本类型的designated初始化方法得到保证
// 2. 子类的designated初始化方法必须调用父类的designated方法，以保证父类完成初始化
// 3. 如果我们希望子类一定要实现某个designated初始化方法，可以通过添加required关键字， 强制子类对这个方法重写，可以保证依赖于某个designated初始化方法的convenience初始化一直可以被使用

//: [Next](@next)
