//: [Previous](@previous)

import Foundation

// 我们可以将方法作为变量或者参数来使用
/*
func appendQuery(url: String,
                 key: String,
                 value: AnyObject) -> String {
    if let dictionary = value as? [String: AnyObject] {
        return appendQueryDictionary(url: url,
                                     key: key,
                                     value: dictionary)
    } else if let array = value as? [AnyObject] {
        return appendQueryArray(url: url,
                                key: key,
                                value: array)
    } else {
        return appendQuerySingle(url: url,
                                 key: key,
                                 value: value)
    }
}

func appendQueryDictionary(url: String,
                           key: String,
                           value: [String: AnyObject]) -> String {
    let result = ""
    return result
}

func appendQueryArray(url: String,
                           key: String,
                           value: [AnyObject]) -> String {
    let result = ""
    return result
}

func appendQuerySingle(url: String,
                           key: String,
                           value: AnyObject) -> String {
    let result = ""
    return result
}
*/

// 将上述内容的函数修改为内部函数，增加一致性

func appendQuery(url: String,
                 key: String,
                 value: AnyObject) -> String {
    
    func appendQueryDictionary(url: String,
                               key: String,
                               value: [String: AnyObject]) -> String {
        let result = ""
        return result
    }
    
    func appendQueryArray(url: String,
                          key: String,
                          value: [AnyObject]) -> String {
        let result = ""
        return result
    }
    
    func appendQuerySingle(url: String,
                           key: String,
                           value: AnyObject) -> String {
        let result = ""
        return result
    }
    
    if let dictionary = value as? [String: AnyObject] {
        return appendQueryDictionary(url: url,
                                     key: key,
                                     value: dictionary)
    } else if let array = value as? [AnyObject] {
        return appendQueryArray(url: url,
                                key: key,
                                value: array)
    } else {
        return appendQuerySingle(url: url,
                                 key: key,
                                 value: value)
    }
}

// 如果我们想要灵活地提供一个模板让使用者可以通过模板定制他们的方法，又不想暴露太多实现细节，或者让使用者可以直接使用模板
func makeIncrementor(addNumber: Int) -> (inout Int) -> Void {
    func incrementor(inout variable: Int) -> Void {
        variable += addNumber
    }
    return incrementor
}

//: [Next](@next)
