//: [Previous](@previous)

import Foundation

struct Person {
    let name: String
    let age: Int
}

let xiaoMing = Person(name: "XiaoMing", age: 16)
// 通过Mirror初始化得到的结果中包含的元素的描述都被集合在children属性下
let r = Mirror(reflecting: xiaoMing) // r 是xiaoMing
print("xiaoming是\(r.displayStyle!)")

print("属性个数:\(r.children.count)")
for child in r.children {
    print("属性名：\(child.label!) 值：\(child.value)")
}

dump(xiaoMing)

//: [Next](@next)
