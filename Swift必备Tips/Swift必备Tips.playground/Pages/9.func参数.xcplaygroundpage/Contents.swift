//: [Previous](@previous)

import Foundation

func incrementor_1(variable: Int) -> Int {
    // 函数内参数被声明为let
    return variable + 1
}

// 上面代码与下面代码等效
//func incrementor(variable: Int) -> Int {
//    return variable + 1
//}

// 在函数内部修改参数值
// inout 对于值类型相当于在函数内部创建一个新的值，然后在函数返回时将这个值赋值给 & 修饰的变量
func incrementor(variable: inout Int) {
    variable += 1
}

var num = 7
incrementor(variable: &num)

// 参数的修饰是具有传递限制的，对于跨层级的调用，我们需要保证统一参数的修饰是统一的
func makeIncrementor(addNum: Int) -> ((inout Int) -> ()) {
    func incrementor(variable: inout Int) {
        variable += addNum
    }
    return incrementor
}

//: [Next](@next)
