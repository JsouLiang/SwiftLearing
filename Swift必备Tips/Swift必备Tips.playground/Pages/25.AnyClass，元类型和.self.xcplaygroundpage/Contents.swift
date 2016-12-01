//: [Previous](@previous)

import UIKit

// 通过AnyObject.Type这种方式得到的是一个元类型。
// 在声明时我们总是在类型的名称后面加上.Type 表示类的类型（元类型）
// 可以定义 元类型存储类型本身
// 比如 A.Type 代表的是A类的类型

class A {
    class func method() {
        
    }
}
// 声明一个元类来存储A这个类型本身， 使用.self 从A 中取出类型
let typeA: A.Type = A.self
let anyclass: AnyClass = A.self
typeA.method()

(anyclass as! A.Type).method()

class MusicViewController: UIViewController {
    
}

class AlbumViewController: UIViewController {
    
}

let usingVCTypes: [AnyClass] = [MusicViewController.self, AlbumViewController.self]

func setupViewControllers(_ vcTypes: [AnyClass]) {
    for vcType in vcTypes {
        if vcType is UIViewController.Type {
            _ = (vcType as! UIViewController.Type).init()
        }
    }
}

//: [Next](@next)
