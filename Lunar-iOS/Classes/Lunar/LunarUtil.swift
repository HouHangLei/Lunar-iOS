//
//  LunarUtil.swift
//  Lunar-iOS
//
//  Created by HL on 2022/9/6.
//
// 阴历工具

import UIKit
import JavaScriptCore

public class LunarUtil: NSObject {
    
    /**
     时辰为中国传统计时单位。把一昼夜平分为十二段，每段叫做一个时辰，对应12地支，合现在的两小时。
     时辰对照表：
     子时                 丑时                寅时                卯时                  辰时              巳时
     23:00-00:59    01:00-02:59    03:00-04:59    05:00-06:59    07:00-08:59    09:00-10:59
     午时                 未时                申时                酉时                  戌时              亥时
     11:00-12:59    13:00-14:59    15:00-16:59    17:00-18:59    19:00-20:59    21:00-22:59
     
     HHmm：HH:mm时刻。
     返回时辰(地支)，例：子。
     */
    class func convertTime(HHmm: String) -> String? {
        let convertTime = LunarManager.stand.lunarUtilJsValue?.invokeMethod("convertTime", withArguments: [HHmm])
        return convertTime?.toString()
    }
}
