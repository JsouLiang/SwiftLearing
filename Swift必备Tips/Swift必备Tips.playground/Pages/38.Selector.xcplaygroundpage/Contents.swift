//: [Previous](@previous)

import Foundation

// @selector 是 Objective-C的关键字，他可以将方法转换并赋值给一个SEL类型，它的表现类似动态函数指针。
// 在Swift中对应SEL的类型是一个Selector结构体
class MyObject: NSObject {
    func callMe() {
        //...
    }
    
    func callMeWithParam(obj: AnyObject!) {
        //...
    }
    
    func turn(by angle: Int, speed: Float) {
        //...
    }
    
    func selectors() -> [Selector] {
        let someMethod = #selector(callMe)
        let anotherMethod = #selector(callMeWithParam(obj:))
        let method = #selector(turn(by:speed:))
        
        return [someMethod, anotherMethod, method]
    }
    
    func otherSelectors() -> [Selector] {
        let someMethod = #selector(callMe)
        let anotherMethod = #selector(callMeWithParam)
        let method = #selector(turn)
        
        return [someMethod, anotherMethod, method]
    }
    
    
    func commonFunc() {
        
    }
    
    func commonFunc(input: Int) -> Int {
        return input
    }
    
    func sameNameSelectors() -> [Selector] {
//        如果在同一个作用域中存在同样名字的两个方法, 即使他们的函数签名不同(commonFunc，commonFunc(input:))Swift 编译也不允许
//        let method = #selector(commonFunc)
//        可以采用强制转换来使用

        let method1 = #selector(commonFunc as ()->())
        let method2 = #selector(commonFunc as (Int)->Int)
        return [method1, method2]
    }
}





//: [Next](@next)
