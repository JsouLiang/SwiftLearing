//: [Previous](@previous)

import Foundation

extension Int {
//    func times(f: (Int) ->()) {
//        print("Int")
//        for i in 1...self {
//            f(i)
//        }
//    }
    
    func times(f: () -> () ) {
        print("Void")
        for _ in 1...self {
            f()
        }
    }
    
    func times(f: (Int, Int) -> ()) {
        print("Tuple")
        for i in 1...self {
            f(i, i)
        }
    }
}

//3.times { (i: Int) -> () in
//    print(i)
//}

//3.times {
//    i in
//    print(i)
//}

3.times {
    print("void")
}

3.times {
    (a: Int, b: Int) in
    print(a+b)
}


//: [Next](@next)
