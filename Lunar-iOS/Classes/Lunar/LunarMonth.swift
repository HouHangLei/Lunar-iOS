//
//  LunarMonth.swift
//  Lunar-iOS
//
//  Created by HL on 2022/9/5.
//
// 阴历月

import UIKit
import JavaScriptCore

public class LunarMonth: NSObject {
    
    public var lunarMonth: JSValue?
    
    /// 使用JSValue初始化
    /// - Parameter jsValue: JSValue
    @objc public init(jsValue: JSValue) {
        self.lunarMonth = jsValue
    }

    /// 生成阴历月对象
    /// - Parameters:
    ///   - year: 阴历年
    ///   - month: 阴历月
    ///   - dayCount: 当月天数
    ///   - firstJulianDay: 初一的儒略日
    // new初始化方法无法获取到对象，后续再研究
    @objc public init(year: Int, month: Int, dayCount: Int, firstJulianDay: Int) {
        let dateSubscript = LunarManager.stand.lunarMonthJsValue?.invokeMethod("new", withArguments: [year, month, dayCount, firstJulianDay])
//        let call = dateSubscript?.call(withArguments: [year, month, dayCount, firstJulianDay])
        self.lunarMonth = dateSubscript
    }

    /// 生成阴历月对象（通过阴历年对象[LunarYear]生成阴历月对象）
    /// - Parameters:
    ///   - year: 阴历年
    ///   - month: 阴历月（其中阴历月取值1-12，闰月为负数，如闰2月为-2。）
    @objc public init(year: Int, month: Int) {
        let dateSubscript = LunarManager.stand.lunarMonthJsValue?.objectForKeyedSubscript("fromYm")
        let call = dateSubscript?.call(withArguments: [year, month])
        self.lunarMonth = call
    }
    
}

extension LunarMonth {
    
    //MARK: - toString
    // https://6tail.cn/calendar/api.html#lunar-month.string.html
    
    /// 转换字符串
    /// - Returns: 例：2012年闰四月(29)天
    @objc public func toString() -> String? {
        let toString = lunarMonth?.invokeMethod("toString", withArguments: nil)
        return toString?.toString()
    }
    
    //MARK: - 太岁方位
    // 逐月太岁方位在LunarMonth对象中获取（这种用于只知道年月的情况）：
    // https://6tail.cn/calendar/api.html#lunar.taisui.html
    
    /// 获取当月的太岁方位
    /// - Returns: 例：震
    @objc public func getPositionTaiSui() -> String? {
        let getPositionTaiSui = lunarMonth?.invokeMethod("getPositionTaiSui", withArguments: nil)
        return getPositionTaiSui?.toString()
    }
    
    /// 获取当月的太岁方位描述
    /// - Returns: 例：北方
    @objc public func getPositionTaiSuiDesc() -> String? {
        let getPositionTaiSuiDesc = lunarMonth?.invokeMethod("getPositionTaiSuiDesc", withArguments: nil)
        return getPositionTaiSuiDesc?.toString()
    }

    //MARK: - 获取年、月
    // https://6tail.cn/calendar/api.html#lunar-month.ymd.html
    
    /// 获取阴历年(数字)
    /// - Returns: 例：2022
    @objc public func getYear() -> Int32 {
        let getYear = lunarMonth?.invokeMethod("getYear", withArguments: nil)
        return getYear?.toInt32() ?? 0
    }
    
    /// 获取阴历月(数字)
    /// - Returns: 例：2（闰月为负数）
    @objc public func getMonth() -> Int32 {
        let getMonth = lunarMonth?.invokeMethod("getMonth", withArguments: nil)
        return getMonth?.toInt32() ?? 0
    }

    //MARK: - 获取本月天数
    // https://6tail.cn/calendar/api.html#lunar-month.days.html
    
    /// 获取当月天数（阴历一个月只可能是30天或者29天。获取天数可以判断当月是大月(30天)还是小月(29天)。）
    /// - Returns: 例：30
    @objc public func getDayCount() -> Int32 {
        let getDayCount = lunarMonth?.invokeMethod("getDayCount", withArguments: nil)
        return getDayCount?.toInt32() ?? 0
    }

    //MARK: - 是否闰月
    //https://6tail.cn/calendar/api.html#lunar-month.leap.html
    
    /// 判断当月是否闰月，是返回true，否返回false
    /// - Returns: 例： true
    @objc public func isLeap() -> Bool {
        let isLeap = lunarMonth?.invokeMethod("isLeap", withArguments: nil)
        return isLeap?.toBool() ?? false
    }

    //MARK: - 获取当月初一
    // https://6tail.cn/calendar/api.html#lunar-month.first.html
    
    /// 获取当月初一的儒略日，有了儒略日，就可以很方便的计算出阳历和阴历日期。
    /// - Returns: 例：2459494
    @objc public func getFirstJulianDay() -> Int32 {
        let getFirstJulianDay = lunarMonth?.invokeMethod("getFirstJulianDay", withArguments: nil)
        return getFirstJulianDay?.toInt32() ?? 0
    }

    //MARK: - 阴历月的推移
    // https://6tail.cn/calendar/api.html#lunar-month.next.html
    
    /// 获取加(减)几月后(前)的阳历月对象。
    /// - Parameter months: 推移的月数，正数为往后推，负数为往前推。
    /// - Returns: 阴历月对象
    @objc public func next(months: Int) -> LunarMonth? {
        let next = lunarMonth?.invokeMethod("next", withArguments: [months])
        guard let next = next else {
            return nil
        }
        return LunarMonth(jsValue: next)
    }

    /// 获取值月九星，按正月起寅的方式排。
    /// - Returns: 九星对象
    @objc public func getNineStar() -> NineStar? {
        let getNineStar = lunarMonth?.invokeMethod("getNineStar", withArguments: nil)
        guard let getNineStar = getNineStar else {
            return nil
        }
        return NineStar(jsValue: getNineStar)
    }

}
