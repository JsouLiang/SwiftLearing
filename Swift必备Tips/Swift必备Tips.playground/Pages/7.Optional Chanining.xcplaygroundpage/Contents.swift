//: [Previous](@previous)

import Foundation

// Optional Chaining 随时都能提前返回nil
class Toy {
    let name: String
    init(name: String) {
        self.name = name
    }
}

class Pet {
    var toy: Toy?
}

class Child {
    var pet: Pet?
}

let xiaoMing = Child()
// 虽然我们在Toy中定义name为一个String类型，但是toyName是一个String?类型，这是因为可选链随时都能“断掉”(返回nil)
if let toyName = xiaoMing.pet?.toy?.name {
    
}

extension Toy {
    func play() {
        
    }
}

let f = xiaoMing.pet?.toy?.play()

// ->()? 可省略，由Swift自动推导
let playClosure = { (child: Child) -> ()?
    in
    child.pet?.toy?.play()  // 可能返回 nil，可能返回void
}

if let result: () = playClosure(xiaoMing) {
    print("Good")
} else {
    print("bad")
}

//: [Next](@next)
