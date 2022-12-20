//
//  Holiday.swift
//  Lunar-iOS
//
//  Created by HL on 2022/9/6.
//
// 假期对象

import UIKit

@objcMembers public class Holiday: NSObject {

    /// 当天日期YYYY-MM-DD格式的日期
    public var day: String?
    /// 是否调休。调休为true，放假为false
    public var work: Bool
    /// 例如国庆节，如果国庆和中秋为同一天，则为国庆中秋。目前包括：元旦节、春节、清明节、劳动节、端午节、中秋节、国庆节、国庆中秋和抗战胜利日
    public var name: String?
    /// 关联的节日YYYY-MM-DD格式的日期。例如2020-05-02日放劳动节，它关联的节日为2020-05-01，当放假与节日为同一天时，关联节日也是当天。
    public var target: String?
    
    public init(day: String?, work: Bool, name: String?, target: String?) {
        self.day = day
        self.work = work
        self.name = name
        self.target = target
    }
}
