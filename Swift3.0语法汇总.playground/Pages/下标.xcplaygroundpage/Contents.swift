//: [Previous](@previous)

import Foundation

//: 下标: 下标可以定义在类, 结构体, 枚举中
// 下标允许你通过在实例名称后面的方括号中传入一个或者多个索引值来对实例进行存取
//: 下标语法
subscript(index: Int) -> Int {
    get {
        // 返回一个适当的 Int 类型的值
    }
    set(newValue) {
        // 执行适当的赋值操作
    }
}
// newValue 的类型和下标的返回类型相同
// 可以不指定 setter 的参数( newValue )。如果不 指定参数，setter 会提供一个名为 newValue 的默认参数。
// 只读计算型属性，可以省略只读下标的 get 关键字
subscript(index: Int) -> Int {
    // 返回一个适当的 Int 类型的值
}

struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")

//: 下标选项
// 下标可以接受任意数量的入参，并且这些入参可以是任意类型
// 下标的返回值也可以是任意类型。
// 下标可以使用变量参数和可变参数，但不能使用输入输出参数，也不能给参数设置默认值。

// 一个类或结构体可以根据自身需要提供多个下标实现，使用下标时将通过入参的数量和类型进行区分，自动匹配合适的下标，这就是下标的重载。
struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    
    func indexIsVaild(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsVaild(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        
        set {
            assert(indexIsVaild(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

var matrix = Matrix(rows: 2, columns: 2)
matrix[0, 1] = 1.5
matrix[1, 0] = 3.2



//: [Next](@next)
