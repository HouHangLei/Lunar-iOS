//
//  SolarWeek.swift
//  Lunar-iOS
//
//  Created by HL on 2022/9/6.
//
// 阳历周

import UIKit
import JavaScriptCore

public class SolarWeek: NSObject {
    
    public var solarWeek: JSValue?
    
    /// 使用JSValue初始化
    /// - Parameter jsValue: JSValue
    @objc public init(jsValue: JSValue) {
        self.solarWeek = jsValue
    }

    /**
     注意：一定要记得start参数，因为常见的周计算方式，有把星期一作为一周的起点，也有把星期日作为一周的起点，不同的起点计算周相关信息时会出现很大的出入。

     有人会问为什么不设置一个默认值，因为一旦使用默认值，使用者不会引起注意，结果与他期望的不同，他就会觉得这玩意儿一点都不准。我需要使用者明确知道自己使用的是哪种计算方式。

     */
    
    /// 使用Date初始化
    /// - Parameters:
    ///   - date: 日期
    ///   - start: 星期几作为一周的开始，值为1234560分别代表星期一至星期天。
    @objc public init(date: Date, start: Int) {
        let dateSubscript = LunarManager.stand.solarWeekJsValue?.objectForKeyedSubscript("fromDate")
        let call = dateSubscript?.call(withArguments: [date, start])
        self.solarWeek = call
    }

    /// 使用年月日初始化
    /// - Parameters:
    ///   - year: 年
    ///   - month: 月
    ///   - day: 日
    ///   - start: 星期几作为一周的开始，值为1234560分别代表星期一至星期天。
    public init(year: Int, month: Int, day: Int, start: Int) {
        let yMdSubscript = LunarManager.stand.solarWeekJsValue?.objectForKeyedSubscript("fromYmd")
        let call = yMdSubscript?.call(withArguments: [year, month, day, start])
        self.solarWeek = call
    }

}

extension SolarWeek {
    
    //MARK: - toString
    // https://6tail.cn/calendar/api.html#solar-week.string.html
    
    /// 阳历周对象的默认字符串输出，格式为：YYYY.M.I（I为数字，从1开始计，表示本月第几周）
    /// - Returns: 例：2022.9.2
    @objc public func toString() -> String? {
        let toString = solarWeek?.invokeMethod("toString", withArguments: nil)
        return toString?.toString()
    }

    /// 阳历周对象的全量字符串输出，包含尽量多的信息
    /// - Returns: 例：2022年9月第2周
    @objc public func toFullString() -> String? {
        let toFullString = solarWeek?.invokeMethod("toFullString", withArguments: nil)
        return toFullString?.toString()
    }

    //MARK: - 获取年、月、日
    // https://6tail.cn/calendar/api.html#solar-week.ymd.html
    
    /// 获取阳历年
    /// - Returns: 例：2022
    @objc public func getYear() -> String? {
        let getYear = solarWeek?.invokeMethod("getYear", withArguments: nil)
        return getYear?.toString()
    }

    /// 获取阳历月
    /// - Returns: 例：9
    @objc public func getMonth() -> String? {
        let getMonth = solarWeek?.invokeMethod("getMonth", withArguments: nil)
        return getMonth?.toString()
    }

    /// 获取阳历日
    /// - Returns: 例：6
    @objc public func getDay() -> String? {
        let getDay = solarWeek?.invokeMethod("getDay", withArguments: nil)
        return getDay?.toString()
    }

    //MARK: - 一周的起点
    // https://6tail.cn/calendar/api.html#solar-week.start.html
    
    /// 获取阳历周对象的星期几作为一周的开始，1234560分别代表星期一至星期天。
    /// - Returns: 例：1
    @objc public func getStart() -> Int32 {
        let getStart = solarWeek?.invokeMethod("getStart", withArguments: nil)
        return getStart?.toInt32() ?? 0
    }

    //MARK: - 本月第几周
    // https://6tail.cn/calendar/api.html#solar-week.index.html
    
    /// 获取当前日期是在当月第几周，返回序号从1开始。
    /// - Returns: 返回序号：1、2、3、4等
    @objc public func getIndex() -> Int32 {
        let getIndex = solarWeek?.invokeMethod("getIndex", withArguments: nil)
        return getIndex?.toInt32() ?? 1
    }

    //MARK: - 本年第几周
    // https://6tail.cn/calendar/api.html#solar-week.index-in-year.html
    
    /// 获取当前日期是在当年第几周，返回序号从1开始。
    /// - Returns: 返回序号：1、2、3、4等
    @objc public func getIndexInYear() -> Int32 {
        let getIndexInYear = solarWeek?.invokeMethod("getIndexInYear", withArguments: nil)
        return getIndexInYear?.toInt32() ?? 1
    }

    //MARK: - 本周每一天
    // https://6tail.cn/calendar/api.html#solar-week.days.html
    
    /// 获取阳历周对象中每一天的阳历对象（可能跨月），返回一个数组。
    /// - Returns:
    @objc public func getDays() -> [Solar] {
        let getDays = solarWeek?.invokeMethod("getDays", withArguments: nil)
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

    /// 获取阳历周对象中每一天的阳历对象（把跨月的部分丢弃掉），返回一个数组。
    /// - Returns:
    @objc public func getDaysInMonth() -> [Solar] {
        let getDays = solarWeek?.invokeMethod("getDaysInMonth", withArguments: nil)
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

    //MARK: - 第一天
    // https://6tail.cn/calendar/api.html#solar-week.first.html
    
    /// 获取阳历周对象中第一天的阳历对象（可能是上月的）。
    /// - Returns:
    @objc public func getFirstDay() -> Solar? {
        let getFirstDay = solarWeek?.invokeMethod("getFirstDay", withArguments: nil)
        guard let getFirstDay = getFirstDay else {
            return nil
        }
        return Solar(jsValue: getFirstDay)
    }
    
    /// 获取阳历周对象中第一天的阳历对象（只算本月的，如果第一天是上月，则往后顺延）。
    /// - Returns:
    @objc public func getFirstDayInMonth() -> Solar? {
        let getFirstDayInMonth = solarWeek?.invokeMethod("getFirstDayInMonth", withArguments: nil)
        guard let getFirstDayInMonth = getFirstDayInMonth else {
            return nil
        }
        return Solar(jsValue: getFirstDayInMonth)
    }

    //MARK: - 周的推移
    // https://6tail.cn/calendar/api.html#solar-week.next.html
    
    /// 获取加(减)几周后(前)的阳历周对象。按月单独计算时，如果中间某一周有跨月现象，则那一周会当作2周计。
    /// - Parameters:
    ///   - weeks: 推移的周数，正数为往后推，负数为往前推。
    ///   - separateMonth: 是否按月单独计算，true按月单独计算，false遇跨月也算一周。
    /// - Returns: 阳历周对象
    @objc public func next(weeks: Int, separateMonth: Bool = false) -> SolarWeek? {
        let next = solarWeek?.invokeMethod("next", withArguments: [weeks, separateMonth])
        guard let next = next else {
            return nil
        }
        return SolarWeek(jsValue: next)
    }


}
