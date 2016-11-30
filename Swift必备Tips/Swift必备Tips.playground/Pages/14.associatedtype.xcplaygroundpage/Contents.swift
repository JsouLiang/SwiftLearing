//: [Previous](@previous)

import Foundation

// 我们在swift协议中可以定义属性和方法，并要求满足这个协议的类型实现他们
protocol Food {}
//protocol Animal {
//    func eat(_ food: Food)
//}

struct Meat: Food {}
struct Grass: Food {}

//struct Tiger: Animal {
//    func eat(_ food: Food) {
//        // Tiger只吃肉, 将判断肉类的责任交给了运行时
//        if let meat = food as? Meat {
//            print("eat \(eat)")
//        } else {
//            print("error")
//        }
//    }
//}

//: 改进：在协议中除了定义属性和方法外，还可以定义占位符，让实现协议的类型来指定具体的类型
// 使用associatedType在Animal协议中添加一个限定，让Tiger来指定食物的具体类型
protocol Animal {
    associatedtype F: Food // associatedtype可以使用“冒号”来指定类型满足某个协议
    func eat(_ food: F)
}

struct Tiger: Animal {
    
    typealias F = Meat
    func eat(_ food: Meat) {
        print("eat \(food)")
    }
}

struct Sheep: Animal {
    // Sheep 并不关心F是什么类型，他只关心 eat的参数类型与F是相同类型，所以eat指定好参数类型后就可以推断出F的类型
    func eat(_ food: Grass) {
        print("eat \(food)")
    }
}

// 当协议添加associatedtype后，Animal协议就不能当做单独的类型使用
//func isDangerous(animal: Animal) -> Bool {  // Error: protocol 'Animal' can only be used as a generic constraint because it has Self or associated type requirements
//    
//}

// Swift 是一门类型安全的语言，在编译时必须确定所有的类型，这里的Animal包含了一个不确定的类型F
// 在一个协议中加入项associatedtype或者Self的约束，发只能被使用为泛型约束，不能作为独立的类型占位使用
func isDangerous<T: Animal>(animal: T) -> Bool {
    if animal is Tiger {
        return true
    } else {
        return false
    }
}

//: [Next](@next)
