//
//  SolarMonth.swift
//  Lunar-iOS
//
//  Created by HL on 2022/9/6.
//
// 阳历月

import UIKit
import JavaScriptCore

public class SolarMonth: NSObject {
    
    public var solarMonth: JSValue?
    
    /// 使用JSValue初始化
    /// - Parameter jsValue: JSValue
    @objc public init(jsValue: JSValue) {
        self.solarMonth = jsValue
    }
    
    /// 使用Date初始化
    /// - Parameters:
    ///   - date: 日期
    @objc public init(date: Date) {
        let dateSubscript = LunarManager.stand.solarMonthJsValue?.objectForKeyedSubscript("fromDate")
        let call = dateSubscript?.call(withArguments: [date])
        self.solarMonth = call
    }

    /// 使用年月日初始化
    /// - Parameters:
    ///   - year: 年
    ///   - month: 月
    public init(year: Int, month: Int) {
        let yMdSubscript = LunarManager.stand.solarWeekJsValue?.objectForKeyedSubscript("fromYm")
        let call = yMdSubscript?.call(withArguments: [year, month])
        self.solarMonth = call
    }

}

extension SolarMonth {
    
    //MARK: - toString
    // https://6tail.cn/calendar/api.html#solar-month.string.html
    
    /// 阳历月对象的默认字符串输出，格式为：YYYY-M
    /// - Returns: 例：2022-9
    @objc public func toString() -> String? {
        let toString = solarMonth?.invokeMethod("toString", withArguments: nil)
        return toString?.toString()
    }

    /// 阳历月对象的全量字符串输出，格式为：YYYY年M月
    /// - Returns: 例：2022年9月
    @objc public func toFullString() -> String? {
        let toFullString = solarMonth?.invokeMethod("toFullString", withArguments: nil)
        return toFullString?.toString()
    }

    //MARK: - 获取年、月
    // https://6tail.cn/calendar/api.html#solar-month.ymd.html
    
    /// 获取阳历年
    /// - Returns: 例：2022
    @objc public func getYear() -> String? {
        let getYear = solarMonth?.invokeMethod("getYear", withArguments: nil)
        return getYear?.toString()
    }

    /// 获取阳历月
    /// - Returns: 例：9
    @objc public func getMonth() -> String? {
        let getMonth = solarMonth?.invokeMethod("getMonth", withArguments: nil)
        return getMonth?.toString()
    }

    //MARK: - 本月每一天
    // https://6tail.cn/calendar/api.html#solar-month.days.html
    
    /// 获取阳历月对象中每一天的阳历对象。
    /// - Returns:
    @objc public func getDays() -> [Solar] {
        let getDays = solarMonth?.invokeMethod("getDays", withArguments: nil)
        guard let array = getDays?.toArray() else {
            return []
        }
        var solars: [Solar] = []
        for i in 0..<array.count {
            if let jsValue = getDays?.objectAtIndexedSubscript(i) {
                let solar = Solar(jsValue: jsValue)
                solars.append(solar)
            }
        }
        return solars
    }

    //MARK: - 本月每一周
    // https://6tail.cn/calendar/api.html#solar-month.weeks.html
        
    /// 获取阳历月对象中每一周的阳历对象。
    /// - Parameter start: 星期几作为一周的开始，1234560分别代表星期一至星期天
    /// - Returns: 阳历月对象数组
    @objc public func getWeeks(start: Int) -> [SolarWeek] {
        let getWeeks = solarMonth?.invokeMethod("getWeeks", withArguments: nil)
        guard let array = getWeeks?.toArray() else {
            return []
        }
        var solarWeeks: [SolarWeek] = []
        for i in 0..<array.count {
            if let jsValue = getWeeks?.objectAtIndexedSubscript(i) {
                let solarWeek = SolarWeek(jsValue: jsValue)
                solarWeeks.append(solarWeek)
            }
        }
        return solarWeeks
    }

    //MARK: - 月推移
    // https://6tail.cn/calendar/api.html#solar-month.next.html
        
    /// 获取加(减)几月后(前)的阳历月对象。
    /// - Parameter months: 推移的月数，正数为往后推，负数为往前推。
    /// - Returns: 阴历月对象
    @objc public func next(months: Int) -> SolarMonth? {
        let next = solarMonth?.invokeMethod("next", withArguments: [months])
        guard let next = next else {
            return nil
        }
        return SolarMonth(jsValue: next)
    }


}
