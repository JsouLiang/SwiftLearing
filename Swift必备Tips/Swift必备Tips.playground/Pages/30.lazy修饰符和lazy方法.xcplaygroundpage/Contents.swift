//: [Previous](@previous)

import Foundation

class Class {
    // 在Swift中使用lazy关键字方法简单地指定延迟加载
    // 我们在使用lazy做修饰符是只能声明属性是变量。另外我们需要显示地指定属性类型，并使用一个可以对这个属性进行赋值的语句在首次访问属性时运行
    lazy var str: String = {
        let str = "Hello"
        print("只在首次访问输出")
        return str
    }()
    
    lazy var hello: String = "Hello"
}

// 不延时版本
struct Normal {
   static func option() {
        let data = 1...3
        let result = data.map{
            (i: Int) -> Int in
            print("正在处理\(i)")
            return i * 2
        }
        
        print("准备访问")
        for i in result {
            print("操作后结果为\(i)")
        }
        print("操作完毕")
    }
}

Normal.option()
print("*****延时版本*****")
struct Lazy {
    static func option() {
        let data = 1...3
        // 使用lazy后当使用第i个元素才会进行map操作
        let result = data.lazy.map{
            (i: Int) -> Int in
            print("正在处理\(i)")
            return i * 2
        }
        
        print("准备访问")
        for i in result {
            print("操作后结果为\(i)")
        }
        print("操作完毕")
    }
}
Lazy.option()

//: [Next](@next)
