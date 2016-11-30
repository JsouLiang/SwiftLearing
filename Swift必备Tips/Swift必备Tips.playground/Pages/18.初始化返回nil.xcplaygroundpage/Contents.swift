//: [Previous](@previous)

import Foundation
// 我们可以在init声明后面添加一个?或者!来表示初始化失败时可能返回nil
extension Int {
    init?(fromString: String) {
        self = 0
        var digit = fromString.characters.count - 1
        for c in fromString.characters {
            var number = 0
            if let n = Int(String(c)) {
                number = n
            }
            else {
                switch c {
                    case "一": number = 1
                    case "二": number = 2
                    case "三": number = 3
                    case "四": number = 4
                    case "五": number = 5
                    case "六": number = 6
                    case "七": number = 7
                    case "八": number = 8
                    case "九": number = 9
                    case "零": number = 0
                    default:return nil
                }
            }
            self = self + number * Int(pow(10, Double(digit)))
            digit = digit - 1
        }
    }
}

//: [Next](@next)
