//: [Previous](@previous)

import Foundation

let num: Int? = 3
// 如果num为nil返回nil，如果有值返回map后的值
let result = num.map {
    $0 * 2
}

//: [Next](@next)
