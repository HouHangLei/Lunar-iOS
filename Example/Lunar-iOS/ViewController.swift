//
//  ViewController.swift
//  Lunar-iOS
//
//  Created by hl on 09/07/2022.
//  Copyright (c) 2022 hl. All rights reserved.
//

import UIKit
import Lunar_iOS

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 初始化阴历对象
        let lunar = Lunar(year: 2022, month: 12, day: 18)
        // 获取详细的字符串
        let toFullString = lunar.toFullString()
        print("toFullString = \(toFullString)")
        
        // 获取时辰 (Array)
        if let times = lunar.getTimes() {
            for item in times {
                let getGan = item.getGan()
                print("getGan = \(getGan)")
            }
        }

        // 获取上一气令（返回节气对象）
        let shuJiu = lunar.getPrevQi(wholeDay: false)
        let name = shuJiu?.getName()
        print("name = \(name)")
        
        // 获取节气表（Dictionary）
        let getJieQiTable = lunar.getJieQiTable()
        print("getJieQiTable = \(getJieQiTable)")

        // 使用对象直接调用invokeMethod
        let string = lunar.lunar?.invokeMethod("toFullString", withArguments: nil).toString()
        print("string = \(string)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

