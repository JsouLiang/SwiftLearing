//: [Previous](@previous)

import Foundation

class MyClass {
    var a = 1
    deinit {
        print("deinit")
    }
}
/*
var pointer: UnsafeMutablePointer<MyClass>!
pointer = UnsafeMutablePointer<MyClass>.allocate(capacity: 1)
pointer.initialize(to: MyClass())
print(pointer.pointee.a)
// 虽然我们经pointer设置成为nil，但是由于UnsafeMutablePointer并不会自动进行内存管理，因此Pointer所指向的内存没有被释放和回收
pointer = nil
 */
var pointer: UnsafeMutablePointer<MyClass>!
pointer = UnsafeMutablePointer<MyClass>.allocate(capacity: 1)
pointer.initialize(to: MyClass())
print(pointer.pointee.a)
// 为Pointer加入deinitialize，deallocate，他们分别会释放指针指向的内存的对象以及指针本身
pointer.deinitialize()
pointer.deallocate(capacity: 1)
pointer = nil
// 遵循原则：谁创建谁释放。 deallocate(capacity:)，deinitialize与allocate，initialize成对出现

//: [Next](@next)
