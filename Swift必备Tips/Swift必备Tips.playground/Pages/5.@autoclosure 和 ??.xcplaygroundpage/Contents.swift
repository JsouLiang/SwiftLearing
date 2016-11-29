//: [Previous](@previous)

// @autoclosure就是把表达式自动封装成一个闭包
func logIfTrue(_ predicate: () -> Bool) {
    if predicate() {
        print("True")
    }
}

// 常规调用
logIfTrue({return 2 > 1})

// 变形1. 如果closure只有一个返回值并且只有一条语句 可以省略 return
logIfTrue({ 2 > 1 })

// 变形2. 如果闭包位于函数最尾部，可以使用尾随闭包
logIfTrue{ 2 > 1 }

// 变形3. 使用 @autoclosure将一个表达式自动转为闭包
func loginIfTrue(_ predicate: @autoclosure () -> Bool) {
    if predicate() {
        print("True")
    }
}
// 调用时会自动将 2 > 1自动转换为 () -> Bool
loginIfTrue(2 > 1)

//: 使用 ?? 来快速对nil进行判断
var level: Int?
var startLevel = 1
var currentLevel = level ?? startLevel

func ??<T>(optional: T?, defaultValue: @autoclosure () -> T) -> T {
    switch optional {
    case .some(let value):
        return value
    case .none:
        return defaultValue()
    }
}
/* 为什么不直接用如下形式
   func ??<T>(optional: T?, defaultValue:T) -> T
    如果用这种形式的话，defaultValue必须是一个确定值，如果是一个消耗很大的计算值，而且optional只有在很好几率下才能为nil，那么我们必须每次都有计算defaultValue产生这部分内存时间消耗，这是很不值的，如果只有当确定optional为nil时才去计算defaultValue，所以我们就传递闭包，只有当optional为nil时才去计算defaultValue值
 */

//: [Next](@next)
