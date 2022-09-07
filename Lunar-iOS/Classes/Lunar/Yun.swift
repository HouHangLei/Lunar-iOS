//
//  Yun.swift
//  Lunar-iOS
//
//  Created by HL on 2022/9/6.
//
// 运

import UIKit
import JavaScriptCore

public class Yun: NSObject {

    public var yun: JSValue?

    /// 使用JSValue初始化
    /// - Parameter jsValue: JSValue
    @objc public init(jsValue: JSValue) {
        self.yun = jsValue
    }

}

extension Yun {
    
    //MARK: - 起运
    
    /// 获取起运年数
    /// - Returns: 例：17
    @objc public func getStartYear() -> String? {
        let getStartYear = yun?.invokeMethod("getStartYear", withArguments: nil)
        return getStartYear?.toString()
    }

    /// 获取起运月数。
    /// - Returns: 例：5
    @objc public func getStartMonth() -> String? {
        let getStartMonth = yun?.invokeMethod("getStartMonth", withArguments: nil)
        return getStartMonth?.toString()
    }

    /// 获取起运天数。
    /// - Returns: 例：11
    @objc public func getStartDay() -> String? {
        let getStartDay = yun?.invokeMethod("getStartDay", withArguments: nil)
        return getStartDay?.toString()
    }

    /// 获取起运小时数。流派1目前不支持小时，返回0。流派2可支持到小时。
    /// - Returns: 例：16
    @objc public func getStartHour() -> String? {
        let getStartHour = yun?.invokeMethod("getStartHour", withArguments: nil)
        return getStartHour?.toString()
    }

    /// 获取起运小时数。流派1目前不支持小时，返回0。流派2可支持到小时。
    /// - Returns: 例：16
    @objc public func getStartSolar() -> Solar? {
        let getStartSolar = yun?.invokeMethod("getStartSolar", withArguments: nil)
        guard let getStartSolar = getStartSolar else {
            return nil
        }
        return Solar(jsValue: getStartSolar)
    }

    //MARK: - 大运
    /**
     以月柱为基准，从起运年开始，每隔10年排1大运，即按阳男阴女顺排、阴男阳女逆排的规则，和60甲子顺序依次排布干支，一般排9轮。
     */
    
    /// 获取大运排布表。返回一个数组，第1个元素为出生年份，第2个元素为起大运年份，后续均间隔10年，共10个元素。
    /// - Returns: 大运对象数组
    @objc public func getDaYun() -> [DaYun]? {
        let getDaYun = yun?.invokeMethod("getDaYun", withArguments: nil)
        guard let array = getDaYun?.toArray() else {
            return nil
        }
        var dayuns: [DaYun] = []
        for i in 0..<array.count {
            if let jsValue = getDaYun?.objectAtIndexedSubscript(i) {
                let dayun = DaYun(jsValue: jsValue)
                dayuns.append(dayun)
            }
        }
        return dayuns
    }

}
