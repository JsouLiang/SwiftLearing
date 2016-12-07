//: [Previous](@previous)

import Foundation

// 创建目标队列
let workingQueue = DispatchQueue(label: "my_queue")
// 派发任务到刚刚创建的队列，GCD会进行线程调度
workingQueue.async {
    // 在workingQueue中异步进行
    print("working")
    Thread.sleep(forTimeInterval: 2)
    DispatchQueue.main.async {
        // 回到主线程更新UI
        print("End")
    }
}

let time: TimeInterval = 2.0
DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
    print("2s 后输出")
}

typealias Task = (_ cancle: Bool) -> Void
func delay(_ time: TimeInterval, task: @escaping () -> ()) -> Task? {
    func dispatch_later(block: @escaping () -> ()) {
        let t = DispatchTime.now() + time
        DispatchQueue.main.asyncAfter(deadline: t, execute: block)
    }
    
    var closure: (()->Void)? = task
    var result: Task?
    
    let delayedClosure: Task = {
        cancle in
        if let internalClosure = closure {
            if cancle == false {
                DispatchQueue.main.async(execute: internalClosure)
            }
        }
        closure = nil
        result = nil
    }
    
    result = delayedClosure
    dispatch_later {
        if let delayedClosure = result {
            delayedClosure(false)
        }
    }
    return result
}

func cancel(_ task: Task?) {
    task?(true)
}

delay(2) {
    print("2s 后输出")
}

let task = delay(5) {
    print("拨打 110")
}
// 取消任务
cancel(task)

//: [](@next)
