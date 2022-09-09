//
//  Lunar.swift
//  Lunar-iOS
//
//  Created by HL on 2022/9/5.
//
// 阴历

import UIKit
import JavaScriptCore

@objcMembers public class Lunar: NSObject {

    public var lunar: JSValue?
    
    /// 使用获取到的阴历对象JSValue初始化
    /// - Parameter jsValue: 阴历对象JSValue
    @objc public init(jsValue: JSValue) {
        self.lunar = jsValue
    }
    
    /// 使用Date初始化
    /// - Parameter date: Date
    @objc public init(date: Date) {
        let dateSubscript = LunarManager.stand.lunarJsValue?.objectForKeyedSubscript("fromDate")
        let call = dateSubscript?.call(withArguments: [date])
        self.lunar = call
    }
    
    /// 使用年月日初始化
    /// - Parameters:
    ///   - year: 年
    ///   - month: 月
    ///   - day: 日
    public init(year: Int, month: Int, day: Int) {
        let yMdSubscript = LunarManager.stand.lunarJsValue?.objectForKeyedSubscript("fromYmd")
        let call = yMdSubscript?.call(withArguments: [year, month, day])
        self.lunar = call
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
        let yMdSubscript = LunarManager.stand.lunarJsValue?.objectForKeyedSubscript("fromYmdHms")
        let call = yMdSubscript?.call(withArguments: [year, month, day, hour, minute, second])
        self.lunar = call
    }
}

extension Lunar {
    
    //MARK: - toString
   
    /// 阴历对象的默认字符串输出
    /// - Returns: Optional("二〇二二年九月初二")
    @objc public func from() -> String? {
        return lunar?.toString()
    }
    
    /// 阴历对象的全量字符串输出，包含尽量多的信息
    /// - Returns: Optional("二〇二二年九月初二 壬寅(虎)年 己酉(鸡)月 癸未(羊)日 子(鼠)时 纳音[金箔金 大驿土 杨柳木 桑柘木] 星期二 东方青龙 星宿[尾火虎](吉) 彭祖百忌[癸不词讼理弱敌强 未不服药毒气入肠] 喜神方位[巽](东南) 阳贵神方位[巽](东南) 阴贵神方位[震](正东) 福神方位[艮](东北) 财神方位[离](正南) 冲[(丁丑)牛] 煞[西]")
    @objc public func toFullString() -> String? {
        let fullString = lunar?.invokeMethod("toFullString", withArguments: nil)
        return fullString?.toString()
    }
    
    /// 获取阴历年的数字
    /// - Returns: 2022
    @objc public func getYear() -> Int32 {
        let year = lunar?.invokeMethod("getYear", withArguments: nil)
        return year?.toInt32() ?? 0
    }
    
    /// 获取阴历月的数字，值从1到12，但闰月为负数，如闰二月=-2。
    /// - Returns: 9
    @objc public func getMonth() -> Int32 {
        let month = lunar?.invokeMethod("getMonth", withArguments: nil)
        return month?.toInt32() ?? 0
    }

    /// 获取阴历日的数字
    /// - Returns: 2
    @objc public func getDay() -> Int32 {
        let day = lunar?.invokeMethod("getDay", withArguments: nil)
        return day?.toInt32() ?? 0
    }

    //MARK: - 获取年月日
    // https://6tail.cn/calendar/api.html#lunar.ymd.html
    
    /// 获取阴历年的中文
    /// - Returns: 二〇二二
    @objc public func getYearInChinese() -> String? {
        let year = lunar?.invokeMethod("getYearInChinese", withArguments: nil)
        return year?.toString()
    }

    /// 获取阴历月的中文
    /// - Returns: 八
    @objc public func getMonthInChinese() -> String? {
        let month = lunar?.invokeMethod("getMonthInChinese", withArguments: nil)
        return month?.toString()
    }

    /// 获取阴历日的中文
    /// - Parameter date: 日期
    /// - Returns: 初七
    @objc public func getDayInChinese() -> String? {
        let day = lunar?.invokeMethod("getDayInChinese", withArguments: nil)
        return day?.toString()
    }

    //MARK: - 获取时辰
    // https://6tail.cn/calendar/api.html#lunar.time.html
    
    /// 获取时辰天干
    /// - Parameter date: 日期
    /// - Returns: Optional("辛")
    @objc public func getTimeGan() -> String? {
        let getTimeGan = lunar?.invokeMethod("getTimeGan", withArguments: nil)
        return getTimeGan?.toString()
    }

    /// 获取时辰地支
    /// - Parameter date: 日期
    /// - Returns: Optional("酉")
    @objc public func getTimeZhi() -> String? {
        let getTimeZhi = lunar?.invokeMethod("getTimeZhi", withArguments: nil)
        return getTimeZhi?.toString()
    }

    /// 获取时辰干支
    /// - Parameter date: 日期
    /// - Returns: Optional("辛酉")
    @objc public func getTimeInGanZhi() -> String? {
        let getTimeInGanZhi = lunar?.invokeMethod("getTimeInGanZhi", withArguments: nil)
        return getTimeInGanZhi?.toString()
    }
    
    /// 获取时辰对象
    /// - Returns: 时辰对象
    @objc public func getTimes() -> [LunarTime]? {
        let getTime = lunar?.invokeMethod("getTimes", withArguments: nil)
        guard let array = getTime?.toArray() else {
            return nil
        }
        var lunarTimes: [LunarTime] = []
        for i in 0..<array.count {
            if let jsValue = getTime?.objectAtIndexedSubscript(i) {
                let lunarTime = LunarTime(jsValue: jsValue)
                lunarTimes.append(lunarTime)
            }
        }
        return lunarTimes
    }
    
    //MARK: - 获取星期
    //https://6tail.cn/calendar/api.html#lunar.week.html
    
    /// 获取星期数字，0代表星期日，1代表星期一，6代表星期六
    /// - Returns: 5
    @objc public func getWeek() -> String? {
        let getWeek = lunar?.invokeMethod("getWeek", withArguments: nil)
        return getWeek?.toString()
    }
    
    /// 获取星期的中文：日一二三四五六
    /// - Returns: 五
    @objc public func getWeekInChinese() -> String? {
        let getWeek = lunar?.invokeMethod("getWeekInChinese", withArguments: nil)
        return getWeek?.toString()
    }
    
    //MARK: - 节日
    //https://6tail.cn/calendar/api.html#lunar.festivals.html
    
    /// 返回常用节日的数组，包括春节、中秋、元宵等，有可能同一天有多个，也可能没有。
    /// - Returns: 春节
    @objc public func getFestivals() -> [String]? {
        let getFestivals = lunar?.invokeMethod("getFestivals", withArguments: nil)
        return getFestivals?.toArray() as? [String]
    }
    
    /// 返回其他传统节日的数组，包括寒衣节、下元节、祭灶日等，有可能同一天有多个，也可能没有。
    /// - Returns: 寒衣节
    @objc public func getOtherFestivals() -> [String]? {
        let getOtherFestivals = lunar?.invokeMethod("getOtherFestivals", withArguments: nil)
        return getOtherFestivals?.toArray() as? [String]
    }

    //MARK: - 干支
    //https://6tail.cn/calendar/api.html#lunar.ganzhi.html
    
    /// 获取干支纪年（新年以正月初一起算）
    /// - Returns:
    @objc public func getYearInGanZhi() -> String? {
        let getYearInGanZhi = lunar?.invokeMethod("getYearInGanZhi", withArguments: nil)
        return getYearInGanZhi?.toString()
    }

    /// 获取阴历年的天干（新年以正月初一起算）
    /// - Returns:
    @objc public func getYearGan() -> String? {
        let getYearGan = lunar?.invokeMethod("getYearGan", withArguments: nil)
        return getYearGan?.toString()
    }

    /// 获取阴历年的地支（新年以正月初一起算）
    /// - Returns:
    @objc public func getYearZhi() -> String? {
        let getYearZhi = lunar?.invokeMethod("getYearZhi", withArguments: nil)
        return getYearZhi?.toString()
    }

    /// 获取干支纪月（新的一月以节交接当天零点起算）
    /// - Returns:
    @objc public func getMonthInGanZhi() -> String? {
        let getMonthInGanZhi = lunar?.invokeMethod("getMonthInGanZhi", withArguments: nil)
        return getMonthInGanZhi?.toString()
    }

    /// 获取阴历月的天干（新的一月以节交接当天零点起算）
    /// - Returns:
    @objc public func getMonthGan() -> String? {
        let getMonthGan = lunar?.invokeMethod("getMonthGan", withArguments: nil)
        return getMonthGan?.toString()
    }

    /// 获取阴历月的地支（新的一月以节交接当天零点起算）
    /// - Returns:
    @objc public func getMonthZhi() -> String? {
        let getMonthZhi = lunar?.invokeMethod("getMonthZhi", withArguments: nil)
        return getMonthZhi?.toString()
    }

    /// 获取干支纪日
    /// - Returns:
    @objc public func getDayInGanZhi() -> String? {
        let getDayInGanZhi = lunar?.invokeMethod("getDayInGanZhi", withArguments: nil)
        return getDayInGanZhi?.toString()
    }
    
    /// 获取阴历日的天干
    /// - Returns:
    @objc public func getDayGan() -> String? {
        let getDayGan = lunar?.invokeMethod("getDayGan", withArguments: nil)
        return getDayGan?.toString()
    }

    /// 获取阴历日的地支
    /// - Returns:
    @objc public func getDayZhi() -> String? {
        let getDayZhi = lunar?.invokeMethod("getDayZhi", withArguments: nil)
        return getDayZhi?.toString()
    }

    /// 获取干支纪年（新年以立春零点起算）
    /// - Returns:
    @objc public func getYearInGanZhiByLiChun() -> String? {
        let getYearInGanZhiByLiChun = lunar?.invokeMethod("getYearInGanZhiByLiChun", withArguments: nil)
        return getYearInGanZhiByLiChun?.toString()
    }

    /// 获取阴历年的天干（新年以立春零点起算）
    /// - Returns:
    @objc public func getYearGanByLiChun() -> String? {
        let getYearGanByLiChun = lunar?.invokeMethod("getYearGanByLiChun", withArguments: nil)
        return getYearGanByLiChun?.toString()
    }

    /// 获取阴历年的地支（新年以立春零点起算）
    /// - Returns:
    @objc public func getYearZhiByLiChun() -> String? {
        let getYearZhiByLiChun = lunar?.invokeMethod("getYearZhiByLiChun", withArguments: nil)
        return getYearZhiByLiChun?.toString()
    }

    /// 获取干支纪年（新年以立春节气交接的时刻起算）
    /// - Returns:
    @objc public func getYearInGanZhiExact() -> String? {
        let getYearInGanZhiExact = lunar?.invokeMethod("getYearInGanZhiExact", withArguments: nil)
        return getYearInGanZhiExact?.toString()
    }

    /// 获取阴历年的天干（新年以立春节气交接的时刻起算）
    /// - Returns:
    @objc public func getYearGanExact() -> String? {
        let getYearGanExact = lunar?.invokeMethod("getYearGanExact", withArguments: nil)
        return getYearGanExact?.toString()
    }

    /// 获取阴历年的地支（新年以立春节气交接的时刻起算）
    /// - Returns:
    @objc public func getYearZhiExact() -> String? {
        let getYearZhiExact = lunar?.invokeMethod("getYearZhiExact", withArguments: nil)
        return getYearZhiExact?.toString()
    }

    /// 获取干支纪月（新的一月以节交接准确时刻起算）
    /// - Returns:
    @objc public func getMonthInGanZhiExact() -> String? {
        let getMonthInGanZhiExact = lunar?.invokeMethod("getMonthInGanZhiExact", withArguments: nil)
        return getMonthInGanZhiExact?.toString()
    }

    /// 获取阴历月的天干（新的一月以节交接准确时刻起算）
    /// - Returns:
    @objc public func getMonthGanExact() -> String? {
        let getMonthGanExact = lunar?.invokeMethod("getMonthGanExact", withArguments: nil)
        return getMonthGanExact?.toString()
    }

    /// 获取阴历月的地支（新的一月以节交接准确时刻起算）
    /// - Returns:
    @objc public func getMonthZhiExact() -> String? {
        let getMonthZhiExact = lunar?.invokeMethod("getMonthZhiExact", withArguments: nil)
        return getMonthZhiExact?.toString()
    }

    /// 获取精确的干支纪日（流派1，晚子时日柱算明天）
    /// - Returns:
    @objc public func getDayInGanZhiExact() -> String? {
        let getDayInGanZhiExact = lunar?.invokeMethod("getDayInGanZhiExact", withArguments: nil)
        return getDayInGanZhiExact?.toString()
    }
    
    /// 获取阴历日的精确天干（流派1，晚子时日柱算明天）
    /// - Returns:
    @objc public func getDayGanExact() -> String? {
        let getDayGanExact = lunar?.invokeMethod("getDayGanExact", withArguments: nil)
        return getDayGanExact?.toString()
    }

    /// 获取阴历日的精确地支（流派1，晚子时日柱算明天）
    /// - Returns:
    @objc public func getDayZhiExact() -> String? {
        let getDayZhiExact = lunar?.invokeMethod("getDayZhiExact", withArguments: nil)
        return getDayZhiExact?.toString()
    }

    /// 获取精确的干支纪日（流派2，晚子时日柱算当天）
    /// - Returns:
    @objc public func getDayInGanZhiExact2() -> String? {
        let getDayInGanZhiExact2 = lunar?.invokeMethod("getDayInGanZhiExact2", withArguments: nil)
        return getDayInGanZhiExact2?.toString()
    }

    /// 获取阴历日的精确天干（流派2，晚子时日柱算当天）
    /// - Returns:
    @objc public func getDayGanExact2() -> String? {
        let getDayGanExact2 = lunar?.invokeMethod("getDayGanExact2", withArguments: nil)
        return getDayGanExact2?.toString()
    }

    /// 获取阴历日的精确地支（流派2，晚子时日柱算当天）
    /// - Returns:
    @objc public func getDayZhiExact2() -> String? {
        let getDayZhiExact2 = lunar?.invokeMethod("getDayZhiExact2", withArguments: nil)
        return getDayZhiExact2?.toString()
    }

    //MARK: - 禄
    //https://6tail.cn/calendar/api.html#lunar.lu.html
    
    /*
     禄神为四柱神煞之一，是民间信仰中的主司官禄之神。
     甲禄在寅，乙禄在卯，丙戊禄在巳，丁己禄在午，庚禄在申，辛禄在酉，壬禄在亥，癸禄在子。
     禄在年支叫岁禄，禄在月支叫建禄，禄在日支叫专禄（也叫日禄），禄在时支叫归禄。
     **/
    /// 获取禄
    /// - Returns: 午命互禄
    @objc public func getDayLu() -> String? {
        let getDayLu = lunar?.invokeMethod("getDayLu", withArguments: nil)
        return getDayLu?.toString()
    }
    
    //MARK: - 生肖
    //https://6tail.cn/calendar/api.html#lunar.shengxiao.html
    
    /// 获取年的生肖（以正月初一起）
    /// - Returns:
    @objc public func getYearShengXiao() -> String? {
        let getYearShengXiao = lunar?.invokeMethod("getYearShengXiao", withArguments: nil)
        return getYearShengXiao?.toString()
    }

    /// 获取月的生肖（以节交接当天起）
    /// - Returns:
    @objc public func getMonthShengXiao() -> String? {
        let getMonthShengXiao = lunar?.invokeMethod("getMonthShengXiao", withArguments: nil)
        return getMonthShengXiao?.toString()
    }

    /// 获取日的生肖
    /// - Returns:
    @objc public func getDayShengXiao() -> String? {
        let getDayShengXiao = lunar?.invokeMethod("getDayShengXiao", withArguments: nil)
        return getDayShengXiao?.toString()
    }
    
    /// 获取时辰的生肖
    /// - Returns:
    @objc public func getTimeShengXiao() -> String? {
        let getTimeShengXiao = lunar?.invokeMethod("getTimeShengXiao", withArguments: nil)
        return getTimeShengXiao?.toString()
    }

    /// 获取年的生肖（以立春当天起）
    /// - Returns:
    @objc public func getYearShengXiaoByLiChun() -> String? {
        let getYearShengXiaoByLiChun = lunar?.invokeMethod("getYearShengXiaoByLiChun", withArguments: nil)
        return getYearShengXiaoByLiChun?.toString()
    }

    /// 获取年的生肖（以立春交接时刻起）
    /// - Returns:
    @objc public func getYearShengXiaoExact() -> String? {
        let getYearShengXiaoExact = lunar?.invokeMethod("getYearShengXiaoExact", withArguments: nil)
        return getYearShengXiaoExact?.toString()
    }

    /// 获取月的生肖（以节交接时刻起）
    /// - Returns:
    @objc public func getMonthShengXiaoExact() -> String? {
        let getMonthShengXiaoExact = lunar?.invokeMethod("getMonthShengXiaoExact", withArguments: nil)
        return getMonthShengXiaoExact?.toString()
    }

    //MARK: - 节气
    //https://6tail.cn/calendar/api.html#lunar.jieqi.html
    
    /// 获取节令名（字符串），当匹配到键为DA_XUE的节令时，也返回中文的大雪，未匹配时返回空字符串
    /// - Returns: 清明
    @objc public func getJie() -> String? {
        let getJie = lunar?.invokeMethod("getJie", withArguments: nil)
        return getJie?.toString()
    }
    
    /// 获取气令名（字符串），当匹配到键为DONG_ZHI的气令时，也返回中文的冬至，未匹配时返回空字符串
    /// - Returns: 冬至
    @objc public func getQi() -> String? {
        let getQi = lunar?.invokeMethod("getQi", withArguments: nil)
        return getQi?.toString()
    }

    /// 获取节气名（字符串），当匹配到键为DA_XUE的节令时，也返回中文的大雪，当匹配到键为DONG_ZHI的气令时，也返回中文的冬至，未匹配时返回空字符串
    /// - Returns: 冬至
    @objc public func getJieQi() -> String? {
        let getJieQi = lunar?.invokeMethod("getJieQi", withArguments: nil)
        return getJieQi?.toString()
    }
    
    /// 获取当年的节气名称（按时间先后排序），由于js中getJieQiTable无法排序，所以提供该方法，某些语言(如java)中getJieQiTable已经排序，所以不提供该方法。
    /// - Parameter date: 日期
    /// - Returns: Optional(["DA_XUE", "冬至", "小寒", "大寒", "立春", "雨水", "惊蛰", "春分", "清明", "谷雨", "立夏", "小满", "芒种", "夏至", "小暑", "大暑", "立秋", "处暑", "白露", "秋分", "寒露", "霜降", "立冬", "小雪", "大雪", "DONG_ZHI", "XIAO_HAN", "DA_HAN", "LI_CHUN", "YU_SHUI", "JING_ZHE"])
    @objc public func getJieQiList() -> [String]? {
        let getJieQiTable = lunar?.invokeMethod("getJieQiList", withArguments: nil)
        return getJieQiTable?.toArray() as? [String]
    }
    
    /// 获取某个节气交接的准确时间（name可通过getJieQiList方法遍历所有节气名称）
    /// - Parameters:
    ///   - name: 节气名称
    /// - Returns: 阳历对象
    @objc public func getJieQiTable(name: String) -> Solar? {
        let getJieQiTable = lunar?.invokeMethod("getJieQiTable", withArguments: nil)
        let getJieQiTableSubscript = getJieQiTable?.objectForKeyedSubscript(name)
        guard let getJieQiTableSubscript = getJieQiTableSubscript else {
            return nil
        }
        return Solar(jsValue: getJieQiTableSubscript)
    }
    
    /// 获取所有节气交接的准确时间
    /// - Parameters:
    /// - Returns: 日期（阳历）例：2020-02-04 17:03:12
    @objc public func getJieQiTable() -> [String: Solar]? {
        let getJieQiTable = lunar?.invokeMethod("getJieQiTable", withArguments: nil)
        guard let getJieQiTableDic = getJieQiTable?.toDictionary() as? [String: Any] else {
            return nil
        }
        var solars: [String: Solar] = [:]
        for jieQiName in getJieQiTableDic.keys {
            let getJieQiTableSubscript = getJieQiTable?.objectForKeyedSubscript(jieQiName)
            guard let getJieQiTableSubscript = getJieQiTableSubscript else {
                return nil
            }
            solars[jieQiName] = Solar(jsValue: getJieQiTableSubscript)
        }
        return solars
    }

    
    /// 获取上一节气（逆推的第一个节气）。
    /// - Parameters:
    ///   - wholeDay: 传true/false，true代表按天匹配，false代表按精确时刻匹配。
    /// - Returns: 节气对象
    @objc public func getPrevJieQi(wholeDay: Bool) -> JieQi? {
        return getPrevJieQi(invokeMethod: "getPrevJieQi", wholeDay: wholeDay)
    }
    
    /// 获取下一节气（顺推的第一个节气）
    /// - Parameters:
    ///   - wholeDay: 传true/false，true代表按天匹配，false代表按精确时刻匹配
    /// - Returns: 节气对象
    @objc public func getNextJieQi(wholeDay: Bool) -> JieQi? {
        return getPrevJieQi(invokeMethod: "getNextJieQi", wholeDay: wholeDay)
    }
    
    /// 获取当前节气
    /// - Parameters:
    /// - Returns: 节气对象，当天无节气返回nil
    @objc public func getCurrentJieQi() -> JieQi? {
        return getPrevJieQi(invokeMethod: "getCurrentJieQi", wholeDay: nil)
    }
    
    /// 获取上一节令（逆推的第一个节令）
    /// - Parameters:
    ///   - wholeDay: 传true/false，true代表按天匹配，false代表按精确时刻匹配
    /// - Returns: 节气对象
    @objc public func getPrevJie(wholeDay: Bool) -> JieQi? {
        return getPrevJieQi(invokeMethod: "getPrevJie", wholeDay: wholeDay)
    }
    
    /// 获取下一节令（顺推的第一个节令）
    /// - Parameters:
    ///   - wholeDay: 传true/false，true代表按天匹配，false代表按精确时刻匹配
    /// - Returns: 节气对象
    @objc public func getNextJie(wholeDay: Bool) -> JieQi? {
        return getPrevJieQi(invokeMethod: "getNextJie", wholeDay: wholeDay)
    }
    
    /// 获取当天节令
    /// - Parameters:
    /// - Returns: 节气对象，当天无节令返回nil
    @objc public func getCurrentJie() -> JieQi? {
        return getPrevJieQi(invokeMethod: "getCurrentJie", wholeDay: nil)
    }
    
    /// 获取上一气令（逆推的第一个气令）
    /// - Parameters:
    ///   - wholeDay: 传true/false，true代表按天匹配，false代表按精确时刻匹配
    /// - Returns: 节气对象
    @objc public func getPrevQi(wholeDay: Bool) -> JieQi? {
        return getPrevJieQi(invokeMethod: "getPrevQi", wholeDay: wholeDay)
    }
    
    /// 获取下一气令（顺推的第一个气令）
    /// - Parameters:
    ///   - wholeDay: 参数wholeDay传true/false，true代表按天匹配，false代表按精确时刻匹配
    /// - Returns: 节气对象
    @objc public func getNextQi(wholeDay: Bool) -> JieQi? {
        return getPrevJieQi(invokeMethod: "getNextQi", wholeDay: wholeDay)
    }
    
    /// 获取当天气令
    /// - Returns: 节气对象，当天无气令返回nil
    @objc public func getCurrentQi() -> JieQi? {
        return getPrevJieQi(invokeMethod: "getCurrentQi", wholeDay: nil)
    }

    private func getPrevJieQi(invokeMethod: String, wholeDay: Bool?) -> JieQi? {
        let getPrevJieQi = lunar?.invokeMethod(invokeMethod, withArguments: wholeDay != nil ? [wholeDay!] : nil)
        guard let getPrevJieQi = getPrevJieQi, getPrevJieQi.isNull == false else {
            return nil
        }
        return JieQi(jsValue: getPrevJieQi)
    }
    
    //MARK: - 物候
    // https://6tail.cn/calendar/api.html#lunar.wuhou.html
    
    /// 获取当天物候字符串
    /// - Returns: 例：蚯蚓结
    @objc public func getWuHou() -> String? {
        let getWuHou = lunar?.invokeMethod("getWuHou", withArguments: nil)
        return getWuHou?.toString()
    }

    /// 获取当天是初候、二候还是三候
    /// - Returns: 例：初候
    @objc public func getHou() -> String? {
        let getHou = lunar?.invokeMethod("getHou", withArguments: nil)
        return getHou?.toString()
    }

    //MARK: - 数九
    //https://6tail.cn/calendar/api.html#lunar.shujiu.html
    
    /// 获取数九
    /// - Returns: 数九对象，如果不是数九天，返回nil
    @objc public func getShuJiu() -> ShuJiu? {
        let getShuJiu = lunar?.invokeMethod("getShuJiu", withArguments: nil)
        guard let getShuJiu = getShuJiu, getShuJiu.isNull == false else {
            return nil
        }
        return ShuJiu(jsValue: getShuJiu)
    }

    //MARK: - 三伏
    //https://6tail.cn/calendar/api.html#lunar.fu.html
    
    /// 获取三伏
    /// - Returns: 三伏对象，如果不是三伏天，返回nil
    @objc public func getFu() -> Fu? {
        let getFu = lunar?.invokeMethod("getFu", withArguments: nil)
        guard let getFu = getFu, getFu.isNull == false else {
            return nil
        }
        return Fu(jsValue: getFu)
    }
    
    //MARK: - 六曜
    //https://6tail.cn/calendar/api.html#lunar.liuyao.html
    
    /// 获取六曜
    /// - Returns: 例：佛灭
    @objc public func getLiuYao() -> String? {
        let getLiuYao = lunar?.invokeMethod("getLiuYao", withArguments: nil)
        return getLiuYao?.toString()
    }

    //MARK: - 二十八宿
    //https://6tail.cn/calendar/api.html#lunar.xiu.html
    
    /// 获取宿
    /// - Returns: 例：危
    @objc public func getXiu() -> String? {
        let getXiu = lunar?.invokeMethod("getXiu", withArguments: nil)
        return getXiu?.toString()
    }
    
    /// 获取动物
    /// - Returns: 例：燕
    @objc public func getAnimal() -> String? {
        let getAnimal = lunar?.invokeMethod("getAnimal", withArguments: nil)
        return getAnimal?.toString()
    }
    
    /// 获取星宿吉凶，返回吉或凶。
    /// - Returns: 例：吉
    @objc public func getXiuLuck() -> String? {
        let getXiuLuck = lunar?.invokeMethod("getXiuLuck", withArguments: nil)
        return getXiuLuck?.toString()
    }
    
    /// 获取星宿歌诀，歌诀实在是太多了，这里就不写了。
    /// - Returns: 例：危星不可造高楼，自遭刑吊见血光，三年孩子遭水厄，后生出外永不还，埋葬若还逢此日，周年百日取高堂，三年两载一悲伤，开门放水到官堂。
    @objc public func getXiuSong() -> String? {
        let getXiuSong = lunar?.invokeMethod("getXiuSong", withArguments: nil)
        return getXiuSong?.toString()
    }

    //MARK: - 七政(七曜)
    //https://6tail.cn/calendar/api.html#lunar.zheng.html
    
    /// 获取政，日月金木水火土
    /// - Returns: 例：月
    @objc public func getZheng() -> String? {
        let getZheng = lunar?.invokeMethod("getZheng", withArguments: nil)
        return getZheng?.toString()
    }

    //MARK: - 四宫
    //https://6tail.cn/calendar/api.html#lunar.gong.html
    
    /// 获取宫，东南西北
    /// - Returns: 例：北
    @objc public func getGong() -> String? {
        let getGong = lunar?.invokeMethod("getGong", withArguments: nil)
        return getGong?.toString()
    }

    //MARK: - 四神兽
    //https://6tail.cn/calendar/api.html#lunar.shou.html
    
    /// 获取神兽，青龙、朱雀、白虎、玄武
    /// - Returns: 例：玄武
    @objc public func getShou() -> String? {
        let getShou = lunar?.invokeMethod("getShou", withArguments: nil)
        return getShou?.toString()
    }

    //MARK: - 彭祖百忌
    //https://6tail.cn/calendar/api.html#lunar.pengzu.html
    
    /// 获取天干百忌，如甲不开仓财物耗散
    /// - Returns: 例：辛不合酱主人不尝
    @objc public func getPengZuGan() -> String? {
        let getPengZuGan = lunar?.invokeMethod("getPengZuGan", withArguments: nil)
        return getPengZuGan?.toString()
    }
    
    /// 获取地支百忌，如子不问卜自惹祸殃
    /// - Returns: 酉不会客醉坐颠狂
    @objc public func getPengZuZhi() -> String? {
        let getPengZuZhi = lunar?.invokeMethod("getPengZuZhi", withArguments: nil)
        return getPengZuZhi?.toString()
    }

    //MARK: - 吉神方位
    //https://6tail.cn/calendar/api.html#lunar.jishen.html
    
    /// 获取喜神方位
    /// - Returns: 例：艮
    @objc public func getDayPositionXi() -> String? {
        let getDayPositionXi = lunar?.invokeMethod("getDayPositionXi", withArguments: nil)
        return getDayPositionXi?.toString()
    }
    
    /// 获取喜神方位描述
    /// - Returns: 例：东北
    @objc public func getDayPositionXiDesc() -> String? {
        let getDayPositionXiDesc = lunar?.invokeMethod("getDayPositionXiDesc", withArguments: nil)
        return getDayPositionXiDesc?.toString()
    }
    
    /// 获取阳贵神方位
    /// - Returns: 例：艮
    @objc public func getDayPositionYangGui() -> String? {
        let getDayPositionYangGui = lunar?.invokeMethod("getDayPositionYangGui", withArguments: nil)
        return getDayPositionYangGui?.toString()
    }
    
    /// 获取阳贵神方位描述
    /// - Returns: 例：东北
    @objc public func getDayPositionYangGuiDesc() -> String? {
        let getDayPositionYangGuiDesc = lunar?.invokeMethod("getDayPositionYangGuiDesc", withArguments: nil)
        return getDayPositionYangGuiDesc?.toString()
    }
    
    /// 获取阴贵神方位
    /// - Returns: 例：艮
    @objc public func getDayPositionYinGui() -> String? {
        let getDayPositionYinGui = lunar?.invokeMethod("getDayPositionYinGui", withArguments: nil)
        return getDayPositionYinGui?.toString()
    }
    
    /// 获取阴贵神方位描述
    /// - Returns: 例：东北
    @objc public func getDayPositionYinGuiDesc() -> String? {
        let getDayPositionYinGuiDesc = lunar?.invokeMethod("getDayPositionYinGuiDesc", withArguments: nil)
        return getDayPositionYinGuiDesc?.toString()
    }
    
    /// 获取福神方位
    /// - Returns: 例：艮
    @objc public func getDayPositionFu() -> String? {
        let getDayPositionFu = lunar?.invokeMethod("getDayPositionFu", withArguments: nil)
        return getDayPositionFu?.toString()
    }

    /// 获取福神方位描述
    /// - Returns: 例：东北
    @objc public func getDayPositionFuDesc() -> String? {
        let getDayPositionFuDesc = lunar?.invokeMethod("getDayPositionFuDesc", withArguments: nil)
        return getDayPositionFuDesc?.toString()
    }

    /// 获取财神方位
    /// - Returns: 例：艮
    @objc public func getDayPositionCai() -> String? {
        let getDayPositionCai = lunar?.invokeMethod("getDayPositionCai", withArguments: nil)
        return getDayPositionCai?.toString()
    }

    /// 获取财神方位描述
    /// - Returns: 例：东北
    @objc public func getDayPositionCaiDesc() -> String? {
        let getDayPositionCaiDesc = lunar?.invokeMethod("getDayPositionCaiDesc", withArguments: nil)
        return getDayPositionCaiDesc?.toString()
    }
    
    // 获取时辰吉神方位
    
    /// 获取喜神方位
    /// - Returns: 例：艮
    @objc public func getTimePositionXi() -> String? {
        let getTimePositionXi = lunar?.invokeMethod("getTimePositionXi", withArguments: nil)
        return getTimePositionXi?.toString()
    }

    /// 获取喜神方位描述
    /// - Returns: 例：东北
    @objc public func getTimePositionXiDesc() -> String? {
        let getTimePositionXiDesc = lunar?.invokeMethod("getTimePositionXiDesc", withArguments: nil)
        return getTimePositionXiDesc?.toString()
    }
    
    /// 获取阳贵神方位
    /// - Returns: 例：艮
    @objc public func getTimePositionYangGui() -> String? {
        let getTimePositionYangGui = lunar?.invokeMethod("getTimePositionYangGui", withArguments: nil)
        return getTimePositionYangGui?.toString()
    }

    /// 获取阳贵神方位描述
    /// - Returns: 例：东北
    @objc public func getTimePositionYangGuiDesc() -> String? {
        let getTimePositionYangGuiDesc = lunar?.invokeMethod("getTimePositionYangGuiDesc", withArguments: nil)
        return getTimePositionYangGuiDesc?.toString()
    }

    /// 获取阴贵神方位
    /// - Returns: 例：艮
    @objc public func getTimePositionYinGui() -> String? {
        let getTimePositionYinGui = lunar?.invokeMethod("getTimePositionYinGui", withArguments: nil)
        return getTimePositionYinGui?.toString()
    }

    /// 获取阴贵神方位描述
    /// - Returns: 例：东北
    @objc public func getTimePositionYinGuiDesc() -> String? {
        let getTimePositionYinGuiDesc = lunar?.invokeMethod("getTimePositionYinGuiDesc", withArguments: nil)
        return getTimePositionYinGuiDesc?.toString()
    }

    /// 获取福神方位
    /// - Returns: 例：艮
    @objc public func getTimePositionFu() -> String? {
        let getTimePositionFu = lunar?.invokeMethod("getTimePositionFu", withArguments: nil)
        return getTimePositionFu?.toString()
    }

    /// 获取福神方位描述
    /// - Returns: 例：东北
    @objc public func getTimePositionFuDesc() -> String? {
        let getTimePositionFuDesc = lunar?.invokeMethod("getTimePositionFuDesc", withArguments: nil)
        return getTimePositionFuDesc?.toString()
    }

    /// 获取财神方位
    /// - Returns: 例：艮
    @objc public func getTimePositionCai() -> String? {
        let getTimePositionCai = lunar?.invokeMethod("getTimePositionCai", withArguments: nil)
        return getTimePositionCai?.toString()
    }

    /// 获取财神方位描述
    /// - Returns: 例：东北
    @objc public func getTimePositionCaiDesc() -> String? {
        let getTimePositionCaiDesc = lunar?.invokeMethod("getTimePositionCaiDesc", withArguments: nil)
        return getTimePositionCaiDesc?.toString()
    }

    //MARK: - 胎神方位
    
    /// 获取逐日胎神方位
    /// - Returns: 例：厨灶门 外东南
    @objc public func getDayPositionTai() -> String? {
        let getDayPositionTai = lunar?.invokeMethod("getDayPositionTai", withArguments: nil)
        return getDayPositionTai?.toString()
    }

    /// 获取逐月胎神方位
    /// - Returns: 例：占厕户
    @objc public func getMonthPositionTai() -> String? {
        let getMonthPositionTai = lunar?.invokeMethod("getMonthPositionTai", withArguments: nil)
        return getMonthPositionTai?.toString()
    }
    
    //MARK: - 太岁方位
    //https://6tail.cn/calendar/api.html#lunar.taisui.html
    
    /// 获取当日所在年的太岁方位
    /// - Parameter sect: 流派：不传默认为2，表示新年以立春零点起算；1为新年以正月初一起算；3为新年以立春节气交接的时刻起算。
    /// - Returns: 例：震
    @objc public func getYearPositionTaiSui(sect: Int = 2) -> String? {
        let getYearPositionTaiSui = lunar?.invokeMethod("getYearPositionTaiSui", withArguments: [sect])
        return getYearPositionTaiSui?.toString()
    }
    
    /// 获取当日所在年的太岁方位描述
    /// - Parameter sect: 流派：不传默认为2，表示新年以立春零点起算；1为新年以正月初一起算；3为新年以立春节气交接的时刻起算。
    /// - Returns: 例：北方
    @objc public func getYearPositionTaiSuiDesc(sect: Int = 2) -> String? {
        let getYearPositionTaiSuiDesc = lunar?.invokeMethod("getYearPositionTaiSuiDesc", withArguments: [sect])
        return getYearPositionTaiSuiDesc?.toString()
    }
    
    /// 获取当日所在月的太岁方位
    /// - Parameter sect: 流派：不传默认为2，表示新的一月以节交接当天零点起算；3为新的一月以节交接准确时刻起算。
    /// - Returns: 例：震
    @objc public func getMonthPositionTaiSui(sect: Int = 2) -> String? {
        let getMonthPositionTaiSui = lunar?.invokeMethod("getMonthPositionTaiSui", withArguments: [sect])
        return getMonthPositionTaiSui?.toString()
    }

    /// 获取当日所在月的太岁方位描述
    /// - Parameter sect: 流派：不传默认为2，表示新的一月以节交接当天零点起算；3为新的一月以节交接准确时刻起算。
    /// - Returns: 例：北方
    @objc public func getMonthPositionTaiSuiDesc(sect: Int = 2) -> String? {
        let getMonthPositionTaiSuiDesc = lunar?.invokeMethod("getMonthPositionTaiSuiDesc", withArguments: [sect])
        return getMonthPositionTaiSuiDesc?.toString()
    }
    
    /// 获取当日的太岁方位
    /// - Parameter sect: 流派：不传默认为2，表示新年以立春零点起算；1为新年以正月初一起算；3为新年以立春节气交接的时刻起算。
    /// - Returns: 例：震
    @objc public func getDayPositionTaiSui(sect: Int = 2) -> String? {
        let getDayPositionTaiSui = lunar?.invokeMethod("getDayPositionTaiSui", withArguments: [sect])
        return getDayPositionTaiSui?.toString()
    }
    
    /// 获取当日的太岁方位描述
    /// - Parameter sect: 流派：不传默认为2，表示新年以立春零点起算；1为新年以正月初一起算；3为新年以立春节气交接的时刻起算。
    /// - Returns: 例：北方
    @objc public func getDayPositionTaiSuiDesc(sect: Int = 2) -> String? {
        let getDayPositionTaiSuiDesc = lunar?.invokeMethod("getDayPositionTaiSuiDesc", withArguments: [sect])
        return getDayPositionTaiSuiDesc?.toString()
    }

    //MARK: - 冲煞
    // https://6tail.cn/calendar/api.html#lunar.chongsha.html
    
    /// 获取日地支冲
    /// - Returns: 例：申
    @objc public func getDayChong() -> String? {
        let getDayChong = lunar?.invokeMethod("getDayChong", withArguments: nil)
        return getDayChong?.toString()
    }

    /// 获取日无情之克的天干冲
    /// - Returns: 例：甲
    @objc public func getDayChongGan() -> String? {
        let getDayChongGan = lunar?.invokeMethod("getDayChongGan", withArguments: nil)
        return getDayChongGan?.toString()
    }

    /// 获取日有情之克的天干冲
    /// - Returns: 例：甲
    @objc public func getDayChongGanTie() -> String? {
        let getDayChongGanTie = lunar?.invokeMethod("getDayChongGanTie", withArguments: nil)
        return getDayChongGanTie?.toString()
    }

    /// 获取日地支冲对应的生肖（因为12地支对应12生肖）
    /// - Returns: 例：兔
    @objc public func getDayChongShengXiao() -> String? {
        let getDayChongShengXiao = lunar?.invokeMethod("getDayChongShengXiao", withArguments: nil)
        return getDayChongShengXiao?.toString()
    }

    /// 获取日冲的描述，getDayChongGan+getDayChong+getDayChongShengXiao的组合
    /// - Returns: 例：(壬申)猴
    @objc public func getDayChongDesc() -> String? {
        let getDayChongDesc = lunar?.invokeMethod("getDayChongDesc", withArguments: nil)
        return getDayChongDesc?.toString()
    }

    /// 获取时辰地支冲
    /// - Returns: 例：申
    @objc public func getTimeChong() -> String? {
        let getTimeChong = lunar?.invokeMethod("getTimeChong", withArguments: nil)
        return getTimeChong?.toString()
    }

    /// 获取时辰无情之克的天干冲
    /// - Returns: 例：甲
    @objc public func getTimeChongGan() -> String? {
        let getTimeChongGan = lunar?.invokeMethod("getTimeChongGan", withArguments: nil)
        return getTimeChongGan?.toString()
    }

    /// 获取时辰有情之克的天干冲
    /// - Returns: 例：甲
    @objc public func getTimeChongGanTie() -> String? {
        let getTimeChongGanTie = lunar?.invokeMethod("getTimeChongGanTie", withArguments: nil)
        return getTimeChongGanTie?.toString()
    }

    /// 获取时辰地支冲对应的生肖
    /// - Returns: 例：兔
    @objc public func getTimeChongShengXiao() -> String? {
        let getTimeChongShengXiao = lunar?.invokeMethod("getTimeChongShengXiao", withArguments: nil)
        return getTimeChongShengXiao?.toString()
    }

    /// 获取时辰冲的描述，getTimeChongGan+getTimeChong+getTimeChongShengXiao的组合
    /// - Returns: 例：(壬申)猴
    @objc public func getTimeChongDesc() -> String? {
        let getTimeChongDesc = lunar?.invokeMethod("getTimeChongDesc", withArguments: nil)
        return getTimeChongDesc?.toString()
    }

    //MARK: - 纳音
    // https://6tail.cn/calendar/api.html#lunar.nayin.html
    
    /// 获取年纳音
    /// - Returns: 例：剑锋金
    @objc public func getYearNaYin() -> String? {
        let getYearNaYin = lunar?.invokeMethod("getYearNaYin", withArguments: nil)
        return getYearNaYin?.toString()
    }

    /// 获取月纳音
    /// - Returns: 例：剑锋金
    @objc public func getMonthNaYin() -> String? {
        let getMonthNaYin = lunar?.invokeMethod("getMonthNaYin", withArguments: nil)
        return getMonthNaYin?.toString()
    }

    /// 获取日纳音
    /// - Returns: 例：剑锋金
    @objc public func getDayNaYin() -> String? {
        let getDayNaYin = lunar?.invokeMethod("getDayNaYin", withArguments: nil)
        return getDayNaYin?.toString()
    }

    /// 获取时辰纳音
    /// - Returns: 例：剑锋金
    @objc public func getTimeNaYin() -> String? {
        let getTimeNaYin = lunar?.invokeMethod("getTimeNaYin", withArguments: nil)
        return getTimeNaYin?.toString()
    }

    //MARK: - 八字
    // https://6tail.cn/calendar/api.html#lunar.bazi.html
    
    /// 获取八字对象
    /// - Returns: 八字对象
    @objc public func getEightChar() -> EightChar? {
        let getEightChar = lunar?.invokeMethod("getEightChar", withArguments: nil)
        guard let getEightChar = getEightChar else {
            return nil
        }
        return EightChar(jsValue: getEightChar)
    }

    //MARK: - 旬、旬空(空亡)
    // https://6tail.cn/calendar/api.html#lunar.xun.html
    
    /// 获取年所在旬（以正月初一作为新年的开始）
    /// - Returns:
    @objc public func getYearXun() -> String? {
        let getYearXun = lunar?.invokeMethod("getYearXun", withArguments: nil)
        return getYearXun?.toString()
    }

    /// 获取年所在旬（以立春当天作为新年的开始）
    /// - Returns:
    @objc public func getYearXunByLiChun() -> String? {
        let getYearXunByLiChun = lunar?.invokeMethod("getYearXunByLiChun", withArguments: nil)
        return getYearXunByLiChun?.toString()
    }

    /// 获取年所在旬（以立春交接时刻作为新年的开始）
    /// - Returns:
    @objc public func getYearXunExact() -> String? {
        let getYearXunExact = lunar?.invokeMethod("getYearXunExact", withArguments: nil)
        return getYearXunExact?.toString()
    }

    /// 获取月所在旬（以节交接当天起算）
    /// - Returns:
    @objc public func getMonthXun() -> String? {
        let getMonthXun = lunar?.invokeMethod("getMonthXun", withArguments: nil)
        return getMonthXun?.toString()
    }

    /// 获取月所在旬（以节交接时刻起算）
    /// - Returns:
    @objc public func getMonthXunExact() -> String? {
        let getMonthXunExact = lunar?.invokeMethod("getMonthXunExact", withArguments: nil)
        return getMonthXunExact?.toString()
    }

    /// 获取日所在旬（以节交接当天起算）
    /// - Returns:
    @objc public func getDayXun() -> String? {
        let getDayXun = lunar?.invokeMethod("getDayXun", withArguments: nil)
        return getDayXun?.toString()
    }

    /// 获取日所在旬（晚子时算第二天）
    /// - Returns:
    @objc public func getDayXunExact() -> String? {
        let getDayXunExact = lunar?.invokeMethod("getDayXunExact", withArguments: nil)
        return getDayXunExact?.toString()
    }

    /// 获取时辰所在旬
    /// - Returns:
    @objc public func getTimeXun() -> String? {
        let getTimeXun = lunar?.invokeMethod("getTimeXun", withArguments: nil)
        return getTimeXun?.toString()
    }

    /// 获取值年空亡（以正月初一作为新年的开始）
    /// - Returns:
    @objc public func getYearXunKong() -> String? {
        let getYearXunKong = lunar?.invokeMethod("getYearXunKong", withArguments: nil)
        return getYearXunKong?.toString()
    }

    /// 获取值年空亡（以立春当天作为新年的开始）
    /// - Returns:
    @objc public func getYearXunKongByLiChun() -> String? {
        let getYearXunKongByLiChun = lunar?.invokeMethod("getYearXunKongByLiChun", withArguments: nil)
        return getYearXunKongByLiChun?.toString()
    }

    /// 获取值年空亡（以立春交接时刻作为新年的开始）
    /// - Returns:
    @objc public func getYearXunKongExact() -> String? {
        let getYearXunKongExact = lunar?.invokeMethod("getYearXunKongExact", withArguments: nil)
        return getYearXunKongExact?.toString()
    }

    /// 获取值月空亡（以节交接当天起算）
    /// - Returns:
    @objc public func getMonthXunKong() -> String? {
        let getMonthXunKong = lunar?.invokeMethod("getMonthXunKong", withArguments: nil)
        return getMonthXunKong?.toString()
    }

    /// 获取值月空亡（以节交接时刻起算）
    /// - Returns:
    @objc public func getMonthXunKongExact() -> String? {
        let getMonthXunKongExact = lunar?.invokeMethod("getMonthXunKongExact", withArguments: nil)
        return getMonthXunKongExact?.toString()
    }

    /// 获取值日空亡（以节交接当天起算）
    /// - Returns:
    @objc public func getDayXunKong() -> String? {
        let getDayXunKong = lunar?.invokeMethod("getDayXunKong", withArguments: nil)
        return getDayXunKong?.toString()
    }

    /// 获取值日空亡（晚子时算第二天）
    /// - Returns:
    @objc public func getDayXunKongExact() -> String? {
        let getDayXunKongExact = lunar?.invokeMethod("getDayXunKongExact", withArguments: nil)
        return getDayXunKongExact?.toString()
    }

    /// 获取值时空亡
    /// - Returns:
    @objc public func getTimeXunKong() -> String? {
        let getTimeXunKong = lunar?.invokeMethod("getTimeXunKong", withArguments: nil)
        return getTimeXunKong?.toString()
    }
    
    //MARK: - 十二值星
    // https://6tail.cn/calendar/api.html#lunar.zhixing.html
    
    /// 获取当日的值星
    /// - Returns:
    @objc public func getZhiXing() -> String? {
        let getZhiXing = lunar?.invokeMethod("getZhiXing", withArguments: nil)
        return getZhiXing?.toString()
    }

    //MARK: - 十二天神
    // https://6tail.cn/calendar/api.html#lunar.tianshen.html
    
    /// 获取当日的天神
    /// - Returns:
    @objc public func getDayTianShen() -> String? {
        let getDayTianShen = lunar?.invokeMethod("getDayTianShen", withArguments: nil)
        return getDayTianShen?.toString()
    }

    /// 获取当日的天神是黄道还是黑道
    /// - Returns:
    @objc public func getDayTianShenType() -> String? {
        let getDayTianShenType = lunar?.invokeMethod("getDayTianShenType", withArguments: nil)
        return getDayTianShenType?.toString()
    }

    /// 获取当日的天神是吉还是凶
    /// - Returns:
    @objc public func getDayTianShenLuck() -> String? {
        let getDayTianShenLuck = lunar?.invokeMethod("getDayTianShenLuck", withArguments: nil)
        return getDayTianShenLuck?.toString()
    }

    /// 获取值时的天神
    /// - Returns:
    @objc public func getTimeTianShen() -> String? {
        let getTimeTianShen = lunar?.invokeMethod("getTimeTianShen", withArguments: nil)
        return getTimeTianShen?.toString()
    }

    /// 获取值时的天神是黄道还是黑道
    /// - Returns:
    @objc public func getTimeTianShenType() -> String? {
        let getTimeTianShenType = lunar?.invokeMethod("getTimeTianShenType", withArguments: nil)
        return getTimeTianShenType?.toString()
    }

    /// 获取值时的天神是吉还是凶
    /// - Returns:
    @objc public func getTimeTianShenLuck() -> String? {
        let getTimeTianShenLuck = lunar?.invokeMethod("getTimeTianShenLuck", withArguments: nil)
        return getTimeTianShenLuck?.toString()
    }
    
    //MARK: - 每日宜忌
    // https://6tail.cn/calendar/api.html#lunar.yiji.html
    
    /// 获取当日的宜，返回数组(或列表)，如果没有并不是返回一个空数组(或列表)，而是返回['无']
    /// - Parameter sect: 流派数字，1以节交接当天起算月，2以节交接时刻起算月
    /// - Returns: [纳采,订盟,开光,出行,解除,安香,出火,拆卸,入宅,移徙,修造,上梁,安床,栽种,纳畜,会亲友,安机械,经络]
    @objc public func getDayYi(sect: Int) -> [String]? {
        let getDayYi = lunar?.invokeMethod("getDayYi", withArguments: [sect])
        return getDayYi?.toArray() as? [String]
    }
    
    /// 获取当日的忌，返回数组(或列表)，如果没有并不是返回一个空数组(或列表)，而是返回['无']
    /// - Parameter sect: 流派数字，1以节交接当天起算月，2以节交接时刻起算月
    /// - Returns: [伐木,谢土,行丧,祭祀,作灶,动土,破土,安葬,祈福]
    @objc public func getDayJi(sect: Int) -> [String]? {
        let getDayJi = lunar?.invokeMethod("getDayJi", withArguments: [sect])
        return getDayJi?.toArray() as? [String]
    }

    //MARK: - 时辰宜忌
    // https://6tail.cn/calendar/api.html#lunar.timeyiji.html
    
    /// 获取当前时辰的宜，返回数组(或列表)，如果没有并不是返回一个空数组(或列表)，而是返回['无']
    /// - Returns: [见贵,求财,嫁娶,进人口,移徙,安葬]
    @objc public func getTimeYi() -> [String]? {
        let getTimeYi = lunar?.invokeMethod("getTimeYi", withArguments: nil)
        return getTimeYi?.toArray() as? [String]
    }
    
    /// 获取当前时辰的忌，返回数组(或列表)，如果没有并不是返回一个空数组(或列表)，而是返回['无']
    /// - Returns: [赴任,出行]
    @objc public func getTimeJi() -> [String]? {
        let getTimeJi = lunar?.invokeMethod("getTimeJi", withArguments: nil)
        return getTimeJi?.toArray() as? [String]
    }

    //MARK: - 吉神凶煞
    // https://6tail.cn/calendar/api.html#lunar.jishenxiongsha.html
    
    /// 获取当日的吉神，返回数组(或列表)，如果没有并不是返回一个空数组(或列表)，而是返回['无']
    /// - Returns: [母仓,四相,守日,吉期,续世]
    @objc public func getDayJiShen() -> [String]? {
        let getDayJiShen = lunar?.invokeMethod("getDayJiShen", withArguments: nil)
        return getDayJiShen?.toArray() as? [String]
    }

    /// 获取当日的凶煞，返回数组(或列表)，如果没有并不是返回一个空数组(或列表)，而是返回['无']
    /// - Returns: [月害,血忌,天牢]
    @objc public func getDayXiongSha() -> [String]? {
        let getDayXiongSha = lunar?.invokeMethod("getDayXiongSha", withArguments: nil)
        return getDayXiongSha?.toArray() as? [String]
    }

    //MARK: - 月相
    // https://6tail.cn/calendar/api.html#lunar.yuexiang.html
    
    /// 获取当天月相
    /// - Returns: 例：宵
    @objc public func getYueXiang() -> String? {
        let getYueXiang = lunar?.invokeMethod("getYueXiang", withArguments: nil)
        return getYueXiang?.toString()
    }
    
    /// 获取值年九星
    /// - Parameter sect: 流派：不传默认为2，表示新年以立春零点起算；1为新年以正月初一起算；3为新年以立春节气交接的时刻起算。
    /// - Returns: 九星对象
    @objc public func getYearNineStar(sect: Int = 2) -> NineStar? {
        let getYearNineStar = lunar?.invokeMethod("getYearNineStar", withArguments: [sect])
        guard let getYearNineStar = getYearNineStar else {
            return nil
        }
        return NineStar(jsValue: getYearNineStar)
    }
    
    /// 获取值月九星
    /// - Parameter sect: 流派：不传默认为2，表示新的一月以节交接当天零点起算；3为新的一月以节交接准确时刻起算。
    /// - Returns: 九星对象
    @objc public func getMonthNineStar(sect: Int = 2) -> NineStar? {
        let getMonthNineStar = lunar?.invokeMethod("getMonthNineStar", withArguments: [sect])
        guard let getMonthNineStar = getMonthNineStar else {
            return nil
        }
        return NineStar(jsValue: getMonthNineStar)
    }

    /// 获取值月九星
    /// - Returns: 九星对象
    @objc public func getDayNineStar() -> NineStar? {
        let getDayNineStar = lunar?.invokeMethod("getDayNineStar", withArguments: nil)
        guard let getDayNineStar = getDayNineStar else {
            return nil
        }
        return NineStar(jsValue: getDayNineStar)
    }

    /// 获取值时九星
    /// - Returns: 九星对象
    @objc public func getTimeNineStar() -> NineStar? {
        let getTimeNineStar = lunar?.invokeMethod("getTimeNineStar", withArguments: nil)
        guard let getTimeNineStar = getTimeNineStar else {
            return nil
        }
        return NineStar(jsValue: getTimeNineStar)
    }

    //MARK: - 日期推移
    // https://6tail.cn/calendar/api.html#lunar.next.html
    
    /// 阴历日期的推移
    /// - Parameter days: 为推移的天数，正数为往后推，负数为往前推
    /// - Returns: 推移后的阴历对象
    @objc public func next(days: Int) -> Lunar? {
        let next = lunar?.invokeMethod("next", withArguments: [days])
        guard let next = next else {
            return nil
        }
        return Lunar(jsValue: next)
    }
    
    //MARK: - 转阳历
    // https://6tail.cn/calendar/api.html#lunar.solar.html
    
    /// 阴历转阳历
    /// - Returns: 阳历对象
    @objc public func getSolar() -> Solar? {
        let getSolar = lunar?.invokeMethod("getSolar", withArguments: nil)
        guard let getSolar = getSolar else {
            return nil
        }
        return Solar(jsValue: getSolar)
    }

    //MARK: - 转佛历
    // https://6tail.cn/calendar/api.html#lunar.foto.html
    
    /// 阴历转佛历
    /// - Returns: 佛历对象
    @objc public func getFoto() -> Foto? {
        let getFoto = lunar?.invokeMethod("getFoto", withArguments: nil)
        guard let getFoto = getFoto else {
            return nil
        }
        return Foto(jsValue: getFoto)
    }

    //MARK: - 转道历
    // https://6tail.cn/calendar/api.html#lunar.tao.html
    
    /// 阴历转道历
    /// - Returns: 道历对象
    @objc public func getTao() -> Tao? {
        let getTao = lunar?.invokeMethod("getTao", withArguments: nil)
        guard let getTao = getTao else {
            return nil
        }
        return Tao(jsValue: getTao)
    }

}
