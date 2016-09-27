//: [Previous](@previous)

import Foundation

//: 继承
//: 
class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        
    }
}

//: 子类生成
// 新的 Bicycle类自动获得 Vehicle类的所有特性，比如 currentSpeed和description 属性，还有它的makeNoise 方法。
class Bicycle: Vehicle {
    var hasBasket = false
}

//: 重写
// 子类可以为继承来的实例方法, 类方法, 实例属性或者下标提供自己的定制实现
// 如果要重写某个特性，你需要在重写定义的前面加上  override 关键字
// 可以通过使用 super 前缀来访问超类版本的方法，属性或下标
class Train: Vehicle {
    // 重写方法
    override func makeNoise() {
        print("Choo choo")
    }
}

// 重写属性
// 可以提供定制的 setter 或者 getter 来重新任意继承来的属性, 无论继承来的属性是存储属性还是计算属性
// 子类并不知道继承来的属性是存储型的还是计算型的，它只知道继承来的属性会有一个名字和类型
// 你在 重写一个属性时，必需将它的名字和类型都写出来。
// 只读 -> 读写(✅)
// 读写 -> 只读(❌)

// 在重写属性中提供了 setter，那么你也一定要提供 getter。
// 不想在重写版本中的 getter 里修改 继承来的属性值，你可以直接通过 super.someProperty 来返回继承来的值，其中 someProperty 是你要重写的属 性的名字。
class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + "in gear \(gear)"
    }
}

// 重写属性观察器
// 可以通过重写属性为一个继承来的属性添加属性观察器, 这样一来，当继承来的属性值发生改变时，你就会被 通知到，无论那个属性原本是如何实现的。
// 不可以为继承来的 常量存储型属性 或继承来的 只读计算型属性 添加属性观察器。 这些属性的值是不可以被设置 的，所以，为它们提供 willSet 或 didSet 实现是不恰当。
// 不可以同时提供重写的 setter 和重写的属性观察器。如果你想观察属性值的变化，并且你已 经为那个属性提供了定制的 setter，那么你在 setter 中就可以观察到任何值变化了。
class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
             gear = Int(currentSpeed / 10.0) + 1
        }
    }
}

// 防止重写
// 通过把方法，属性或下标标记为final来防止它们被重写，只需要在声明关键字前加上 final修饰符即 可
// 如果你重写了带有final 标记的方法，属性或下标，在编译时会报错。在类扩展中的方法，属性或下标也可以在 扩展的定义里标记为 final 的。
// 你可以通过在关键字class  前添加  final 修饰符(final class )来将整个类标记为 final 的。这样的类是不可 被继承的，试图继承这样的类会导致编译报错。
//: [Next](@next)
