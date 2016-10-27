//: [Previous](@previous)

import UIKit
//: 协议(Protocols)
//: --------------
// 属性要求
// 1. 协议可以要求采纳协议的类型提供特定名称和类型的实例属性或类型属性。
// 2. 协议不指定属性是存储型属性还是计算型属性，它只指定属性的名称和类型。
// 3. 此外，协议还指定属性是可读的还是可读可写的。
// 如果协议要求属性是可读可写的，那么该属性不能是常量属性或只读的计算型属性。
// 如果协议只要求属性是可读的，那么该属性不仅可以是可读的，如果代码需要的话，还可以是可写的。

// 协议总是用 var 关键字来声明 变量属性
// 在类型声明后加上 { set get } 来表示属性是可读可写的，
// 可读属 性则用 { get } 来表示
protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doseNotNeedToBeSettable: Int { get }
}

// 在协议中定义 类型属性 时，总是使用 static 关键字作为前缀。
// 当类类型采纳协议时，除了 static 关键 字，还可以使用 class 关键字来声明类型属性:
protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}

protocol FullyNamed {
    var fullName: String {get}
}

// PersonStruct 结构体的每一个实例都有一个 String 类型的存储型属性 fullName
struct PersonStruct: FullyNamed {
    var fullName: String
}

class StartShip: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    
    // fullName 属性为只读的计算型属性。
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}


//: ----------
// 方法要求
// 协议可以要求采纳协议的类型实现某些指定的实例方法或类方法。
// 可以在协议中定义具有可变参数的方法，和普通方法的定义方式相同。
// 不支持为协议中的方法的参数提供默认值。

// 在协议中定义类方法的时候，总是使用 static 关键字作为前缀。
// 当类类型采纳协议 时，除了 static 关键字，还可以使用 class 关键字作为前缀
protocol RandomNumberGenerator {
    func random() -> Double
}

//class LinearCongruentialGenerator: RandomNumberGenerator {
//    var lastRandom = 42.0
//    let m = 139968.0
//    let a = 3877.0
//    let c = 29573.0
//    func random() -> Double {
//        lastRandom = ((lastRandom * a + c) % m)
//        return lastRandom / m
//    }
//}
class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c) .truncatingRemainder(dividingBy: m) )// truncatingRemainder 求余
        return lastRandom / m
    }
}

//:?? truncatingRemainder

//: ----------
// Mutating 方法要求
// 需要在方法中改变方法所属的实例。
// 在值类型(即结构体和枚举)的实例方法中，将 mutating 关键 字作为方法的前缀，写在 func 关键字之前，表示可以在该方法中修改它所属的实例以及实例的任意属性的 值。
protocol Toggable {
    mutating func toggle()
}

enum OnOffSwitch: Toggable {
    case Off, On
    mutating func toggle() {
        switch self {
        case .Off:
            self = .On
        case .On:
            self = .Off
        }
    }
}

class Class: Toggable {
    func toggle() {
        
    }
}

//: ----------
// 构造器要求
// 协议可以要求采纳协议的类型实现指定的构造器
// 在协议的定义里写下构造器的声明，但不需要写花括号和构造器的实体
protocol InitializedProtocol {
    init(someParameter: Int)
}

// 可以在采纳协议的类中实现构造器，无论是作为指定构造器，还是作为便利构造器。
// 无论哪种情况，你都必须 为构造器实现标上 required 修饰符
class InitialClass: InitializedProtocol {
    // 使用 required 修饰符可以确保所有子类也必须提供此构造器实现，从而也能符合协议
    required init(someParameter: Int) {
        // 构造器实现部分
    }
}

protocol SomeInitialProtocol {
    init()
}

class SomeSuperClass {
    init() {
        
    }
}

class SomeSubClass: SomeSuperClass, SomeInitialProtocol {
    // 因为采纳协议，需要加上 required
    // 因为继承自父类，需要加上 override
    required override init() {
        
    }
}

//: -----------
// 协议作为类型
// 协议可以被当做一个成熟的类型来使用
// • 作为函数、方法或构造器中的参数类型或返回值类型
// • 作为常量、变量或属性的类型
// • 作为数组、字典或其他容器中的元素类型
class Dice {
    let sides: Int
    // 属性的类型为 RandomNumberGenerator ，因此任何采纳了 RandomNumberGenerator  协议的类型的实 例都可以赋值给 generator
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

//: ----------
// 委托代理模式
// 委托是一种设计模式，它允许类或结构体将一些需要它们负责的功能委托给其他类型的实例
// 定义协议来封装那些需要被委托的功能，这样就能确保采纳协议的类型能提供这些功能。
protocol DiceGame {
    var dice: Dice { get }
    func play()
}

protocol DiceGameDelegate {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRool: Int)
    func gameDidEnd(_ game: DiceGame)
}

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    var delegate: DiceGameDelegate?
    init() {
        board = [Int](repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            
        }
    }
    
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRool: Int) {
        numberOfTurns += 1
    }
    
    func gameDidEnd(_ game: DiceGame) {
        
    }
}

//: -----------
//: 通过扩展添加协议一致性
// 即便无法修改源代码，依然可以通过扩展令已有类型采纳并符合协议
// 扩展可以为已有类型添加属性、方法、下标以及构造器，因此可以符合协议中的相应要求。
protocol TextRepresentable {
    var textualDescription: String {get}
}

extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides) - sided dice"
    }
}

//: -----------
//: 通过扩展采纳协议
// 当一个类型已经符合了某个协议中的所有要求，却还没有声明采纳该协议时，可以通过空扩展体的扩展来采纳该协议
struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}
// 从现在起，Hamster 的实例可以作为 TextRepresentable 类型使用
extension Hamster: TextRepresentable {}
// 即使满足了协议的所有要求，类型也不会自动采纳协议，必须显式地采纳协议。

//: ----------
//: 协议类型的集合
// 协议类型可以在数组或者字典这样的集合中使用
let textRepresentableThings: [TextRepresentable] = []


//: ----------
//: 协议继承
// 协议能够继承一个或多个其他协议，可以在继承的协议的基础上增加新的要求。
// 协议的继承语法与类的继承相似，多个被继承的协议间用逗号分隔
protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}

extension SnakesAndLadders: PrettyTextRepresentable {
    var textualDescription: String {
        return ""
    }
    
    var prettyTextualDescription: String {
        var output = textualDescription + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        return output
    }
}

//: ----------
//: 类类型专属协议
// 可以在协议的继承列表中，通过添加 class 关键字来限制协议只能被类类型采纳，而结构体或枚举不能采纳 该协议
// class 关键字必须第一个出现在协议的继承列表中，在其他继承的协议之前
protocol SomeClassOnlyProtocol: class, SomeInitialProtocol {
    // 这里是类类型专属协议的定义部分
}
// 在以上例子中，协议 SomeClassOnlyProtocol 只能被类类型采纳。如果尝试让结构体或枚举类型采纳该协议，则 会导致编译错误。
// 当协议定义的要求需要采纳协议的类型必须是 引用语义 而 非值语义 时，应该采用类类型专属协议。


//: ----------
//: 协议合成
// 需要同时采纳多个协议，你可以将多个协议采用 SomeProtocol & AnotherProtocol 这样的格式进行组合，称为 协议合成(protocol composition)
// 协议合成并不会生成新的、永久的协议类型，而是将多个协议中的要求合成到一个只在局部作用域有效的临时协议中。
protocol Named {
    var name: String {get}
}

protocol Aged {
    var age: Int {get}
}

struct PersonStructProtocol: Named, Aged {
    var name: String
    var age: Int
}

func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}
let brithdayPerson = PersonStructProtocol(name: "Malcom", age: 21)
wishHappyBirthday(to: brithdayPerson)

//: ----------
//: 检查协议一致性
// 使用类型转换中的 is, as 操作符来检查协议一致性, 即是否符合某协议, 并转换到指定的协议类型
// • is 用来检查实例是否符合某个协议，若符合则返回 true ，否则返回 false 。
// • as? 返回一个可选值，当实例符合某个协议时，返回类型为协议类型的可选值，否则返回 nil 。
// • as! 将实例强制向下转换到某个协议类型，如果强转失败，会引发运行时错误。
protocol HasArea {
    var area: Double {get}
}

class Circle: HasArea {
    let pi = 3.1415926
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) {
        self.radius = radius
    }
}

class CountryProtocol0: HasArea {
    var area: Double
    init(area: Double) {
        self.area = area
    }
}

class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}

let objects: [AnyObject] = [
    Circle(radius: 2.0),
    CountryProtocol0(area: 243_610),
    Animal(legs: 4)
]

for object in objects {
    // 当迭代出的元素符合 HasArea协议时，将 as?  操作符返回的可选值通过可选绑定，绑定到objectWithArea 常量上
    // objectWithArea 是HasArea 协议类型的实例，因此 area  属性可以被访问和打印。
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    } else {
        print("Something that doesn't have an area")
    }
}

//: ---------
// 可选的协议要求
// 协议可以定义可选要求，采纳协议的类型可以选择是否实现这些要求
// 在协议中使用optional 关键字作为前缀 来定义可选要求。
// 使用可选要求时(例如，可选的方法或者属性)，它们的类型会自动变成可选的。比如，一个类型为 (Int)->String 的方法会变成 ((Int)->String)? 。
// 协议中的可选要求可通过可选链式调用来使用, 因为采纳协议的类型可能没有实现这些可选要求。
// 可以在可选方法名称后加上 ?来调用可选方法。
// 可选的协议要求只能用在标记  @objc 特性的协议中。
// 标记  @objc 特性的协议只能被继承自 Objective-C 类的类或者 @objc 类采纳，其他类以 及结构体和枚举均不能采纳这种协议。
@objc protocol CounterDataSource {
    @objc optional func incrementForCount(count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    
    func increment() {
        // 1. 由于 dataSource 可能为 nil, 因此在 dataSource 后边加上 nil, 以此表明只在 dataSource 非空时才去调用incrementForCount(_:)
        // 2. 即使 dataSource 存在也无法保证其是否实现了 incrementForCount(_:), 因为这个方法是可选的
        //  因此 incrementForCount 方法同样使用可选链式调用进行调用，只有在该方法被实现的情况下才能调用它, 所以同样在 incrementForCount后面加上 ?
        if let amount = dataSource?.incrementForCount?(count: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement = 3
}

var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4 {
    counter.increment()
    print(counter.count)
}

@objc class TowardsZeroSource:NSObject, CounterDataSource {
    func incrementForCount(count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}

counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5 {
    counter.increment()
    print(counter.count)
}

//: ----------
// 协议扩展
// 协议可以通过扩展来为采纳协议的类型提供属性、方法以及下标的实现。
// 你可以基于协议本身来实现这些功能，而无需在每个采纳协议的类型中都重复同样的实现，也无需使用全局函数。
extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

let generator = LinearCongruentialGenerator()
generator.randomBool()

// 提供默认实现
// 通过协议扩展来为协议要求的属性、方法以及下标提供默认的实现。如果采纳协议的类型为这些要求提供了自己的实现，那么这些自定义实现将会替代扩展中的默认实现被使用。
extension PrettyTextRepresentable {
    var prettyTextualDescription: String {
        return textualDescription
    }
}

// 为协议扩展添加限制条件
// 在扩展协议的时候，可以指定一些限制条件，只有采纳协议的类型满足这些限制条件时，才能获得协议扩展提供 的默认实现。
// 使用 where 子句来描述
// 扩展 Collection 协议，但是只适用于集合中的元素采纳了 TextRepresentable 协议的情 况
// 如果多个协议扩展都为同一个协议要求提供了默认实现，而采纳协议的类型又同时满足这些协议扩展的限制条件，那么将会使用限制条件最多的那个协议扩展提供的默认实现。
extension Collection where Iterator.Element: TextRepresentable {
    
}

// Self-requirement
// When you see Self in a protocol
// it's a placeholder for the type that's going to
// conform to that protocol, the model type
protocol Ordered {
    func precedes(other: Self) -> Bool
}

class Number : Ordered {
    var value: Double = 0
    func precedes(other: Number) -> Bool {
        return self.value < (other).value
    }
}


//: [Next](@next)
