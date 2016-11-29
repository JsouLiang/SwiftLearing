//: [Previous](@previous)

// 如果没有多元组，我们交换两个数是这样的
func swap<T>(a: inout T, b: inout T) {
    let temp = a
    b = a
    a = temp
}

// 多元组交换
func swapWithTuple<T>(a: inout T, b: inout T) {
    (a, b) = (b, a)
}

//: [Next](@next)
