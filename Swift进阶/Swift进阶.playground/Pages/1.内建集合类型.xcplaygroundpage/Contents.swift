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
    
    func filter(_ isIncluded: (Element) -> Bool)  -> [Element] {
        var result: [Element] = []
        for x in self where isIncluded(x) {
            result.append(x)
        }
        return result
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
    func last(_ predicate: (Iterator.Element) -> Bool) -> Iterator.Element? {
        for element in reversed() where predicate(element) {
            return element
        }
        return nil
    }
    
    func all(matching predicate:(Iterator.Element) -> Bool) -> Bool {
        // 对于某个条件，如果没有原始不满足它，那么所有元素都满足它
        return !contains{!predicate($0)}
    }
}

let match = names.last{$0.hasSuffix("a")}
match



//: [Next](@next)
