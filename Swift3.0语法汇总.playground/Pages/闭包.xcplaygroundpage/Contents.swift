//: [Previous](@previous)

import Foundation

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


//: [Next](@next)
