//
//  Tao.swift
//  Lunar-iOS
//
//  Created by HL on 2022/9/6.
//
// 道历

import UIKit
import JavaScriptCore

public class Tao: NSObject {
    
    public var tao: JSValue?
    
    /// 使用JSValue初始化
    /// - Parameter jsValue: JSValue
    @objc public init(jsValue: JSValue) {
        self.tao = jsValue
    }

    /// 使用年月日初始化
    /// - Parameters:
    ///   - year: 年
    ///   - month: 月
    ///   - day: 日
    public init(year: Int, month: Int, day: Int) {
        let yMdSubscript = LunarManager.stand.taoJsValue?.objectForKeyedSubscript("fromYmd")
        let call = yMdSubscript?.call(withArguments: [year, month, day])
        self.tao = call
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
        let yMdSubscript = LunarManager.stand.taoJsValue?.objectForKeyedSubscript("fromYmdHms")
        let call = yMdSubscript?.call(withArguments: [year, month, day, hour, minute, second])
        self.tao = call
    }

    /// 使用JSValue初始化
    /// - Parameter lunar: 农历对象
    @objc public init(lunar: JSValue) {
        let yMdSubscript = LunarManager.stand.taoJsValue?.objectForKeyedSubscript("fromLunar")
        let call = yMdSubscript?.call(withArguments: [lunar])
        self.tao = call
    }

}

extension Tao {
    
    //MARK: - toString
    // https://6tail.cn/calendar/api.html#tao.string.html
    
    /// 道历对象的默认字符串输出
    /// - Returns: 例：四七一九年八月十一
    @objc public func toString() -> String? {
        let toString = tao?.invokeMethod("toString", withArguments: nil)
        return toString?.toString()
    }

    /// 道历对象的全量字符串输出，包含尽量多的信息
    /// - Returns: 例：道歷四七一九年，天運壬寅年，戊申月，壬戌日。八月十一日，亥時。
    @objc public func toFullString() -> String? {
        let toFullString = tao?.invokeMethod("toFullString", withArguments: nil)
        return toFullString?.toString()
    }

    //MARK: - 获取年、月、日
    // https://6tail.cn/calendar/api.html#tao.ymd.html
    
    /// 获取道历年的数字
    /// - Returns: 例：2566
    @objc public func getYear() -> String? {
        let getYear = tao?.invokeMethod("getYear", withArguments: nil)
        return getYear?.toString()
    }

    /// 获取道历月的数字，值从1到12，但闰月为负数，如闰二月=-2。
    /// - Returns: 例：8
    @objc public func getMonth() -> String? {
        let getMonth = tao?.invokeMethod("getMonth", withArguments: nil)
        return getMonth?.toString()
    }

    /// 获取道历日的数字
    /// - Returns: 例：11
    @objc public func getDay() -> String? {
        let getDay = tao?.invokeMethod("getDay", withArguments: nil)
        return getDay?.toString()
    }

    /// 获取道历年的中文
    /// - Returns: 例：四七一九
    @objc public func getYearInChinese() -> String? {
        let getYearInChinese = tao?.invokeMethod("getYearInChinese", withArguments: nil)
        return getYearInChinese?.toString()
    }

    /// 获取道历月的中文
    /// - Returns: 例：八
    @objc public func getMonthInChinese() -> String? {
        let getMonthInChinese = tao?.invokeMethod("getMonthInChinese", withArguments: nil)
        return getMonthInChinese?.toString()
    }

    /// 获取道历日的中文
    /// - Returns: 例：十一
    @objc public func getDayInChinese() -> String? {
        let getDayInChinese = tao?.invokeMethod("getDayInChinese", withArguments: nil)
        return getDayInChinese?.toString()
    }

    //MARK: - 节日
    // https://6tail.cn/calendar/api.html#tao.festivals.html
    
    /// 获取道历节日对象数组
    /// - Returns: 道历节日对象数组
    @objc public func getFestivals() -> [TaoFestivals] {
        let getFestivals = tao?.invokeMethod("getFestivals", withArguments: nil)
        guard let array = getFestivals?.toArray() else {
            return []
        }
        var taoFestivalss: [TaoFestivals] = []
        for i in 0..<array.count {
            if let jsValue = getFestivals?.objectAtIndexedSubscript(i) {
                let taoFestivals = TaoFestivals(jsValue: jsValue)
                taoFestivalss.append(taoFestivals)
            }
        }
        return taoFestivalss
    }

    //MARK: - 三会日
    // https://6tail.cn/calendar/api.html#tao.day-san-hui.html
    
    /// 当日是否三会日
    /// - Returns:
    @objc public func isDaySanHui() -> Bool {
        let isDaySanHui = tao?.invokeMethod("isDaySanHui", withArguments: nil)
        return isDaySanHui?.toBool() ?? false
    }
    
    //MARK: - 三元日
    // https://6tail.cn/calendar/api.html#tao.day-san-yuan.html
    
    /// 当日是否三元日
    /// - Returns:
    @objc public func isDaySanYuan() -> Bool {
        let isDaySanYuan = tao?.invokeMethod("isDaySanYuan", withArguments: nil)
        return isDaySanYuan?.toBool() ?? false
    }

    //MARK: - 八节日
    // https://6tail.cn/calendar/api.html#tao.day-ba-jie.html
    
    /// 当日是否八节日
    /// - Returns:
    @objc public func isDayBaJie() -> Bool {
        let isDayBaJie = tao?.invokeMethod("isDayBaJie", withArguments: nil)
        return isDayBaJie?.toBool() ?? false
    }

    //MARK: - 五腊日
    // https://6tail.cn/calendar/api.html#tao.day-wu-la.html
    
    /// 当日是否五腊日
    /// - Returns:
    @objc public func isDayWuLa() -> Bool {
        let isDayWuLa = tao?.invokeMethod("isDayWuLa", withArguments: nil)
        return isDayWuLa?.toBool() ?? false
    }

    //MARK: - 八会日
    // https://6tail.cn/calendar/api.html#tao.day-ba-hui.html
    
    /// 当日是否八会日
    /// - Returns:
    @objc public func isDayBaHui() -> Bool {
        let isDayBaHui = tao?.invokeMethod("isDayBaHui", withArguments: nil)
        return isDayBaHui?.toBool() ?? false
    }

    //MARK: - 戊日
    // https://6tail.cn/calendar/api.html#tao.day-wu.html
    
    /// 当日是否戊日
    /// - Returns:
    @objc public func isDayWu() -> Bool {
        let isDayWu = tao?.invokeMethod("isDayWu", withArguments: nil)
        return isDayWu?.toBool() ?? false
    }

    /// 当日是否明戊日
    /// - Returns:
    @objc public func isDayMingWu() -> Bool {
        let isDayMingWu = tao?.invokeMethod("isDayMingWu", withArguments: nil)
        return isDayMingWu?.toBool() ?? false
    }

    /// 当日是否暗戊日
    /// - Returns:
    @objc public func isDayAnWu() -> Bool {
        let isDayAnWu = tao?.invokeMethod("isDayAnWu", withArguments: nil)
        return isDayAnWu?.toBool() ?? false
    }

    //MARK: - 天赦日
    // https://6tail.cn/calendar/api.html#tao.day-tianshe.html
    
    /// 当日是否天赦日
    /// - Returns:
    @objc public func isDayTianShe() -> Bool {
        let isDayTianShe = tao?.invokeMethod("isDayTianShe", withArguments: nil)
        return isDayTianShe?.toBool() ?? false
    }

    //MARK: - 转阴历
    // https://6tail.cn/calendar/api.html#tao.lunar.html
    
    /// 道历转阴历
    /// - Returns: 阴历对象
    @objc public func getLunar() -> Lunar? {
        let getLunar = tao?.invokeMethod("getLunar", withArguments: nil)
        guard let getLunar = getLunar else {
            return nil
        }
        return Lunar(jsValue: getLunar)
    }

}
