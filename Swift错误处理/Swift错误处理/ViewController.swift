//
//  ViewController.swift
//  Swift错误处理
//
//  Created by X-Liang on 2016/10/27.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonStr = "[\"name\": \"张\"]"
        let data = jsonStr.data(using: .utf8)
        // 反序列化 throw 抛出异常
        // 方法一： try？： 如果解析成功，有值，否则为nil
//        let json = try? JSONSerialization.jsonObject(with: data!, options: [])
//        print(json)
        // 方法二：try！ 如果解析成功，有值，否则崩溃
//        let json = try！ JSONSerialization.jsonObject(with: data!, options: [])
        
        // 方法三： do-catch处理异常，能够接受错误并输出
        do {
            let json = try JSONSerialization.jsonObject(with: data!, options: [])
            print(json)
        } catch {
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

