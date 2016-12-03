//: [Previous](@previous)

import Foundation

// 1. 在switch中，我们可以使用where来限定某些条件case
let name = ["1", "2","王"]
name.forEach{
    switch $0 {
    case let x where x.hasPrefix("王"):
        print("你好: \(x)")
    default:
        print("\($0)")
    }
}

let num: [Int?] = [48, 99, nil]
let n = num.flatMap{$0}
for score in n where score > 60 {
    print("及格\(score)")
}

num.forEach{
    if let score = $0, score > 60 {
        print("及格\(score)")
    } else {
        print(":(")
    }
}

// 在泛型中对方法类型进行限定
// 这里限定T.RawValue 必须遵守Equatable协议
public func !=<T: RawRepresentable where T.RawValue : Equatable>(lhs: T, rhs: T) -> Bool {
    return false
}

// 限定协议拓展，在某些特定条件下使用
extension Sequence where Self.Iterator.Element : Comparable {
//    public func sorted() -> [Self.Iterator.Element] {
//        
//    }
}
//: [Next](@next)
