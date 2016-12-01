//: [Previous](@previous)

import Foundation

// 0...3 表示从0到3并包含3这个数
// 0..<3 表示从0到2
// 我们可以通过... 或者 ..< 来连接两个字符串
let test = "helLo"
let interval = "a"..."z"
for c in test.characters {
    if !interval.contains(String(c)) {
        print("不是小写\(String(c))")
    }
}

//: [Next](@next)
