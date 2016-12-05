//: [Previous](@previous)

import Foundation

// Swift中对应不透明指针的类型是COpaquePointer，它用来表示那些在Swift中午饭进行描述的C指针

// int cFunction(int (callback)(int x, int y)) {
//    return callback(1, 2);
// }
let callBack: @convention(c)(Int32, Int32) -> Int32 = {
    (x, y) -> Int32 in
    return x + y
}



//: [Next](@next)
