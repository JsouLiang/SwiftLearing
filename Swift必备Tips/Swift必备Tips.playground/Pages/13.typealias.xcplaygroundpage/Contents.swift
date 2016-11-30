//: [Previous](@previous)

import UIKit
// typealias 是用来为已存在的类型重新定义名字，通过命名可以使代码变得更加清晰
typealias Location = CGPoint
typealias Distance = Double

func distance(from location: Location, to anotherLocation: Location) -> Distance {
    let dx = Distance(location.x - anotherLocation.x)
    let dy = Distance(location.y - anotherLocation.y)
    return sqrt(dx * dx + dy * dy)
}

let origin: Location = Location(x: 0, y: 0)
let point: Location = Location(x: 1, y: 1)
let distance: Distance = distance(from: origin, to: point)

// typealias 是单一的，也就是你必须指定将某个特定的类型通过typealias赋值为新名字，而不能将整个泛型类型进行重命名
class Person<T> {}
// 以下Error
//typealias Worker = Person
//typealias Worker = Person<T>

// 以下是OK的, 在别名中同时引入泛型
typealias Work<T> = Person<T>
// 泛型类型确定后别名也同样可以使用
typealias WorkId = String
typealias Worker = Person<WorkId>

// 某个类型同时实现多个协议组合，可以使用&连接，然后给定一个新的组合名称
protocol Cat {}
protocol Dog {}
typealias Pat = Cat & Dog

//: [Next](@next)
