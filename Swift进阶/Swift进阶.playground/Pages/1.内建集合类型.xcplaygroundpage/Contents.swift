//: [Previous](@previous)
import Foundation

extension Array {
    // Element 是数组中包含元素类型的占位符， T是元素转换之后的类型占位符
    func map<T>(_ transform: (Element) -> T) -> [T] {
        var result: [T] = []
        result.reserveCapacity(count)
        for x in self {
            result.append(transform(x))
        }
        return result
    }
    
    // fileMap实现看起来与map基本一致，不过fileMap需要的是一个能返回数组的函数作为变化参数
    func fileMap<T>(_ transform: (Element) -> [T]) -> [T] {
        var result: [T] = []
        for x in self {
            result.append(contentsOf: transform(x))
        }
        return result
    }
    
    func filter(_ isIncluded: (Element) -> Bool)  -> [Element] {
        var result: [Element] = []
        for x in self where isIncluded(x) {
            result.append(x)
        }
        return result
    }
    
    func reduct<Result>(_ initialResult: Result,
                _ nextPartialResult:(Result, Element)-> Result) -> Result {
        var result = initialResult
        for x in self {
            result = nextPartialResult(result, x)
        }
        return result
    }
    
    // 通过reduct实现map
    func map2<T>(_ transform: (Element) -> T) -> [T] {
        return reduct([]) {
            $0 + [transform($1)]
        }
    }
    
    func accumulate<Result>(_ initialResult: Result,
                    _ nextPartialResult: (Result, Element) -> Result) -> [Result] {
        var running = initialResult
        return map { next in
            running = nextPartialResult(running, next)
            return running
        }
    }
}

let names = ["Paula", "Elena", "Zoe"]
var lastNameEndingInA: String?
// names.reversed() 将数组反转
for name in names.reversed() where name.hasSuffix("a") {
    lastNameEndingInA = name
    break
}

extension Sequence {
    func last(where predicate: (Iterator.Element) -> Bool) -> Iterator.Element? {
        for element in reversed() where predicate(element) {
            return element
        }
        return nil
    }
    // 某集合中所有元素是否都满足某一条件
    func all(matching predicate:(Iterator.Element) -> Bool) -> Bool {
        // 对于某个条件，如果没有原始不满足它，那么所有元素都满足它
        return !contains{!predicate($0)}
    }
}

let match = names.last{$0.hasSuffix("a")}
[1, 2, 3, 4].accumulate(0, +)
match

let sum = [1, 2, 3, 4].reduce(0) {
    total, num in
    total + num
}
sum

// 使用fileMap将不同数组里元素进行合并
let suits = ["♠", "♥", "♣", "♦"]
let ranks = ["J","Q","K","A"]
let result = suits.fileMap { suit in
    ranks.map { rank in
        (suit, rank)
    }
}
result

//: for-earch 如果想对集合中每个元素都调用一个函数的话，使用for-earch比较合适

extension Array where Element: Equatable {
    func index(of element: Element) -> Int? {
        for idx in self.indices where self[idx] == element {
            return idx
        }
        return nil
    }
    
    func index_forearch(of element: Element) -> Int? {
        self.indices.filter {
//            print($0)
            return self[$0] == element
        }.forEach {_ in 
//            print($0)
//            return $0
        }
        return nil
    }
}

let arr = [1, 2, 3, 4]
arr.indices // 0..<4
arr.index_forearch(of: 5)
arr.index_forearch(of: 4)

(1..<10).forEach {
    print($0)
    if $0 > 2 {return}  // return并不能终止循环，它做的仅仅是从闭包中返回
}

//: 数组类型
//: 切片


//: [Next](@next)
