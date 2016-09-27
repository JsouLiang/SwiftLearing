//: [Previous](@previous)

import Foundation

//: 方法
//: 实例方法
// 实例方法是属于某个特定的类, 结构体或枚举类型实例的方法
// 实例方法提供访问和修改实例属性的方法或提供与实例目的相关的功能，并以此来支撑实例的功能。
// 实例方法只能被它所属的类的某个特定实例调用。实例方法不能脱离于现存的实例而被调用。

class Counter {
    var count = 0
    
    // 类型的每一个实例都有一个隐含属性叫做 self ， self 完全等同于该实例本身。
    // 你可以在一个实例的实例方法中 使用这个隐含的 self 属性来引用当前实例。
    func increment() {
        self.count += 1
    }
    
    // Swift3.0 命名规范
    func increment(by amount: Int) {
        count += amount
    }
    // Swift 之前版本的命名规范
    func incrementBy(amount: Int) {
        count += amount
    }
    
    func reset() {
        count = 0
    }
}

let couner = Counter()
couner.increment()
couner.increment(by: 5)
couner.incrementBy(amount: 5)
couner.reset()

struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }
}
let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOf(x: 1.0) {
    
}

// 在实例方法中修改值类型
// 结构体, 枚举是值类型, 默认情况下, 值类型的属性不能在它的实例方法中被修改
// 如果确定要在某个特定的方法中修改结构体或者枚举属性, 可以为这个方法选择可变 mutating 行为, 然后就可以从其方法内部改变他的属性
// 并且这个方法做的任何改变都会在方法执行结束时写回到原始 结构中
// 方法还可以给它隐含的 self 属性赋予一个全新的实例，这个新实例在方法结束时会替换现存实例。
struct Point_1 {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
var somePoint_1 = Point_1(x: 1.0, y: 1.0)
somePoint_1.moveBy(x: 2.0, y: 3.0)
print("The point is now at (\(somePoint_1.x), \(somePoint_1.y))")

// 注意，不能在结构体类型的常量(a constant of structure type)上调用可变方法，因为其属性不能被改 变，即使属性是变量属性
let fixedPoint = Point(x: 3.0, y: 3.0)
//fixedPoint.moveBy(x: 2.0, y: 2.0)

// 在可变方法中为 self 赋值
struct Point_2 {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = Point_2(x: x + deltaX, y: y + deltaY)
    }
}

enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}
var ovenLight = TriStateSwitch.low
ovenLight.next()
ovenLight.next()

//: ---------
// 类型方法
// 定义在类型本身上调用的方法，这种方法就叫做类型方法
// 在类型方法的方法体(body)中， self 指向这个类型本身，而不是类型的某个实例
struct LevelTracker {
    static var highestUnlockedLevel = 1
    static func unlockLevel(_ level: Int) {
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }
    
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    
    var currentLevel = 1
    
    @discardableResult // 告诉编译器此方法可以不用接受返回值
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    func completedLevel(level: Int) {
        LevelTracker.unlockLevel(level + 1)
        tracker.advance(to: level + 1)
    }
    init(name: String) {
        playerName = name
    }
}

var player = Player(name: "Argyrios")
player.completedLevel(level: 1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")

player = Player(name: "Beto")
if player.tracker.advance(to: 6) {
    print("player is now on level 6")
} else {
    print("level 6 has not yet been unlocked")
}

//: [Next](@next)
