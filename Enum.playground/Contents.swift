//: Playground - noun: a place where people can play

//: Stackoverflow 上关于Swift Enum 的Topics
// enum 提供了一个“一系列有关数据”的集合
enum Direction {
    case up
    case down
    case left
    case right
}

// enum Direction { case up, down, left, right }

// 你可以根据枚举的值的全名(类型名.枚举值名)去使用，如果Swift能够推断出它的类型，便可以省略它的类型名
let dir = Direction.up
let dir_1: Direction = Direction.up
let dir_2: Direction = .up

func move(direction: Direction) {
    
}
move(direction: Direction.up)
move(direction: .up)

// 枚举最基本的比较方式是使用switch
switch dir {
case .up:
    // FIXME: handle the up case
    break;
case .down:
    // handle the down case
    break;
case .left:
    // handle the left case
    break;
case .right:
    // handle the right case
    break;
}
// Simple enums are automatically Hashable, Equatable and have string conversions
if dir == .down {   // Equaltable
}

let dirs: Set<Direction> = [.right, .left]



// 带有关联值的Enum
enum Action {
    case jump
    case kick
    case move(distance: Float) // "move" 有一个关联的distance
}
func performAction(action: Action) {
    
}

performAction(action: .jump)
performAction(action: .kick)
performAction(action: .move(distance: 3.3))
performAction(action: .move(distance: 5.5))

var action: Action = .move(distance: 33)
switch action{
case .jump:
    break
case .kick:
    break
case .move(let distance):      // 函数的参数为let类型
    print("Moving: \(distance)")
}

// 带有关联值的enum默认没有实现Equaltable接口，所以不能使用 == 来判断两个值相等
// 可以使用 if case 来抽取单独的case
if case .jump = action {
    
}

if case .move(let distance) = action {
    print("Moving: \(distance)")
}

//guard case .move(let distance) = action else {
//    print("Action is not move")
//    return
//}

extension Action: Equatable {
    static func ==(lhs: Action, rhs: Action) -> Bool {
        switch lhs {
        case .jump: if case .jump = rhs { return true}
        case .kick: if case .kick = rhs { return true }
        case .move(let lhsDistance):
            // rhs 是否是 .move(let distance)
            if case .move(let rhsDistance) = rhs { return lhsDistance == rhsDistance }
        }
        return false
    }
}

// 递归Enum
/*
Error: recursive enum 'Tree<T>' is not marked 'indirect'
 
enum Tree<T> {
    case leaf(T)
    case branch(Tree<T>, Tree<T>)
}*/
// indrect 关键字告诉编译器间接地处理这个枚举的 case。也可以对整个枚举类型使用这个关键字
enum Tree<T> {
    case leaf(T)
    indirect case branch(Tree<T>, Tree<T>)
}

// Raw , Hash values
// Enums without payloads can have raw values of any literal type:
enum Rotation: Int {
    case up = 0
    case left = 90
    case upsideDown = 180
    case right = 270
}

// Enums without any specific type do not expose the rawValue property
enum Rotation_1 {
    case up
    case right
    case down
    case left
}
var rotation = Rotation.up
rotation.rawValue

let foo = Rotation_1.up
// foo.rawValue : Error

// Integer raw values are assumed to start at 0 and increase monotonically
enum MetasyntacticVariable: Int {
    case foo  // rawValue is automatically 0
    case bar  // rawValue is automatically 1
    case baz = 7
    case quux  // rawValue is automatically 8
}

// String raw values can be synthesized automatically:
enum MarsMoon: String {
    case phobos  // rawValue is automatically "phobos"
    case deimos  // rawValue is automatically "deimos"
}

// You can also create an enum from a raw value using init?(rawValue:):
rotation = Rotation(rawValue: 0)!   // up
let otherRotation = Rotation(rawValue: 45) // nil, rawValue = 45 没有对应的值

let str = "phobos"
if let moon = MarsMoon(rawValue: str) {
    print("Mars has a moon named \(str)")
} else {
    print("Mars doesn't have a moon named \(str)")
}

// If you wish to get the hash value of a specific enum you can access it's hashValue,
// The hash value will return the index of the enum starting from 0 (hash值总是从0开始).
let quux = MetasyntacticVariable(rawValue: 8)   // quux
quux!.hashValue // 3(从0 开始第3个case）

// 初始化
enum CompassDirection {
    case north(Int)
    case south(Int)
    case east(Int)
    case west(Int)
    
    init?(degress: Int) {
        switch degress {
        case 0...45:
            self = .north(degress)
        case 46...135:
            self = .south(degress)
        case 136...225:
            self = .west(degress)
        case 316...360:
            self = .north(degress)
        default:
            return nil
        }
    }
    
    // 枚举可以存储计算属性
    var value: Int {
        switch self{
        case .north(let degrees):
            return degrees
        case .south(let degrees):
            return degrees
        case .east(let degrees):
            return degrees
        case .west(let degrees):
            return degrees
        }
    }
}

// Enum 实现协议
protocol ChangeDirection {
    // 对应值类型的结构体，枚举而言，要想通过函数改变self的值，应该使用mutating函数
    mutating func changeDirection()
}

enum DirectionInfo {
    case up, down, left, right
    
    init(oppositeTo otherDirection: DirectionInfo) {
        self = otherDirection.opposite
    }
    
    var opposite: DirectionInfo {
        switch self {
        case .up:
            return .down
        case .down:
            return .up
        case .left:
            return .right
        case .right:
            return .left
        }
    }
}

extension DirectionInfo: ChangeDirection {
    mutating func changeDirection() {
        self = .left
    }
}

// You can nest enumerations one inside an other, this allows you to structure hierarchical enums to be more organized and clear.
enum Orchestra {
    enum Strings {
        case violin
        case viola
        case cello
        case doubleBasse
    }
    
    enum Keyboards {
        case piano
        case celesta
        case harp
    }
    
    enum Woodwinds {
        case flute
        case oboe
        case clarinet
        case bassoon
        case contrabassoon
    }
}
let instrment1 = Orchestra.Strings.viola
let instrment2 = Orchestra.Keyboards.piano




