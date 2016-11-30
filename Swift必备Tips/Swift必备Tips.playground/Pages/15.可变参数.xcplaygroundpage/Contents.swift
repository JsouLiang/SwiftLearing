//: [Previous](@previous)

import Foundation

func sum(input: Int...) -> Int {
    // 输入的input在函数内部被当做数组来使用
    return input.reduce(0, +)
}

func myFunc(numbers: Int..., string: String) {
    numbers.forEach {
        for i in 0..<$0 {
            print("\(i)" + "\(string)")
        }
    }
}
myFunc(numbers: 1, 2, 3, string: "HH")

//: [Next](@next)
