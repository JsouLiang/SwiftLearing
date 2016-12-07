//: [Previous](@previous)

import Foundation
/*
 [obj1 isKindOfClass: [ClassA class]];
 [obj2 isMemberOfClass: [ClassB class]];
 -isKindOfClass: 判断obj1是否是classA或者其子类的实例对象
 -isMemberOfClass: 当obje2的类型是ClassB时返回真
 */
// 上面两个方法是NSObject的方法，在Swift中如果是NSObject的子类的话，直接使用上面两个方法没有任何问题
class ClassA: NSObject {}
class ClassB: ClassA {}

let obj1: NSObject = ClassB()
let obj2: NSObject = ClassB()

obj1.isKind(of: ClassA.self)
obj2.isMember(of: ClassA.self)

// 在Swift中只要可能我们更倾向选择非NSObject的Swift类型

class A {}
class B: A {}
let a: AnyObject = B()
let b: AnyObject = B()
a.isKind(of: A.self)
a.isMember(of: A.self)

// 对于一个不确定的类型我们现在可以使用is进行判断，is在功能上相当于isKindOfClass，可以检查一个对象是否属于某个类型或者其子类型

class AA {}
class BB: AA {}
let aa: AnyObject = BB()
if aa is AA {
    print("Blone AA")
}

if aa is BB {
    print("Blone BB")
}

//: [Next](@next)
