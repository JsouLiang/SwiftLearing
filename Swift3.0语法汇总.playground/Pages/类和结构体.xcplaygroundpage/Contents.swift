//: [Previous](@previous)

import Foundation

/*
类和结构体对比
Swift 中类和结构体有很多共同点。共同处在于:
• 定义属性用于存储值
• 定义方法用于提供功能
• 定义下标操作使得可以通过下标语法来访问实例所包含的值
• 定义构造器用于生成初始化值
• 通过扩展以增加默认实现的功能 
• 实现协议以提供某种标准功能
 
与结构体相比，类还有如下的附加功能:
• 继承允许一个类继承另一个类的特征
• 类型转换允许在运行时检查和解释一个类实例的类型
• 析构器允许一个类实例释放任何其所被分配的资源
• 引用计数允许对一个类的多次引用
*/
struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

// 所有结构体都有一个自动生成的成员逐一构造器
// 类实例没有默认的成员逐一构造器

//: -----------
// 结构体和枚举是值安全
// 值类型被赋予给一个变量、常量或者被传递给一个函数的时候，其值会被拷贝。
// 在 Swift 中，所有的基本类型:整数(Integer)、浮 点数(floating-point)、布尔值(Boolean)、字符串(string)、数组(array)和字典(dictionary)，都是 值类型，并且在底层都是以结构体的形式所实现
// 在 Swift 中，所有的结构体和枚举类型都是值类型。这意味着它们的实例，以及实例中所包含的任何值类型属 性，在代码中传递的时候都会被复制
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
// 因为 Resolution 是一个结构体，所以 的值其实是 hd 的一个拷贝副本，而不是 hd 本身。尽管 hd 和 cinema 有着相同的宽(width)和高(heigh t)，但是在幕后它们是两个完全不同的实例。

cinema.width = 2048
print("cinema is now \(cinema.width) piexs wide")
print("hd is now \(hd.width) piexs wide")
// 在将 hd 赋予给 cinema 的时候，实际上是将 hd 中所存储的值进行拷贝，然后将拷贝的数据存储到新的 cinema 实 例中。
// 结果就是两个完全独立的实例碰巧包含有相同的数值。由于两者相互独立，因此将 cinema 的 width 修改为2048 并不会影响 hd 中的 width 的值。

//: ----------
// 类是引用类型
// 与值类型不同，引用类型在被赋予到一个变量、常量或者被传递到一个函数时，其值不会被拷贝
// 引用的是已存在的实例本身而不是其拷贝。
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
// 类是引用类型，所以 tenEight 和 alsoTenEight 实际上引用的是相同的 VideoMode 实例。换句话说，它们是 同一个实例的两种叫法。
print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
// 输出 "The frameRate property of theEighty is now 30.0"

// 恒等运算
// 类是引用类型，有可能有多个常量和变量在幕后同时引用同一个类实例。
// 够判定两个常量或者变量是否引用同一个类实例将会很有帮助
/*
 • 等价于(===)
 • 不等价于( !== )
 运用这两个运算符检测两个常量或者变量是否引用同一个实例
 */
if tenEighty === alsoTenEighty {
    
}

/**
 “等价于”(用三个等号表示， === )与“等于”(用两个等号表示， == )的不同
 
 • “等价于”表示两个类类型(class type)的常量或者变量引用同一个类实例。
 • “等于”表示两个实例的值“相等”或“相同”，判定时要遵照设计者定义的评判标准，因此相对于“相 等”来说，这是一种更加合适的叫法。
 */

//: 类和结构体的选择
/**
 当符合一条或多条以下条件时，请考虑构建结构体:
 • 该数据结构的主要目的是用来封装少量相关简单数据值。
 • 有理由预计该数据结构的实例在被赋值或传递时，封装的数据将会被拷贝而不是被引用。
 • 该数据结构中储存的值类型属性，也应该被拷贝，而不是被引用。
 • 该数据结构不需要去继承另一个既有类型的属性或者行为。
 
 举例来说，以下情境中适合使用结构体:
 • 几何形状的大小，封装一个 width 属性和 height 属性，两者均为 Double 类型。
 • 一定范围内的路径，封装一个 start 属性和 length 属性，两者均为 Int 类型。
 • 三维坐标系内一点，封装 x ， y 和 z 属性，三者均为 Double 类型。
 */

// Swift 中，许多基本类型，诸如 String ， Array 和 Dictionary 类型均以结构体的形式实现。
// 这意味着被赋值给 新的常量或变量，或者被传入函数或方法中时，它们的值会被拷贝。

//: [Next](@next)
