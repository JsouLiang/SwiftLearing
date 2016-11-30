//: [Previous](@previous)

import Foundation

struct Vector2D {
    var x = 0.0
    var y = 0.0
}

extension Vector2D {
    static func + (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y + right.y)
    }
    static func += (left: inout Vector2D, right: Vector2D) {
        left = left + right
    }
}

extension Vector2D {
    static func == (left: Vector2D, right: Vector2D) -> Bool {
        return (left.x == right.x) && (left.y == right.y)
    }
    
    static func != (l: Vector2D, r: Vector2D) -> Bool {
        return !(l == r)
    }
}

let v1 = Vector2D(x: 2.0, y: 3.0)
let v2 = Vector2D(x: 1.0, y: 4.0)
let v3 = Vector2D(x: v1.x + v2.x, y: v1.y + v2.y)
v3 == v2

let v4 = v1 + v2

// prefix 操作符作为前缀
prefix func -(l: Vector2D) -> Vector2D {
    return Vector2D(x: -l.x, y: -l.y)
}
-v2

// 优先级组声明
/*
 precedencegroup 优先级组名称{ 
    higherThan: 较低优先级组的名称
    lowerThan: 较高优先级组的名称 
    associativity: 结合性
    assignment: 赋值性 ???
 }
 */
precedencegroup DotProductPrecedence {
    associativity: none
    higherThan: MultiplicationPrecedence
}

/**
 * prefix: 前缀操作
 * infix: 中缀操作
 * postfix: 后缀操作
 */
infix operator +* : DotProductPrecedence

// 中缀操作不需要infix修饰函数声明
func +*(left: Vector2D, right: Vector2D) -> Double {
    return left.x * right.x + left.y * right.y
}

let d = v1 +* v2

prefix operator +++
extension Vector2D {
    static prefix func +++(vector: inout Vector2D) -> Vector2D {
        vector += vector
        return vector
    }
}

//: [Next](@next)
