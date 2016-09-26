//: Playground - noun: a place where people can play

import UIKit
//: 基础语法
var favoriteGenres: Set<String> = ["Rock","Classical"]

// 创建空字典
var namesOfIntegers = [Int: String]()
namesOfIntegers[16] = "sixteen"

namesOfIntegers = [:]   // 现在 namesOfInteger 又成为一个[ Int: String] 空字典

var ariports: [String: String] = ["YXZ": "Toront"]

let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("(0, 0)")
case (_, 0):
    print("\(somePoint.0) ,0)")
case (0, _):
    print("(0, \(somePoint.1))")
case (-2...2, -2...2):
    print("(\(somePoint.0), \(somePoint.1)) is inside the box")
default:
    print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
}


let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y)")
default:
    print("default")
}

let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    break
case let (x, y):
    break
}

let someCharacter: Character = "e"
switch someCharacter {
case "a", "e", "i", "o", "u":
    print("\(someCharacter) is a vowel")

case "b", "c", "d", "f",
     "n", "p":
    print("\(someCharacter) is a consonant")
default:
    break
}

//: 函数
func minMax(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty {
        return nil
    }
    
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}


///
///
/// - parameter firstParameterName:  参数名称
/// - parameter secondParameterName: 参数名称
/// - 默认参数名称 = 参数标签(使用参数名称作为参数标签, 除非使用 _ 来忽略)
func someFunction(firstParameterName: Int, secondParameterName: Int) {
    
}

someFunction(firstParameterName: 1, secondParameterName: 1)


///
/// - parameter firstParameterLabel: 参数标签
/// - parameter secondParameterLabel: 参数标签
/// - parameter firstParameterName:  参数名称
/// - parameter secondParameterName: 参数名称
func function(firstParameterLabel firstParameterName: Int, secondParameterLabel secondParameterName: Int) -> Int {
    return firstParameterName + secondParameterName
}
function(firstParameterLabel: 1, secondParameterLabel: 1)


///
/// - parameter _ : 忽略第一个参数标签
/// - parameter firstParamterName: 第一个参数名称
/// - parameter secondParameterName: 第二个参数名称
func otherFunction(_ firstParamterName: Int, secondParameterName: Int) {
    
}
otherFunction(1, secondParameterName: 2)


///
///
/// - parameter parameterWithOutDefault: 不带默认值的参数
/// - parameter parameterWithDefault:    带默认值的参数
func defaultParamFunc(parameterWithOutDefault: Int, parameterWithDefault: Int = 12) {
    
}


/// 函数参数默认是常量, 不能再函数体中修改函数参数值, 
/// “如果你想要一个函数可以修改参数的值，并且想要在这些修改在函数调用结束后仍然存在，那么就应该把这个参数定义为输入输出参数（In-Out Parameters）。”
///
/// - parameter first:
/// - parameter second:
func swapTwoInts(first: inout Int, second: inout Int) {
    let temp = first
    first = second
    second = temp
}

var someInt = 3
var anotherInt = 107
swapTwoInts(first: &someInt, second: &anotherInt)

//: 闭包
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}

var reversedNames = names.sorted(by: backward)

reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})

// 因为 sorted 接受一个( String, String) -> Bool 的函数, 由于 Swift 的类型推断
// 函数参数类型及返回值可以忽略
reversedNames = names.sorted(by: {s1, s2 in return s1 < s2})

// 单行表达式闭包可以省略 return 关键字
// “闭包函数体只包含了一个单一表达式（s1 > s2），该表达式返回 Bool 类型值，因此这里没有歧义，return 关键字可以省略”
reversedNames = names.sorted(by: {s1, s2 in s1 < s2})

// “Swift 自动为内联闭包提供了参数名称缩写功能，你可以直接通过 $0，$1，$2 来顺序调用闭包的参数，以此类推”
// “in关键字也同样可以被省略，因为此时闭包表达式完全由闭包函数体构成”
reversedNames = names.sorted(by: { $0 > $1})

// 尾随闭包
func someFuncThatTaksAClosure(closure: () -> Void) {
    // 函数体
}

// 正常函数调用
someFuncThatTaksAClosure(closure: {
    // 闭包体
})

// 尾随闭包调用
someFuncThatTaksAClosure() {
    // 闭包主体
}

// 如果闭包表达式是函数或者方法的唯一参数, 当使用尾随闭包时, 可以将() 省略掉
someFuncThatTaksAClosure { 
    // 闭包主体
}

// “闭包可以在其被定义的上下文中捕获常量或变量。即使定义这些常量和变量的原作用域已经不存在，闭包仍然可以在闭包函数体内引用和修改这些值。
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}
let incrementByTen = makeIncrementer(forIncrement: 10)
incrementByTen()
incrementByTen()

// 逃逸闭包
// 当一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才被执行，我们称该闭包从函数中逃逸。
// 在参数名之前标注 @escaping，用来指明这个闭包是允许“逃逸”出这个函数的。
var completionHandlers:[() -> Void] = []
func someFunctionWithEscapingClousure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

func someFunctionWithNonescapingClouse(clouse: () -> Void) {
    clouse()
}
// “将一个闭包标记为 @escaping 意味着你必须在闭包中显式地引用 self。”
// “在下面的代码中，传递到 someFunctionWithEscapingClosure(_:) 中的闭包是一个逃逸闭包，这意味着它需要显式地引用 self。相对的，传递到 someFunctionWithNonescapingClosure(_:) 中的闭包是一个非逃逸闭包，这意味着它可以隐式引用 self。”

class SomeClass {
    var x = 10
    func doSomething()  {
        someFunctionWithEscapingClousure {
            self.x = 10
        }
        
        someFunctionWithNonescapingClouse { 
            x = 200
        }
    }
}

// “自动闭包是一种自动创建的闭包，用于包装传递给函数作为参数的表达式。这种闭包不接受任何参数，当它被调用的时候，会返回被包装在其中的表达式的值。这种便利语法让你能够省略闭包的花括号，用一个普通的表达式来代替显式的闭包”
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

let customerProvider = { customersInLine.remove(at: 0) }

// server 接收一个返回值为 String 的闭包
func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())")
}
serve { () -> String in
    customersInLine.remove(at: 0)
}

func serverAutoClosure(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())")
}
// “这个版本的 serve(customer:) 完成了相同的操作，不过它并没有接受一个显式的闭包，而是通过将参数标记为 @autoclosure 来接收一个自动闭包。现在你可以将该函数当作接受 String 类型参数（而非闭包）的函数来调用。customerProvider 参数将自动转化为一个闭包，因为该参数被标记了 @autoclosure 特性”

serverAutoClosure(customer: "HH")

// 逃逸, 自动闭包
var customerProviders = [() -> String]()
func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
    customerProviders.append(customerProvider)
}

collectCustomerProviders(customersInLine.remove(at: 0))
collectCustomerProviders(customersInLine.remove(at: 0))

for customerProvider in customerProviders {
    customerProvider()
}
// “在上面的代码中，collectCustomerProviders(_:) 函数并没有调用传入的 customerProvider 闭包，而是将闭包追加到了 customerProviders 数组中。这个数组定义在函数作用域范围外，这意味着数组内的闭包能够在函数返回之后被调用。因此，customerProvider 参数必须允许“逃逸”出函数作用域。

//: 枚举

//: 类和结构体

//: 自动引用计数
/*class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?

reference1 = Person(name: "John Appleseed")
*/

// 类实例之间的循环引用
// 每个 Person 实例都有一个 name 属性和一个初始化为nil 的 apartment 属性, 
// apartment 属性是可选的, 因为并不是每个人都有公寓
/*class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    
    var apartment: Apartment?
    
    deinit {
        print("\(name) is being deinitialized")
    }
}*/

// “每个Apartment实例有一个叫unit，类型为String的属性，并有一个可选的初始化为nil的tenant属性。tenant属性是可选的，因为一栋公寓并不总是有居民。”
/*class Apartment {
    let unit: String
    init(unit: String) {
        self.unit = unit
    }
    
    var tenant: Person?
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}

var john: Person?
var unit4A: Apartment?
john = Person(name: "John Applesseed")
unit4A = Apartment(unit: "4A")*/
// “变量john现在有一个指向Person实例的强引用，而变量unit4A有一个指向Apartment实例的强引用”

//“现在你能够将这两个实例关联在一起，这样人就能有公寓住了，而公寓也有了房客。注意感叹号是用来展开和访问可选变量john和unit4A中的实例，这样实例的属性才能被赋值”
//john!.apartment = unit4A
//unit4A!.tenant = john
// “Person实例现在有了一个指向Apartment实例的强引用，而Apartment实例也有了一个指向Person实例的强引用。因此，当你断开john和unit4A变量所持有的强引用时，引用计数并不会降为0，实例也不会被 ARC 销毁”

// “当你把这两个变量设为nil时，没有任何一个析构函数被调用。循环强引用会一直阻止Person和Apartment类实例的销毁，这就在你的应用程序中造成了内存泄漏”
//john = nil
//unit4A = nil

// 解决实例之间的循环引用
// “对于生命周期中会变为nil的实例使用弱引用。相反地，对于初始化赋值后再也不会被赋值为nil的实例，使用无主引用。
// “在上面Apartment的例子中，一个公寓的生命周期中，有时是没有“居民”的，因此适合使用弱引用来解决循环强引用”
// “弱引用必须被声明为变量，表明其值能在运行时被修改。弱引用不能被声明为常量。”

class Apartment {
    let unit: String
    init(unit: String) {
        self.unit = unit
    }
    
    weak var tenant: Person?
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}

// 无主引用
// “无主引用是永远有值的”
// “无主引用总是被定义为非可选类型”
// “在声明属性或者变量时，在前面加上关键字unowned表示这是一个无主引用”
// “由于无主引用是非可选类型，你不需要在使用它的时候将它展开。无主引用总是可以被直接访问。”

// “Customer和CreditCard，模拟了银行客户和客户的信用卡。这两个类中，每一个都将另外一个类的实例作为自身的属性。这种关系可能会造成循环强引用。”

// “Customer和CreditCard之间的关系与前面弱引用例子中Apartment和Person的关系略微不同。在这个数据模型中，一个客户可能有或者没有信用卡，但是一张信用卡总是关联着一个客户。为了表示这种关系，Customer类有一个可选类型的card属性，但是CreditCard类有一个非可选类型的customer属性。”

// “能通过将一个number值和customer实例传递给CreditCard构造函数的方式来创建CreditCard实例。这样可以确保当创建CreditCard实例时总是有一个customer实例与之关联”

class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit {
        print("Card #\(number) is being deinitialized")
    }
}

/*var john: Customer?
john = Customer(name: "John Appleseed")
john!.card = CreditCard(number: 1234_5678_9012_3456, customer: john!)*/

// 1. “Person和Apartment的例子展示了两个属性的值都允许为nil，并会潜在的产生循环强引用。这种场景最适合用弱引用来解决。

// 2. Customer和CreditCard的例子展示了一个属性的值允许为nil，而另一个属性的值不允许为nil，这也可能会产生循环强引用。这种场景最适合通过无主引用来解决。

// 3. 第三种场景，在这种场景中，两个属性都必须有值，并且初始化完成后永远不会为nil。在这种场景中，需要一个类使用无主属性，而另外一个类使用隐式解析可选属性。

class Country {
    let name: String
    var capitalCity: City!  // 初始化为 nil
    init(name: String, capitalName: String) {
        self.name = name
        // “由于capitalCity默认值为nil，一旦Country的实例在构造函数中给name属性赋值后，整个初始化过程就完成了。这意味着一旦name属性被赋值后，Country的构造函数就能引用并传递隐式的self。”
        self.capitalCity = City(name: capitalName, country: self)
    }
}

class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

// 闭包循环引用
class HTMLElement {
    let name: String
    let text: String?
    
    // self -> asHTML 闭包
    // asHTML 闭包 -> self 循环引用
    lazy var asHTML: (Void) -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name)/>"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

let heading = HTMLElement(name: "h1", text: "default text")
let defaultText = "some default text"
print(heading.asHTML())
heading.asHTML = {
    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}
print(heading.asHTML())

// 解决闭包的循环引用, 使用捕获列表
// “在定义闭包时同时定义捕获列表作为闭包的一部分，通过这种方式可以解决闭包和类实例之间的循环强引用。捕获列表定义了闭包体内捕获一个或者多个引用类型的规则。”
// “只要在闭包内使用self的成员，就要用self.someProperty或者self.someMethod()（而不只是someProperty或someMethod()）。这提醒你可能会一不小心就捕获了self。”
// 定义捕获列表
// “捕获列表中的每一项都由一对元素组成，一个元素是weak或unowned关键字，另一个元素是类实例的引用（例如self）或初始化过的变量（如delegate = self.delegate!）。这些项在方括号中用逗号分开。

// 如果闭包有参数列表和返回类型，把捕获列表放在它们前面”
/*
 lazy var someClosure: (Int, String) -> String = {
    [unowned self, weak delegate = self.delegate!] (index: Int, stringToProgress: String) -> String in
    // 闭包体
}

// “如果闭包没有指明参数列表或者返回类型，即它们会通过上下文推断，那么可以把捕获列表和关键字in放在闭包最开始的地方”
lazy var someClosure: (Void) -> String = {
    [unowned self, weak delegate = self.delegate!] in
    // 这里是闭包的函数体
}
 */

// 是无主引用还是弱引用
// 1. “在闭包和捕获的实例总是互相引用并且总是同时销毁时，将闭包内的捕获定义为无主引用”
// 2. “在被捕获的引用可能会变为nil时，将闭包内的捕获定义为弱引用。弱引用总是可选类型，并且当引用的实例被销毁后，弱引用的值会自动置为nil。这使我们可以在闭包体内检查它们是否存在。”
// 3. “如果被捕获的引用绝对不会变为nil，应该用无主引用，而不是弱引用”
class HTMLElement_1 {
    let name: String
    let text: String?
    
    // self -> asHTML 闭包
    // asHTML 闭包 -> self 循环引用
    lazy var asHTML: (Void) -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name)/>"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}
// “上面的HTMLElement实现和之前的实现一致，除了在asHTML闭包中多了一个捕获列表。这里，捕获列表是[unowned self]，表示“将self捕获为无主引用而不是强引用”



//: 可选链式调用
// “可选链式调用（Optional Chaining）是一种可以在当前值可能为nil的可选值上请求和调用属性、方法及下标的方法。如果可选值有值，那么调用就会成功；如果可选值是nil，那么调用将返回nil。多个调用可以连接在一起形成一个调用链，如果其中任何一个节点为nil，整个调用链都会失败，即返回nil”
// “返回结果都是一个可选值。”
/*
class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}*/

//let john = Person()
// “如果使用叹号（!）强制展开获得这个john的residence属性中的numberOfRooms值，会触发运行时错误，因为这时residence没有可以展开的值”
//let roomCount = john.residence!.numberOfRooms
// “可选链式调用提供了另一种访问numberOfRooms的方式，使用问号（?）来替代原来的叹号（!）”
//if let roomCount = john.residence?.numberOfRooms {
    // 有值
//} else {
    // 无值
//}

//: --------------------------------
// 可选链式调用定义模型类
class Person {
    var residence: Residence?
}

class Residence {
    var rooms = [Room]()
    var address: Address?
    var numberOfRooms: Int {
        return rooms.count
    }
    
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        
        set {
            rooms[i] = newValue
        }
    }
    
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
}

class Room {
    let name: String
    init(name: String) {
        self.name = name
    }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if buildingNumber != nil && street != nil {
            return "\(buildingNumber) \(street)"
        } else {
            return nil
        }
    }
}

let john = Person()
if let roomCount = john.residence?.numberOfRooms {
    
} else {
    
}

func createAddress() -> Address {
    print("Function was called")
    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"
    return someAddress
}

//: --------------------------------
// 可选链访问属性
// “可以通过可选链式调用在一个可选值上访问它的属性，并判断访问是否成功”
let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
// “赋值过程是可选链式调用的一部分，这意味着可选链式调用失败时，等号右侧的代码不会被执行”
john.residence?.address = someAddress
john.residence?.address = createAddress() // 可选链失败

// 可选链调用方法
// “可以通过可选链式调用来调用方法，并判断是否调用成功，即使这个方法没有返回值”
// “printNumberOfRooms, 这个方法没有返回值。然而，没有返回值的方法具有隐式的返回类型Void，如无返回值函数中所述。这意味着没有返回值的方法也会返回()，或者说空的元组。”
// 如果在可选值上通过可选链式调用来调用这个方法，该方法的返回类型会是 Void? ，而不是 Void ，因为通过可选 链式调用得到的返回值都是可选的。

if john.residence?.printNumberOfRooms() != nil {
    // TODO:
} else {
    // TODO:
}

// 判断通过可选链式调用为属性赋值是否成功
// 通过可选链式调用给属性赋 值会返回 Void? ，通过判断返回值是否为 nil 就可以知道赋值是否成功
if (john.residence?.address = someAddress) != nil {
    // 赋值成功
} else {
    // 赋值失败
}

//: --------------------------------
// 可选链访问下标
// 通过可选链式调用，我们可以在一个可选值上访问下标，并且判断下标调用是否成功
// 通过可选链式调用访问可选值的下标时，应该将问号放在下标方括号的前面而不是后面。可选链式调用的问号一
// 般直接跟在可选表达式的后面。
if let firstRoomName = john.residence?[0].name { // 问号直接放在 john.residence 的后面，并且在方括号的前面，因为 john.residence 是可选值
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}

// 这次赋值同样会失败，因为 residence 目前是 nil 。
john.residence?[0] = Room(name: "Bathroom")

// 创建一个 Residence 实例，并为其 rooms 数组添加一些 Room 实例，然后将 Residence 实例赋值给 sidence ，那就可以通过可选链和下标来访问数组中的元素
let johnsHouse = Residence()
johnsHouse.rooms.append(Room(name: "Living Room"))
johnsHouse.rooms.append(Room(name: "Kitchen"))
john.residence = johnsHouse

if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}


// 访问可选类型的下标
// 如果下标返回可选类型值，比如 Swift 中 Dictionary 类型的键的下标，可以在下标的结尾括号后面放一个问号 来在其可选返回值上进行可选链式调用
var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brian"]?[0] = 72

//: -----------
// 连接多层可选链调用
// • 通过可选链式调用访问一个 Int 值，将会返回 Int? ，无论使用了多少层可选链式调用。
// • 类似的，通过可选链式调用访问 Int? 值，依旧会返回 Int? 值，并不会返回 Int?? 。
if let johnsStreet = john.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}
// 上面的例子中， street 的属性为 String? 。 john.residence?.address?.street 的返回值也依然 是 String? ，即使已经使用了两层可选链式调用。

//如果为 john.residence.address 赋值一个 Address 实例，并且为 address 中的 street 属性设置一个有效值，我 们就能过通过可选链式调用来访问 street 属性:
let johnsAddress = Address()
johnsAddress.buildingName = "The Larches"
johnsAddress.street = "Laurel Street"
john.residence?.address = johnsAddress
if let johnsStreet = john.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}
// 打印 “John's street name is Laurel Street
// 在上面的例子中，因为 john.residence 包含一个有效的 Residence 实例，所以对 john.residence 的 address 属性 赋值将会成功。

//: ----------
// 在方法的可选返回值上进行可选链式调用
// 一个可选值上通过可选链式调用来调用方法，并且可以根据需要继续在方法的可选返回值上进行可选链式调用
// 通过可选链式调用来调用 Address 的 buildingIdentifier() 方法。这个方法返回 String? 类型 的值。如上所述，通过可选链式调用来调用该方法，最终的返回值依旧会是 String? 类型
if let buildingIdenfier = john.residence?.address?.buildingIdentifier() {
    print("John's building identifier is \(buildingIdenfier).")
}

// 如果要在该方法的返回值上进行可选链式调用，在方法的圆括号后面加上问号即可:
if let beginsWithThe = john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    print("John's building identifier begins with \"The\".")
} else {
    print("John's building identifier does not begin with \"The\".")
}
// 在上面的例子中，在方法的圆括号后面加上问号是因为你要在 buildingIdentifier() 方法的可选返回值上进行 可选链式调用，而不是方法本身。


//: 错误处理

//: 类型转换
// 类型转换 可以判断实例的类型，也可以将实例看做是其父类或者子类的实例
// 类型转换在 Swift 中使用 is 和 as 操作符实现。这两个操作符提供了一种简单达意的方式去检查值的类型 或者转换它的类型。
class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

// Swift 的类型检测器能够推断出 Movie 和 Song 有共 同的父类 MediaItem ，所以它推断出 [MediaItem] 类作为 library 的类型
// 数组 library 的类型被推断为 [MediaItem]
let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]
// 在幕后 library 里存储的媒体项依然是 Movie 和 Song 类型的。但是，若你迭代它，依次取出的实例会是 MediaItem 类型的，而不是 Movie 和 Song 类型。

//: ---------
// 类型检查
// 用类型检查操作符( is )来检查一个实例是否属于特定子类型。若实例属于那个子类型，类型检查操作符返回
// true ，否则返回 false 。
var movieCount = 0
var songCount = 0

for item in library {
    // 当前 MediaItem 是一个 Movie 类型的实例
    if item is Movie {
        movieCount += 1
    } else {
        songCount += 1
    }
}

//: -----------
// 向下转型
// 某类型的一个常量或变量可能在幕后实际上属于一个子类。
//当确定是这种情况时，你可以尝试向下转到它的子类型，用类型转换操作符(as? 或 as!)。
// as? : 条件形式(conditional form) as? 返回一个你 试图向下转成的类型的可选值(optional value)。
// as! : 强制形式 as! 把试图向下转型和强制解包(force-unwrap s)转换结果结合为一个操作。
// 1. 当你不确定向下转型可以成功时，用类型转换的条件形式( as? ), 条件形式的类型转换总是返回一个可选值(o ptional value)，并且若下转是不可能的，可选值将是 nil 。这使你能够检查向下转型是否成功。
// 2. 可以确定向下转型一定会成功时，才使用强制形式( as! )。当你试图向下转型为一个不正确的类型 时，强制形式的类型转换会触发一个运行时错误。

// 数组中的每一个 item 可能是 Movie 或 Song 。事前你不知道每个 item 的真实类型，所以 这里使用条件形式的类型转换( as? )去检查循环里的每次下转
for item in library {
    if let movie = item as? Movie {
        
    } else if let song = item as? Song {
        
    }
}

//: -----------
// Any, AnyObject
// • AnyObject 可以表示任何类类型的实例。
// • Any 可以表示任何类型，包括函数类型。

// AnyObject
//
// 当我们使用 Cocoa APIs 时，我们会接收到一个 [AnyObject] 类型数组, 或者说一个任意类型对象的数组”。Objective-C现在支持明确的数组类型，但早期版本的Objective-C并没有这个功能。不管怎样，你都可以 确信API提供的信息能够正确的表明数组中的元素类型。
// 在这些情况下，你可以使用强制形式的类型转换(as!)来下转数组中的每一项到比 AnyObject  更明确的类 型，不需要可选解包(optional unwrapping)。
let someObjects: [AnyObject] = [
    Movie(name: "2001: A Space Odyssey", director: "Stanley Kubrick"),
    Movie(name: "Moon", director: "Duncan Jones"),
    Movie(name: "Alien", director: "Ridley Scott")
]
// 因为知道这个数组只包含 Movie 实例，你可以直接用(as!)下转并解包到非可选的 Movie 类型:
for object in someObjects {
    let movie = object as! Movie
    print("Movie: '\(movie.name)', dir. \(movie.director)")
}

// 下转 someObjects 数组为 [Movie] 类型而不是下转数组中的每一项
for movie in someObjects as! [Movie] {
    print("Movie: '\(movie.name)', dir. \(movie.director)")
}

// Any 
// 使用 Any 类型来和混合的不同类型一起工作，包括函数类型和非类类型。它创建了一个可以存 储 Any 类型的数组 things
var things = [Any]()
things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })

// as 操作: 向上转型(具体-> 抽象, 子类->父类)
for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called '\(movie.name)', dir. \(movie.director)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
}


//: 嵌套类型

//: 扩展(Extension)
// Swift 中的扩展可以:
// • 添加计算型属性和计算型类型属性 • 定义实例方法和类型方法
// • 提供新的构造器
// • 定义下标
// • 定义和使用新的嵌套类型
// • 使一个已有类型符合某个协议
//  扩展可以为一个类型添加新的功能，但是不能重写已有的功能。
// 如果你通过扩展为一个已有类型添加新功能，那么新功能对该类型的所有已有实例都是可用的，即使它们是在这
// 个扩展定义之前创建的。

//: --------
// 计算属性
// 扩展可以添加新的计算型属性，但是不可以添加存储型属性，也不可以为已有属性添加属性观察器。
extension Double {
    // 这些属性是只读的计算型属性，为了更简洁，省略了 get 关键字。它们的返回值是 Double ，而且可以用于所 有接受 Double 值的数学计算中
    var km: Double { return self * 1_000.0}
    var m: Double { return self}
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0}
    var ft: Double { return self / 3.28084 }
}
let oneInch = 35.4.mm
let threeFeet = 3.ft

//: ----------
// 构造器
// 扩展可以为已有类型添加新的构造器。
// 这可以让你扩展其它类型，将你自己的定制类型作为其构造器参数，或者
// 提供该类型的原始实现中未提供的额外初始化选项

// 扩展能为类添加新的便利构造器，但是它们不能为类添加新的指定构造器或析构器。
// 指定构造器和析构器必须总是由原始的类实现来提供。
struct Size {
    var width = 0.0, height = 0.0
}

struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
}
let defualtRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))

// 如果你使用扩展为一个值类型添加构造器，同时该值类型的原始实现中未定义任何定制的构造器且所有存储属性 提供了默认值，那么我们就可以在扩展中的构造器里调用默认构造器和逐一成员构造器
extension Rect {
    // 结构体 Rect 未提供定制的构造器，因此它会获得一个逐一成员构造器。
    // 又因为它为所有存储型属性提供了 默认值，它又会获得一个默认构造器。
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

//: -----------
// 方法
// 扩展可以为已有类型添加新的实例方法和类型方法
extension Int {
    // 重复执行多少次 task 操作
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

3.repetitions { 
    print("Hello")
}

// 可变实例方法
// 通过扩展添加的实例方法也可以修改该实例本身。
// 结构体和枚举类型中修改 self 或其属性的方法必须将该实例 方法标注为 mutating ，
// 正如来自原始实现的可变方法一样。
extension Int {
    mutating func square() {
        self = self * self
    }
}
var squarInt = 3
squarInt.square()
print(squarInt)

//: ----------
// 下标
// 扩展可以为已有类型添加新下标
extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}
print(788880[0])// 返回0

//: ---- 嵌套类型
// 扩展可以为已有的类、结构体和枚举添加新的嵌套类型
extension Int {
    enum Kind {
        case Negative, Zero, Positive
    }
    
    var kind: Kind {
        switch self {
        case 0:
            return .Zero
        case let x where x > 0:
            return .Positive
        default:
            return .Negative
        }
    }
}


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

//: 泛型(Generics)



