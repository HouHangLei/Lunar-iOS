//
//  Solar.swift
//  Lunar-iOS
//
//  Created by HL on 2022/9/6.
//
// 阳历

import UIKit
import JavaScriptCore

public class Solar: NSObject {

    public var solar: JSValue?
    
    /// 使用JSValue初始化
    /// - Parameter jsValue: JSValue
    @objc public init(jsValue: JSValue) {
        self.solar = jsValue
    }

    /// 使用Date初始化
    /// - Parameter date: Date
    @objc public init(date: Date) {
        let dateSubscript = LunarManager.stand.solarJsValue?.objectForKeyedSubscript("fromDate")
        let call = dateSubscript?.call(withArguments: [date])
        self.solar = call
    }

    /// 使用年月日初始化
    /// - Parameters:
    ///   - year: 年
    ///   - month: 月
    ///   - day: 日
    public init(year: Int, month: Int, day: Int) {
        let yMdSubscript = LunarManager.stand.solarJsValue?.objectForKeyedSubscript("fromYmd")
        let call = yMdSubscript?.call(withArguments: [year, month, day])
        self.solar = call
    }

    /// 使用年月日时分秒初始化
    /// - Parameters:
    ///   - year: 年
    ///   - month: 月
    ///   - day: 日
    ///   - hour: 时
    ///   - minute: 分
    ///   - second: 秒
    public init(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) {
        let yMdSubscript = LunarManager.stand.solarJsValue?.objectForKeyedSubscript("fromYmdHms")
        let call = yMdSubscript?.call(withArguments: [year, month, day, hour, minute, second])
        self.solar = call
    }
    
    /// 使用儒略日初始化
    /// - Parameter julianDay: 儒略日
    @objc public init(julianDay: Double) {
        let dateSubscript = LunarManager.stand.solarJsValue?.objectForKeyedSubscript("fromJulianDay")
        let call = dateSubscript?.call(withArguments: [julianDay])
        self.solar = call
    }
    
}

extension Solar {
    
    //MARK: - toString
    // https://6tail.cn/calendar/api.html#solar.string.html
    
    /// 阳历对象的默认字符串输出
    /// - Returns:
    @objc public func toString() -> String? {
        let toString = solar?.invokeMethod("toString", withArguments: nil)
        return toString?.toString()
    }

    /// 阳历对象的全量字符串输出，包含尽量多的信息
    /// - Returns:
    @objc public func toFullString() -> String? {
        let toFullString = solar?.invokeMethod("toFullString", withArguments: nil)
        return toFullString?.toString()
    }

    /// 阳历对象的YYYY-MM-DD字符串输出
    /// - Returns:
    @objc public func toYmd() -> String? {
        let toYmd = solar?.invokeMethod("toYmd", withArguments: nil)
        return toYmd?.toString()
    }

    /// 阳历对象的YYYY-MM-DD HH:mm:ss字符串输出
    /// - Returns:
    @objc public func toYmdHms() -> String? {
        let toYmdHms = solar?.invokeMethod("toYmdHms", withArguments: nil)
        return toYmdHms?.toString()
    }

    //MARK: - 获取年、月、日
    // https://6tail.cn/calendar/api.html#solar.ymd.html
    
    /// 获取阳历年
    /// - Returns:
    @objc public func getYear() -> String? {
        let getYear = solar?.invokeMethod("getYear", withArguments: nil)
        return getYear?.toString()
    }

    /// 获取阳历月
    /// - Returns:
    @objc public func getMonth() -> String? {
        let getMonth = solar?.invokeMethod("getMonth", withArguments: nil)
        return getMonth?.toString()
    }

    /// 获取阳历日
    /// - Returns:
    @objc public func getDay() -> String? {
        let getDay = solar?.invokeMethod("getDay", withArguments: nil)
        return getDay?.toString()
    }
    
    //MARK: - 儒略日
    // https://6tail.cn/calendar/api.html#solar.jd.html
    
    /// 获取儒略日
    /// - Returns:
    @objc public func getJulianDay() -> Double {
        let getJulianDay = solar?.invokeMethod("getJulianDay", withArguments: nil)
        return getJulianDay?.toDouble() ?? 0
    }

    //MARK: - 获取星期
    // https://6tail.cn/calendar/api.html#solar.week.html
    
    /// 获取星期数字，0代表星期日，1代表星期一，6代表星期六
    /// - Returns:
    @objc public func getWeek() -> Int32 {
        let getWeek = solar?.invokeMethod("getWeek", withArguments: nil)
        return getWeek?.toInt32() ?? 1
    }

    /// 获取星期的中文：日一二三四五六
    /// - Returns:
    @objc public func getWeekInChinese() -> String? {
        let getWeekInChinese = solar?.invokeMethod("getWeekInChinese", withArguments: nil)
        return getWeekInChinese?.toString()
    }

    //MARK: - 是否闰年
    // https://6tail.cn/calendar/api.html#solar.leap.html
    
    /// 判断是否闰年
    /// - Returns: 返回true/false，true代表闰年，false代表非闰年。
    @objc public func isLeapYear() -> Bool {
        let isLeapYear = solar?.invokeMethod("isLeapYear", withArguments: nil)
        return isLeapYear?.toBool() ?? false
    }
    
    //MARK: - 节日
    // https://6tail.cn/calendar/api.html#solar.festivals.html
    
    /// 返回节日的数组，包括元旦节、国庆节等，也包括母亲节、父亲节、感恩节、圣诞节等，有可能同一天有多个，也可能没有。
    /// - Returns:
    @objc public func getFestivals() -> [String]? {
        let getFestivals = solar?.invokeMethod("getFestivals", withArguments: nil)
        return getFestivals?.toArray() as? [String]
    }

    /// 返回其他纪念日的数组，例如世界抗癌日、香港回归纪念日等，有可能同一天有多个，也可能没有。
    /// - Returns:
    @objc public func getOtherFestivals() -> [String]? {
        let getOtherFestivals = solar?.invokeMethod("getOtherFestivals", withArguments: nil)
        return getOtherFestivals?.toArray() as? [String]
    }

    //MARK: - 星座
    // https://6tail.cn/calendar/api.html#solar.xingzuo.html
    
    /// 获取阳历对应的星座。
    /// - Returns:
    @objc public func getXingZuo() -> String? {
        let getXingZuo = solar?.invokeMethod("getXingZuo", withArguments: nil)
        return getXingZuo?.toString()
    }

    //MARK: - 阳历日期的推移
    // https://6tail.cn/calendar/api.html#solar.next.html
    
    /// 阳历日期的推移
    /// - Parameter days: 为推移的天数，正数为往后推，负数为往前推
    /// - Returns: 推移后的阳历对象
    @objc public func next(days: Int) -> Solar? {
        let next = solar?.invokeMethod("next", withArguments: [days])
        guard let next = next else {
            return nil
        }
        return Solar(jsValue: next)
    }

    /// 阳历日期的推移（仅按工作日推移（法定节假日和正常的周六、周日不算，节假日调休的按工作日计算））
    /// - Parameter days: 为推移的天数，正数为往后推，负数为往前推
    /// - Returns: 推移后的阳历对象
    @objc public func nextWorkday(days: Int) -> Solar? {
        let next = solar?.invokeMethod("next", withArguments: [days, true])
        guard let next = next else {
            return nil
        }
        return Solar(jsValue: next)
    }
    
    //MARK: - 转阴历
    // https://6tail.cn/calendar/api.html#solar.lunar.html
    
    /// 阳历转阴历
    /// - Returns: 阴历对象
    @objc public func getLunar() -> Lunar? {
        let getLunar = solar?.invokeMethod("getLunar", withArguments: nil)
        guard let getLunar = getLunar else {
            return nil
        }
        return Lunar(jsValue: getLunar)
    }


}
