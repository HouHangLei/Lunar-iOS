//
//  SolarYear.swift
//  Lunar-iOS
//
//  Created by HL on 2022/9/6.
//
// 阳历年

import UIKit
import JavaScriptCore

public class SolarYear: NSObject {
    
    public var solarYear: JSValue?
    
    /// 使用JSValue初始化
    /// - Parameter jsValue: JSValue
    @objc public init(jsValue: JSValue) {
        self.solarYear = jsValue
    }
    
    /// 使用Date初始化
    /// - Parameters:
    ///   - date: 日期
    @objc public init(date: Date) {
        let dateSubscript = LunarManager.stand.solarYearJsValue?.objectForKeyedSubscript("fromDate")
        let call = dateSubscript?.call(withArguments: [date])
        self.solarYear = call
    }

    /// 使用年初始化
    /// - Parameters:
    ///   - year: 年
    public init(year: Int) {
        let yMdSubscript = LunarManager.stand.solarYearJsValue?.objectForKeyedSubscript("fromYear")
        let call = yMdSubscript?.call(withArguments: [year])
        self.solarYear = call
    }

}

extension SolarYear {
    
    //MARK: - toString
    // https://6tail.cn/calendar/api.html#solar-year.string.html
    
    /// 阳历年对象的默认字符串输出，格式为：YYYY
    /// - Returns: 例：2022
    @objc public func toString() -> String? {
        let toString = solarYear?.invokeMethod("toString", withArguments: nil)
        return toString?.toString()
    }

    /// 阳历年对象的全量字符串输出，格式为：YYYY年
    /// - Returns: 例：2022年
    @objc public func toFullString() -> String? {
        let toFullString = solarYear?.invokeMethod("toFullString", withArguments: nil)
        return toFullString?.toString()
    }

    //MARK: - 获取年
    // https://6tail.cn/calendar/api.html#solar-year.ymd.html
    
    /// 获取阳历年
    /// - Returns: 例：2022
    @objc public func getYear() -> String? {
        let getYear = solarYear?.invokeMethod("getYear", withArguments: nil)
        return getYear?.toString()
    }

    //MARK: - 本年每一月
    // https://6tail.cn/calendar/api.html#solar-year.months.html
    
    /// 获取阳历年对象中的每一月。
    /// - Returns: 阳历月对象的数组。
    @objc public func getMonths() -> [SolarMonth] {
        let getMonths = solarYear?.invokeMethod("getMonths", withArguments: nil)
        guard let array = getMonths?.toArray() else {
            return []
        }
        var solarMonths: [SolarMonth] = []
        for i in 0..<array.count {
            if let jsValue = getMonths?.objectAtIndexedSubscript(i) {
                let solarMonth = SolarMonth(jsValue: jsValue)
                solarMonths.append(solarMonth)
            }
        }
        return solarMonths
    }

    //MARK: - 年推移
    // https://6tail.cn/calendar/api.html#solar-year.next.html
    
    /// 获取加(减)几月后(前)的阳历半年对象。
    /// - Parameter halfYears: 推移的季度数，正数为往后推，负数为往前推。
    /// - Returns: 阳历半年对象
    @objc public func next(years: Int) -> SolarYear? {
        let next = solarYear?.invokeMethod("next", withArguments: [years])
        guard let next = next else {
            return nil
        }
        return SolarYear(jsValue: next)
    }

}
