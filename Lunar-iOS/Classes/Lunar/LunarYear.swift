//
//  LunarYear.swift
//  Lunar-iOS
//
//  Created by HL on 2022/9/5.
//
// 阴历年

import UIKit
import JavaScriptCore

public class LunarYear: NSObject {
    
    public var lunarYear: JSValue?
    
    /// 使用JSValue初始化
    /// - Parameter jsValue: JSValue
    @objc public init(jsValue: JSValue) {
        self.lunarYear = jsValue
    }
    
    /// 指定阴历年(数字)生成阴历年对象。
    /// - Parameter year: 年份
    @objc public init(year: Int) {
        let dateSubscript = LunarManager.stand.lunarYearJsValue?.objectForKeyedSubscript("fromYear")
        let call = dateSubscript?.call(withArguments: [year])
        self.lunarYear = call
    }
    
}

extension LunarYear {
    
    //MARK: - toString
    // https://6tail.cn/calendar/api.html#lunar-year.string.html
    
    /// 年
    /// - Returns: 例：2012
    @objc public func toString() -> String? {
        let toString = lunarYear?.invokeMethod("toString", withArguments: nil)
        return toString?.toString()
    }
    
    /// 年全称
    /// - Returns: 2012年
    @objc public func toFullString() -> String? {
        let fullString = lunarYear?.invokeMethod("toFullString", withArguments: nil)
        return fullString?.toString()
    }

    //MARK: - 太岁方位
    // 逐年太岁方位在LunarYear对象中获取（这种用于只知道年的情况）：
    // https://6tail.cn/calendar/api.html#lunar.taisui.html
    
    /// 获取当年的太岁方位
    /// - Returns: 例：震
    @objc public func getPositionTaiSui() -> String? {
        let getPositionTaiSui = lunarYear?.invokeMethod("getPositionTaiSui", withArguments: nil)
        return getPositionTaiSui?.toString()
    }
    
    /// 获取当年的太岁方位描述
    /// - Returns: 例：北方
    @objc public func getPositionTaiSuiDesc() -> String? {
        let getPositionTaiSuiDesc = lunarYear?.invokeMethod("getPositionTaiSuiDesc", withArguments: nil)
        return getPositionTaiSuiDesc?.toString()
    }
    
    //MARK: - 获取年
    // https://6tail.cn/calendar/api.html#lunar-year.ymd.html
    
    /// 获取阴历年
    /// - Returns: 例：2022
    @objc public func getYear() -> String? {
        let getYear = lunarYear?.invokeMethod("getYear", withArguments: nil)
        return getYear?.toString()
    }

    //MARK: - 获取阴历月
    // https://6tail.cn/calendar/api.html#lunar-year.months.html
    
    /// 获取阴历年对象中的所有月份（为保障节气的连续性，增加了冗余的月份）。返回一个阴历月对象的数组。
    /// - Returns: 当年的所有阴历月对象
    @objc public func getMonths() -> [LunarMonth]? {
        let getMonths = lunarYear?.invokeMethod("getMonths", withArguments: nil)
        guard let array = getMonths?.toArray() else {
            return nil
        }
        var lunarMonths: [LunarMonth] = []
        for i in 0..<array.count {
            if let jsValue = getMonths?.objectAtIndexedSubscript(i) {
                let lunarMonth = LunarMonth(jsValue: jsValue)
                lunarMonths.append(lunarMonth)
            }
        }
        return lunarMonths
    }
    
    /// 指定当年的阴历月对象
    /// - Parameter lunarMonth: 1-12，闰月为负数，如闰2月为-2
    /// - Returns: 阴历月对象
    @objc public func getMonth(lunarMonth: Int) -> LunarMonth? {
        let getMonth = lunarYear?.invokeMethod("getMonth", withArguments: [lunarMonth])
        guard let getMonth = getMonth, getMonth.isNull == false else {
            return nil
        }
        return LunarMonth(jsValue: getMonth)
    }
    
    //MARK: - 获取闰月
    // https://6tail.cn/calendar/api.html#lunar-year.leap.html
    
    
    /// 获取闰月数字，1代表闰1月，0代表无闰月
    /// - Returns: 例：0
    @objc public func getLeapMonth() -> Int32 {
        let getLeapMonth = lunarYear?.invokeMethod("getLeapMonth", withArguments: nil)
        return getLeapMonth?.toInt32() ?? 0
    }
    
    /// 获取阴历年对象中的所有节气（儒略日）
    /// - Returns: 所有节气（儒略日）
    @objc public func getJieQiJulianDays() -> [Double]? {
        let getJieQiJulianDays = lunarYear?.invokeMethod("getJieQiJulianDays", withArguments: nil)
        return getJieQiJulianDays?.toArray() as? [Double]
    }

    //MARK: - 灶马头
    // https://6tail.cn/calendar/api.html#lunar-year.zaomatou.html
    
    /// 获取几鼠偷粮
    /// - Returns: 例：一鼠偷粮
    @objc public func getTouLiang() -> String? {
        let getTouLiang = lunarYear?.invokeMethod("getTouLiang", withArguments: nil)
        return getTouLiang?.toString()
    }
    
    /// 获取草子几分
    /// - Returns: 例：草子三分
    @objc public func getCaoZi() -> String? {
        let getCaoZi = lunarYear?.invokeMethod("getCaoZi", withArguments: nil)
        return getCaoZi?.toString()
    }
    
    /// 获取几牛耕田
    /// - Returns: 五牛耕田
    @objc public func getGengTian() -> String? {
        let getGengTian = lunarYear?.invokeMethod("getGengTian", withArguments: nil)
        return getGengTian?.toString()
    }
    
    /// 获取花收几分
    /// - Returns: 例：花收五分
    @objc public func getHuaShou() -> String? {
        let getHuaShou = lunarYear?.invokeMethod("getHuaShou", withArguments: nil)
        return getHuaShou?.toString()
    }
    
    /// 获取几龙治水
    /// - Returns: 例：二龙治水
    @objc public func getZhiShui() -> String? {
        let getZhiShui = lunarYear?.invokeMethod("getZhiShui", withArguments: nil)
        return getZhiShui?.toString()
    }
    
    /// 获取几马驮谷
    /// - Returns: 例：十马驮谷
    @objc public func getTuoGu() -> String? {
        let getTuoGu = lunarYear?.invokeMethod("getTuoGu", withArguments: nil)
        return getTuoGu?.toString()
    }
    
    /// 获取几鸡抢米
    /// - Returns: 例：二鸡抢米
    @objc public func getQiangMi() -> String? {
        let getQiangMi = lunarYear?.invokeMethod("getQiangMi", withArguments: nil)
        return getQiangMi?.toString()
    }
    
    /// 获取几姑看蚕
    /// - Returns: 例：二姑看蚕
    @objc public func getKanCan() -> String? {
        let getKanCan = lunarYear?.invokeMethod("getKanCan", withArguments: nil)
        return getKanCan?.toString()
    }
    
    /// 获取几屠共猪
    /// - Returns: 例：九屠共猪
    @objc public func getGongZhu() -> String? {
        let getGongZhu = lunarYear?.invokeMethod("getGongZhu", withArguments: nil)
        return getGongZhu?.toString()
    }
    
    /// 获取甲田几分
    /// - Returns: 例：甲田三分
    @objc public func getJiaTian() -> String? {
        let getJiaTian = lunarYear?.invokeMethod("getJiaTian", withArguments: nil)
        return getJiaTian?.toString()
    }
    
    /// 获取几人分饼
    /// - Returns: 例：六人分饼
    @objc public func getFenBing() -> String? {
        let getFenBing = lunarYear?.invokeMethod("getFenBing", withArguments: nil)
        return getFenBing?.toString()
    }
    
    /// 获取几日得金
    /// - Returns: 一日得金
    @objc public func getDeJin() -> String? {
        let getDeJin = lunarYear?.invokeMethod("getDeJin", withArguments: nil)
        return getDeJin?.toString()
    }
    
    /// 获取几人几丙
    /// - Returns: 五人三丙
    @objc public func getRenBing() -> String? {
        let getRenBing = lunarYear?.invokeMethod("getRenBing", withArguments: nil)
        return getRenBing?.toString()
    }
    
    /// 获取几人几锄
    /// - Returns: 四人二锄
    @objc public func getRenChu() -> String? {
        let getRenChu = lunarYear?.invokeMethod("getRenChu", withArguments: nil)
        return getRenChu?.toString()
    }

    //MARK: - 三元九运
    // https://6tail.cn/calendar/api.html#lunar-year.sanyuanjiuyun.html
    
    /// 获取元
    /// - Returns: 上元
    @objc public func getYuan() -> String? {
        let getYuan = lunarYear?.invokeMethod("getYuan", withArguments: nil)
        return getYuan?.toString()
    }
    
    /// 获取运
    /// - Returns: 八运
    @objc public func getYun() -> String? {
        let getYun = lunarYear?.invokeMethod("getYun", withArguments: nil)
        return getYun?.toString()
    }

    //MARK: - 年推移
    // https://6tail.cn/calendar/api.html#lunar-year.next.html
    
    @objc public func next(years: Int) -> LunarYear? {
        let next = lunarYear?.invokeMethod("next", withArguments: [years])
        guard let next = next else {
            return nil
        }
        return LunarYear(jsValue: next)
    }

    /// 获取值年九星
    /// - Returns: 九星对象
    @objc public func getNineStar() -> NineStar? {
        let getNineStar = lunarYear?.invokeMethod("getNineStar", withArguments: nil)
        guard let getNineStar = getNineStar else {
            return nil
        }
        return NineStar(jsValue: getNineStar)
    }

}
