//: [Previous](@previous)

import Foundation

class MyClass {
    var name: String?   // internal
    
    var privateName: String? // private
    
    private(set) var setPrivateName: String? // set 操作是private， 整个setPrivateName还是internal作用域
    
    public private(set) var publicPrivateName: String? // set 操作是private， publicPrivateName还是public作用域
}

//: [Next](@next)
