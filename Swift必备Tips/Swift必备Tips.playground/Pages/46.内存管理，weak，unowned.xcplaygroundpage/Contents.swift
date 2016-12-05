//: [Previous](@previous)

import Foundation

//
class A: NSObject {
    let b: B
    override init() {
        b = B()
        super.init()
        b.a = self
    }
    deinit {
        print("B deinit")
    }
}

class B: NSObject {
    // 为防止循环引用，我们希望“被动”的一方不要主动持有“主动”的一方
    weak var a: A? = nil
    deinit {
        print("B deinit")
    }
}
/**
 从表现形式上来看 unowned更像Objective-C中的unsafe_unretained，weak就是OC中的weak
 unowned设置后即使他原来引用的内容已经被释放了，他仍然会保持已经被释放了的对象的一个“无效的”引用，他不能是Optional值，也不会指向nil。如果尝试方法这个引用的方法或者调用成员属性的话，程序就会crash
 weak在引用内容被释放后标记为weak的成员将会自动变成nil，因此标记为weak的变量一定要是Optional值
 */

//: delegate -> weak
@objc protocol RequestHandle {
    @objc optional func requestFinished()
}

class RequestManager: RequestHandle {
    @objc func requestFinished() {
        print("请求完成")
    }
    
    func sendRequest() {
        let request = Request()
        request.delegate = self
        request.send()
    }
}

class Request {
    // 在数组delegate常用weak，因为我们无法保证拿到返回时delegate是否存在
    weak var delegate: RequestHandle!
    func send() {
        // 发送请求
    }
    
    func gotResponse() {
        // 请求返回
        delegate?.requestFinished?()
    }
}

//: 闭包和循环引用
// 闭包中对任何其他元素的引用都是会被闭包自动持有，如果我么在闭包中使用了self，那么起始也在闭包内持有了当前的对象
class Person {
    let name: String
    // printName是self属性，会被self持有，而他本身又在闭包内持有self，这导致了xiaoMing的deinit在自身超过作用域后没有被调用，也就是没有被释放
//    lazy var printName: () -> () = {
//        print("This name is \(self.name)")
//    }
    lazy var printName: () -> () = {
        [weak self] in  // 如果我们可以确定在整个过程中self不会被释放的话，我们可以使用[unowned self] 这样就不需要strongSelf的判断了
        if let strongSelf = self {
            print("This name is \(strongSelf.name)")
        }
    }
    
    init(personName: String) {
        name = personName
    }
    
    deinit {
        print("Person deinit \(self.name)")
    }
}
var xiaoMing: Person? = Person(personName: "XiaoMing")
xiaoMing!.printName
xiaoMing = nil

//: [Next](@next)
