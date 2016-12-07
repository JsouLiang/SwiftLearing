//: [Previous](@previous)

import Foundation

func sum(_ n: UInt) -> UInt {
    if n == 0 {
        return 0
    }
    return n + sum(n - 1)
}

func tailSum(_ n: UInt) -> UInt {
    func sum(_ n: UInt, current: UInt) -> UInt {
        if n == 0 {
            return current
        } else {
            return sum(n - 1, current: current + n)
        }
    }
    return sum(n, current: 0)
}
//: [Next](@next)
