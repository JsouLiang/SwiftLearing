//: [Previous](@previous)

import Foundation
// Swift 的方法支持默认参数，可以给某个参数指定一个默认值，如果该默认值在调用时传入了值则使用传入的值，如果没指定则使用默认值
func sayHello(str1: String = "Hello", str2: String, str3: String) {
    print(str1 + str2 + str3)
}

func sayHello2(str1: String = "Hello", str2: String, str3: String = "World") {
    print(str1 + str2 + str3)
}

sayHello(str2: " ", str3: "World")
sayHello2(str2: " ")

//: [Next](@next)
