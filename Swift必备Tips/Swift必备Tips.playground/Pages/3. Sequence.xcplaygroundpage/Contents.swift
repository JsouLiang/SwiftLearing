//: [Previous](@previous)

// 要实现 序列化，首先需要实现一个 IteratorProtocol

class ReverseIterator<T>: IteratorProtocol {
    typealias Element = T
    var array: [Element]
    var currentIndex = 0
    
    init(array: [Element]) {
        self.array = array
        currentIndex = array.count - 1
    }
    
    func next() -> T? {
        if currentIndex < 0 {
            return nil
        } else {
            let element = array[currentIndex];
            currentIndex -= 1
            return element
        }
    }
}

struct ReverseSequence<T>: Sequence {
    var array: [T]
    init(array: [T]) {
        self.array = array
    }
    
    typealias Iterator = ReverseIterator<T>
    func makeIterator() -> ReverseIterator<T> {
        return ReverseIterator(array: array)
    }
}

let array = [0, 1, 2, 3, 4]
for i in ReverseSequence(array: array) {
    print("Inde \(i) is \(array[i])")
}

//: [Next](@next)
