//
//  SolarHalfYear.swift
//  Lunar-iOS
//
//  Created by HL on 2022/9/6.
//
// 阳历半年

import UIKit
import JavaScriptCore

public class SolarHalfYear: NSObject {
    
    public var solarHalfYear: JSValue?
    
    /// 使用JSValue初始化
    /// - Parameter jsValue: JSValue
    @objc public init(jsValue: JSValue) {
        self.solarHalfYear = jsValue
    }
    
    /// 使用Date初始化
    /// - Parameters:
    ///   - date: 日期
    @objc public init(date: Date) {
        let dateSubscript = LunarManager.stand.solarHalfYearJsValue?.objectForKeyedSubscript("fromDate")
        let call = dateSubscript?.call(withArguments: [date])
        self.solarHalfYear = call
    }

    /// 使用年月初始化
    /// - Parameters:
    ///   - year: 年
    ///   - month: 月
    public init(year: Int, month: Int) {
        let yMdSubscript = LunarManager.stand.solarHalfYearJsValue?.objectForKeyedSubscript("fromYm")
        let call = yMdSubscript?.call(withArguments: [year, month])
        self.solarHalfYear = call
    }

}

extension SolarHalfYear {
    
    //MARK: - toString
    // https://6tail.cn/calendar/api.html#solar-half.string.html
    
    /// 阳历半年对象的默认字符串输出，格式为：YYYY-I，I为半年序号：1、2
    /// - Returns: 例：2022.2
    @objc public func toString() -> String? {
        let toString = solarHalfYear?.invokeMethod("toString", withArguments: nil)
        return toString?.toString()
    }

    /// 阳历半年对象的全量字符串输出，格式为：YYYY年I半年，I值为：上、下
    /// - Returns: 例：2022年下半年
    @objc public func toFullString() -> String? {
        let toFullString = solarHalfYear?.invokeMethod("toFullString", withArguments: nil)
        return toFullString?.toString()
    }

    //MARK: - 获取年、月
    // https://6tail.cn/calendar/api.html#solar-half.ymd.html
    
    /// 获取阳历年
    /// - Returns: 例：2022
    @objc public func getYear() -> String? {
        let getYear = solarHalfYear?.invokeMethod("getYear", withArguments: nil)
        return getYear?.toString()
    }

    /// 获取阳历月
    /// - Returns: 例：9
    @objc public func getMonth() -> String? {
        let getMonth = solarHalfYear?.invokeMethod("getMonth", withArguments: nil)
        return getMonth?.toString()
    }
    
    //MARK: - 第几半年
    // https://6tail.cn/calendar/api.html#solar-half.index.html
    
    /// 获取阳历半年在一年中的序号，123456月为1半年。
    /// - Returns: 返回序号：1、2
    @objc public func getIndex() -> Int32 {
        let getIndex = solarHalfYear?.invokeMethod("getIndex", withArguments: nil)
        return getIndex?.toInt32() ?? 1
    }

    //MARK: - 本半年每一月
    // https://6tail.cn/calendar/api.html#solar-half.months.html
    
    /// 获取阳历半年对象中的每一月。
    /// - Returns: 阳历月对象数组
    @objc public func getMonths() -> [SolarMonth] {
        let getMonths = solarHalfYear?.invokeMethod("getMonths", withArguments: nil)
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

    //MARK: - 半年推移
    // https://6tail.cn/calendar/api.html#solar-half.next.html
    
    /// 获取加(减)几月后(前)的阳历半年对象。
    /// - Parameter halfYears: 推移的季度数，正数为往后推，负数为往前推。
    /// - Returns: 阳历半年对象
    @objc public func next(halfYears: Int) -> SolarHalfYear? {
        let next = solarHalfYear?.invokeMethod("next", withArguments: [halfYears])
        guard let next = next else {
            return nil
        }
        return SolarHalfYear(jsValue: next)
    }

}
