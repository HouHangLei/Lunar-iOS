//
//  SolarSeason.swift
//  Lunar-iOS
//
//  Created by HL on 2022/9/6.
//
// 阳历季度

import UIKit
import JavaScriptCore

public class SolarSeason: NSObject {
    
    public var solarSeason: JSValue?
    
    /// 使用JSValue初始化
    /// - Parameter jsValue: JSValue
    @objc public init(jsValue: JSValue) {
        self.solarSeason = jsValue
    }
    
    /// 使用Date初始化
    /// - Parameters:
    ///   - date: 日期
    @objc public init(date: Date) {
        let dateSubscript = LunarManager.stand.solarSeasonJsValue?.objectForKeyedSubscript("fromDate")
        let call = dateSubscript?.call(withArguments: [date])
        self.solarSeason = call
    }

    /// 使用年月日初始化
    /// - Parameters:
    ///   - year: 年
    ///   - month: 月
    public init(year: Int, month: Int) {
        let yMdSubscript = LunarManager.stand.solarSeasonJsValue?.objectForKeyedSubscript("fromYm")
        let call = yMdSubscript?.call(withArguments: [year, month])
        self.solarSeason = call
    }

}

extension SolarSeason {
    
    //MARK: - toString
    // https://6tail.cn/calendar/api.html#solar-season.string.html
    
    /// 阳历季度对象的默认字符串输出，格式为：YYYY-I，I为季度序号：1、2、3、4
    /// - Returns: 例：2022.3
    @objc public func toString() -> String? {
        let toString = solarSeason?.invokeMethod("toString", withArguments: nil)
        return toString?.toString()
    }

    /// 阳历季度对象的全量字符串输出，格式为：YYYY年I季度，I为季度序号：1、2、3、4
    /// - Returns: 例：2022年3季度
    @objc public func toFullString() -> String? {
        let toFullString = solarSeason?.invokeMethod("toFullString", withArguments: nil)
        return toFullString?.toString()
    }

    //MARK: - 获取年、月
    // https://6tail.cn/calendar/api.html#solar-season.ymd.html
    
    /// 获取阳历年
    /// - Returns: 例：2022
    @objc public func getYear() -> String? {
        let getYear = solarSeason?.invokeMethod("getYear", withArguments: nil)
        return getYear?.toString()
    }

    /// 获取阳历月
    /// - Returns: 例：9
    @objc public func getMonth() -> String? {
        let getMonth = solarSeason?.invokeMethod("getMonth", withArguments: nil)
        return getMonth?.toString()
    }
    
    //MARK: - 第几季度
    // https://6tail.cn/calendar/api.html#solar-season.index.html
    
    /// 获取阳历季度在一年中的序号，123月为1季度，456月为2季度。
    /// - Returns: 例：1
    @objc public func getIndex() -> Int32 {
        let getIndex = solarSeason?.invokeMethod("getIndex", withArguments: nil)
        return getIndex?.toInt32() ?? 1
    }

    //MARK: - 本季度每一月
    // https://6tail.cn/calendar/api.html#solar-season.months.html
    
    /// 获取阳历季度对象中的每一月。
    /// - Returns: 阳历月对象数组
    @objc public func getMonths() -> [SolarMonth] {
        let getMonths = solarSeason?.invokeMethod("getMonths", withArguments: nil)
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

    //MARK: - 季度推移
    // https://6tail.cn/calendar/api.html#solar-season.next.html
    
    /// 获取加(减)几月后(前)的阳历季度对象。
    /// - Parameter seasons: 推移的季度数，正数为往后推，负数为往前推。
    /// - Returns: 阳历季度对象
    @objc public func next(seasons: Int) -> SolarSeason? {
        let next = solarSeason?.invokeMethod("next", withArguments: [seasons])
        guard let next = next else {
            return nil
        }
        return SolarSeason(jsValue: next)
    }


}
