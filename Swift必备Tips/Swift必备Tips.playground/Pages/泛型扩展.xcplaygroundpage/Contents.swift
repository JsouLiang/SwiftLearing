//: [Previous](@previous)

import Foundation
// 下面Array已经声明为泛型类型，当我们对这样的泛型类型进行拓展时不需要在extension后面再次添加<Element>
//public struct Array<Element>: Collection, Indexable ... {
//    
//}

extension Array {
    // 在拓展中可以使用原有的泛型标识符(Element)
    var random: Element? {
        return self.count != 0 ?
        self[Int(arc4random_uniform(UInt32(self.count)))] :
        nil
    }
}

//: [Next](@next)
