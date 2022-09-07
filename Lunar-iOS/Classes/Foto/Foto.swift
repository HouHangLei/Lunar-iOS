//
//  Foto.swift
//  Lunar-iOS
//
//  Created by HL on 2022/9/6.
//
// 佛历

import UIKit
import JavaScriptCore

public class Foto: NSObject {
    
    public var foto: JSValue?
    
    /// 使用JSValue初始化
    /// - Parameter jsValue: JSValue
    @objc public init(jsValue: JSValue) {
        self.foto = jsValue
    }

    /// 使用年月日初始化
    /// - Parameters:
    ///   - year: 年
    ///   - month: 月
    ///   - day: 日
    public init(year: Int, month: Int, day: Int) {
        let yMdSubscript = LunarManager.stand.fotoJsValue?.objectForKeyedSubscript("fromYmd")
        let call = yMdSubscript?.call(withArguments: [year, month, day])
        self.foto = call
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
        let yMdSubscript = LunarManager.stand.fotoJsValue?.objectForKeyedSubscript("fromYmdHms")
        let call = yMdSubscript?.call(withArguments: [year, month, day, hour, minute, second])
        self.foto = call
    }

    /// 使用JSValue初始化
    /// - Parameter lunar: 农历对象
    @objc public init(lunar: JSValue) {
        let yMdSubscript = LunarManager.stand.fotoJsValue?.objectForKeyedSubscript("fromLunar")
        let call = yMdSubscript?.call(withArguments: [lunar])
        self.foto = call
    }
}

extension Foto {
    
    //MARK: - toString
    // https://6tail.cn/calendar/api.html#foto.string.html
    
    /// 佛历对象的默认字符串输出
    /// - Returns: 例：二五六六年八月十一
    @objc public func toString() -> String? {
        let toString = foto?.invokeMethod("toString", withArguments: nil)
        return toString?.toString()
    }

    /// 佛历对象的全量字符串输出，包含尽量多的信息
    /// - Returns: 例：二五六六年八月十一
    @objc public func toFullString() -> String? {
        let toFullString = foto?.invokeMethod("toFullString", withArguments: nil)
        return toFullString?.toString()
    }

    //MARK: - 获取年、月、日
    // https://6tail.cn/calendar/api.html#foto.ymd.html
    
    /// 获取佛历年的数字
    /// - Returns: 例：2566
    @objc public func getYear() -> String? {
        let getYear = foto?.invokeMethod("getYear", withArguments: nil)
        return getYear?.toString()
    }

    /// 获取佛历月的数字，值从1到12，但闰月为负数，如闰二月=-2。
    /// - Returns: 例：8
    @objc public func getMonth() -> String? {
        let getMonth = foto?.invokeMethod("getMonth", withArguments: nil)
        return getMonth?.toString()
    }

    /// 获取佛历日的数字
    /// - Returns: 例：11
    @objc public func getDay() -> String? {
        let getDay = foto?.invokeMethod("getDay", withArguments: nil)
        return getDay?.toString()
    }

    /// 获取佛历年的中文
    /// - Returns: 例：二五六六
    @objc public func getYearInChinese() -> String? {
        let getYearInChinese = foto?.invokeMethod("getYearInChinese", withArguments: nil)
        return getYearInChinese?.toString()
    }

    /// 获取佛历月的中文
    /// - Returns: 例：八
    @objc public func getMonthInChinese() -> String? {
        let getMonthInChinese = foto?.invokeMethod("getMonthInChinese", withArguments: nil)
        return getMonthInChinese?.toString()
    }

    /// 获取佛历日的中文
    /// - Returns: 例：十一
    @objc public func getDayInChinese() -> String? {
        let getDayInChinese = foto?.invokeMethod("getDayInChinese", withArguments: nil)
        return getDayInChinese?.toString()
    }

    //MARK: - 因果犯忌
    // https://6tail.cn/calendar/api.html#foto.festivals.html
    
    /// 获取因果犯忌对象数组
    /// - Returns: 因果犯忌对象数组
    @objc public func getFestivals() -> [YinGuoFanJi] {
        let getFestivals = foto?.invokeMethod("getFestivals", withArguments: nil)
        guard let array = getFestivals?.toArray() else {
            return []
        }
        var yinGuoFanJis: [YinGuoFanJi] = []
        for i in 0..<array.count {
            if let jsValue = getFestivals?.objectAtIndexedSubscript(i) {
                let yinGuoFanJi = YinGuoFanJi(jsValue: jsValue)
                yinGuoFanJis.append(yinGuoFanJi)
            }
        }
        return yinGuoFanJis
    }

    //MARK: - 月斋
    // https://6tail.cn/calendar/api.html#foto.month-zhai.html
    
    /// 当月是否月斋
    /// - Returns:
    @objc public func isMonthZhai() -> Bool {
        let isMonthZhai = foto?.invokeMethod("isMonthZhai", withArguments: nil)
        return isMonthZhai?.toBool() ?? false
    }

    //MARK: - 十斋日
    // https://6tail.cn/calendar/api.html#foto.day-zhai-ten.html
    
    /// 当日是否十斋日
    /// - Returns:
    @objc public func isDayZhaiTen() -> Bool {
        let isDayZhaiTen = foto?.invokeMethod("isDayZhaiTen", withArguments: nil)
        return isDayZhaiTen?.toBool() ?? false
    }

    //MARK: - 六斋日
    // https://6tail.cn/calendar/api.html#foto.day-zhai-six.html
    
    /// 当日是否六斋日
    /// - Returns:
    @objc public func isDayZhaiSix() -> Bool {
        let isDayZhaiSix = foto?.invokeMethod("isDayZhaiSix", withArguments: nil)
        return isDayZhaiSix?.toBool() ?? false
    }

    //MARK: - 朔望斋
    // https://6tail.cn/calendar/api.html#foto.day-zhai-shuowang.html
    
    /// 当日是否朔望斋
    /// - Returns:
    @objc public func isDayZhaiShuoWang() -> Bool {
        let isDayZhaiShuoWang = foto?.invokeMethod("isDayZhaiShuoWang", withArguments: nil)
        return isDayZhaiShuoWang?.toBool() ?? false
    }

    //MARK: - 观音斋
    // https://6tail.cn/calendar/api.html#foto.day-zhai-shuowang.html
    
    /// 当日是否观音斋
    /// - Returns:
    @objc public func isDayZhaiGuanYin() -> Bool {
        let isDayZhaiGuanYin = foto?.invokeMethod("isDayZhaiGuanYin", withArguments: nil)
        return isDayZhaiGuanYin?.toBool() ?? false
    }

    //MARK: - 杨公忌
    // https://6tail.cn/calendar/api.html#foto.yanggong.html
    
    /// 当日是否杨公忌
    /// - Returns:
    @objc public func isDayYangGong() -> Bool {
        let isDayYangGong = foto?.invokeMethod("isDayYangGong", withArguments: nil)
        return isDayYangGong?.toBool() ?? false
    }

    //MARK: - 二十七宿
    // https://6tail.cn/calendar/api.html#foto.xiu.html
    
    /// 获取宿
    /// - Returns: 例：危
    @objc public func getXiu() -> String? {
        let getXiu = foto?.invokeMethod("getXiu", withArguments: nil)
        return getXiu?.toString()
    }

    /// 获取动物
    /// - Returns: 例：燕
    @objc public func getAnimal() -> String? {
        let getAnimal = foto?.invokeMethod("getAnimal", withArguments: nil)
        return getAnimal?.toString()
    }

    /// 获取星宿吉凶
    /// - Returns: 例：吉
    @objc public func getXiuLuck() -> String? {
        let getXiuLuck = foto?.invokeMethod("getXiuLuck", withArguments: nil)
        return getXiuLuck?.toString()
    }

    /// 获取星宿歌诀，歌诀实在是太多了，这里就不写了。
    /// - Returns:
    @objc public func getXiuSong() -> String? {
        let getXiuSong = foto?.invokeMethod("getXiuSong", withArguments: nil)
        return getXiuSong?.toString()
    }

    /// 获取宫
    /// - Returns: 例：北
    @objc public func getGong() -> String? {
        let getGong = foto?.invokeMethod("getGong", withArguments: nil)
        return getGong?.toString()
    }

    /// 获取神兽
    /// - Returns:
    @objc public func getShou() -> String? {
        let getShou = foto?.invokeMethod("getShou", withArguments: nil)
        return getShou?.toString()
    }

    /// 获取七政
    /// - Returns: 例：月
    @objc public func getZheng() -> String? {
        let getZheng = foto?.invokeMethod("getZheng", withArguments: nil)
        return getZheng?.toString()
    }

    //MARK: - 转阴历
    // https://6tail.cn/calendar/api.html#foto.lunar.html
    
    /// 佛历转阴历
    /// - Returns: 阴历对象
    @objc public func getLunar() -> Lunar? {
        let getLunar = foto?.invokeMethod("getLunar", withArguments: nil)
        guard let getLunar = getLunar else {
            return nil
        }
        return Lunar(jsValue: getLunar)
    }

}
