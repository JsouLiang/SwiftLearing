//: [Previous](@previous)
import Foundation

func doWork(block: () -> ()) {
    // 同步调用， block调用会在doWork返回前被执行
    // block 作用域不会超过doWork，所以不用担心self被闭包持有的情况
    block()
}

doWork {
    print("work")
}

// 如果block与doWork不是同步执行的
// 使用@escaping的闭包不同，由于要确保闭包内的成员依然有效
// 所以如果在闭包内引用了self及其成员的话，Swift需要我们明确写出self
func downWorkAsync(block: @escaping () -> ()) {
    DispatchQueue.main.async {
        block()
    }
}

class S {
    var foo = "foo"
    func method1() {
        doWork {
            print(foo)
        }
        foo = "bar"
    }
    
    func method2() {
        downWorkAsync {
            print(self.foo)
        }
        foo = "bar"
    }
    
    func method3() {
        downWorkAsync {
            [weak self] _ in    // [weak self] 闭包不持有self
            print(self?.foo ?? "")
        }
        foo = "bar"
    }
}

let s = S()
s.method1()
s.method2()
s.method3()

// 如果在协议或者父类中定义了一个接受@escaping为参数的方法，那么实现该协议或者继承该父类的子类中对应的方法也必须声明为@escaping
protocol P {
    func work(b: @escaping () -> ())
}

class C: P {
    func work(b: @escaping () -> ()) {
        DispatchQueue.main.async {
            print("in C")
            b()
        }
    }
}

//: [Next](@next)
