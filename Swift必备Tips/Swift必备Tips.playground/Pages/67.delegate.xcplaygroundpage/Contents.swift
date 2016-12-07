//: [Previous](@previous)

import Foundation

//
@objc protocol MyClassDelegate {
    func method()
}

protocol DataSource: class {
    
}

class MyClass {
    // 'weak' may only be applied to class and class-bound protocol types, not 'MyClassDelegate'
    // 这是因为Swift的protocol不仅可以被class遵守还可以被struct或者enum这样的类型，而对于struct或者enum这样的类型，本身不适用引用计数来管理内存，所以不能用weak这样的ARC来修饰
    // 要在Swift中使用weak delegate， 就需要将protocol限制在class内
    // 1. 将protocol声明为Objective-C的，在protocol前面添加@objc即可
    // 2. 在protocol声明后面添加class，来显示指定这个protocol只能由class实现
    weak var delegate: MyClassDelegate?
    
    weak var dataSource: DataSource?
}



//: [Next](@next)
