//: [Previous](@previous)

import Foundation

/*
 C 函数
 void method(const int *num) {
    printf("%d", *num);
 }
 
 int a = 123;
 method(&a);
 */
// 上面的C函数中我们接受一个int指针，转到Swift中就是UnsafePointer<CInt>
func method(_ num: UnsafePointer<CInt>) {
    print(num.pointee)
}
var a: CInt = 123
method(&a)

// 在Swift中可以使用unsafeBitCase来进行强制转换
let arr = NSArray(object: "meow")
// unsafeBitCast会将第一个参数按照第二个参数类型进行转换，而不去关心实际是否可行
let str = unsafeBitCast(CFArrayGetValueAtIndex(arr, 0), to: CFString.self)

//: [Next](@next)
