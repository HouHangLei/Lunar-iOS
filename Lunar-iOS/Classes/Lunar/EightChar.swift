//
//  EightChar.swift
//  Lunar-iOS
//
//  Created by HL on 2022/9/6.
//
// 八字

import UIKit
import JavaScriptCore

public class EightChar: NSObject {

    public var eightChar: JSValue?

    /// 使用JSValue初始化
    /// - Parameter jsValue: JSValue
    @objc public init(jsValue: JSValue) {
        self.eightChar = jsValue
    }

}

extension EightChar {
    
    //MARK: - 流派
    // 为了兼容日柱的不同划分方式，这里八字分为2种流派，其中流派1认为晚子时日柱算明天，流派2认为晚子时日柱算当天，两种流派都认为晚子时时柱算明天。当不设置流派时，默认采用流派2。使用EightChar的下属方法可获知或切换流派：
    

    /// 获取流派，数字1或2
    /// - Returns: 数字1或2
    @objc public func getSect() -> Int32 {
        let getSect = eightChar?.invokeMethod("getSect", withArguments: nil)
        return getSect?.toInt32() ?? 0
    }

    /// 获取流派，数字1或2
    /// - Returns: 数字1或2
    @objc public func setSect(sect: Int) {
        eightChar?.invokeMethod("setSect", withArguments: [sect])
    }

    //MARK: - 年柱
    
    /// 获取年柱
    /// - Returns: 例：辛亥
    @objc public func getYear() -> String? {
        let getYear = eightChar?.invokeMethod("getYear", withArguments: nil)
        return getYear?.toString()
    }

    /// 获取年柱天干
    /// - Returns: 例：辛
    @objc public func getYearGan() -> String? {
        let getYearGan = eightChar?.invokeMethod("getYearGan", withArguments: nil)
        return getYearGan?.toString()
    }

    /// 获取年柱地支藏干，由于藏干分本气、中气、余气，所以返回结果可能为1到3个元素
    /// - Returns: 例：["甲", "丙", "戊]
    @objc public func getYearHideGan() -> [String]? {
        let getYearHideGan = eightChar?.invokeMethod("getYearHideGan", withArguments: nil)
        return getYearHideGan?.toArray() as? [String]
    }

    /// 获取年柱地支
    /// - Returns: 例：亥
    @objc public func getYearZhi() -> String? {
        let getYearZhi = eightChar?.invokeMethod("getYearZhi", withArguments: nil)
        return getYearZhi?.toString()
    }

    /// 获取年柱五行
    /// - Returns: 例：金木
    @objc public func getYearWuXing() -> String? {
        let getYearWuXing = eightChar?.invokeMethod("getYearWuXing", withArguments: nil)
        return getYearWuXing?.toString()
    }

    /// 获取年柱纳音
    /// - Returns: 例：杨柳木
    @objc public func getYearNaYin() -> String? {
        let getYearNaYin = eightChar?.invokeMethod("getYearNaYin", withArguments: nil)
        return getYearNaYin?.toString()
    }

    /// 获取年柱天干十神
    /// - Returns: 例：比肩
    @objc public func getYearShiShenGan() -> String? {
        let getYearShiShenGan = eightChar?.invokeMethod("getYearShiShenGan", withArguments: nil)
        return getYearShiShenGan?.toString()
    }

    /// 获取年柱地支十神，由于藏干分本气、中气、余气，所以返回结果可能为1到3个元素
    /// - Returns: 例：[食神, 偏财, 七杀]
    @objc public func getYearShiShenZhi() -> [String]? {
        let getYearShiShenZhi = eightChar?.invokeMethod("getYearShiShenZhi", withArguments: nil)
        return getYearShiShenZhi?.toArray() as? [String]
    }

    /// 获取年柱地势(长生十二神)
    /// - Returns:
    @objc public func getYearDiShi() -> String? {
        let getYearDiShi = eightChar?.invokeMethod("getYearDiShi", withArguments: nil)
        return getYearDiShi?.toString()
    }

    /// 获取年柱所在旬
    /// - Returns:
    @objc public func getYearXun() -> String? {
        let getYearXun = eightChar?.invokeMethod("getYearXun", withArguments: nil)
        return getYearXun?.toString()
    }

    /// 获取年柱旬空(空亡)
    /// - Returns:
    @objc public func getYearXunKong() -> String? {
        let getYearXunKong = eightChar?.invokeMethod("getYearXunKong", withArguments: nil)
        return getYearXunKong?.toString()
    }

    //MARK: - 月柱
    // 八字中的年柱以节交接时刻为准，请使用EightChar的下属方法获得八字月柱相关信息：
    
    /// 获取月柱
    /// - Returns: 例：辛亥
    @objc public func getMonth() -> String? {
        let getMonth = eightChar?.invokeMethod("getMonth", withArguments: nil)
        return getMonth?.toString()
    }

    /// 获取月柱天干
    /// - Returns: 例：辛
    @objc public func getMonthGan() -> String? {
        let getMonthGan = eightChar?.invokeMethod("getMonthGan", withArguments: nil)
        return getMonthGan?.toString()
    }

    /// 获取月柱地支藏干，由于藏干分本气、中气、余气，所以返回结果可能为1到3个元素
    /// - Returns: 例：["甲", "丙", "戊]
    @objc public func getMonthHideGan() -> [String]? {
        let getMonthHideGan = eightChar?.invokeMethod("getMonthHideGan", withArguments: nil)
        return getMonthHideGan?.toArray() as? [String]
    }

    /// 获取月柱地支
    /// - Returns: 例：亥
    @objc public func getMonthZhi() -> String? {
        let getMonthZhi = eightChar?.invokeMethod("getMonthZhi", withArguments: nil)
        return getMonthZhi?.toString()
    }

    /// 获取月柱五行
    /// - Returns: 例：金木
    @objc public func getMonthWuXing() -> String? {
        let getMonthWuXing = eightChar?.invokeMethod("getMonthWuXing", withArguments: nil)
        return getMonthWuXing?.toString()
    }

    /// 获取月柱纳音
    /// - Returns: 例：杨柳木
    @objc public func getMonthNaYin() -> String? {
        let getMonthNaYin = eightChar?.invokeMethod("getMonthNaYin", withArguments: nil)
        return getMonthNaYin?.toString()
    }

    /// 获取月柱天干十神
    /// - Returns:
    @objc public func getMonthShiShenGan() -> String? {
        let getMonthShiShenGan = eightChar?.invokeMethod("getMonthShiShenGan", withArguments: nil)
        return getMonthShiShenGan?.toString()
    }

    /// 获取月柱地支十神，由于藏干分本气、中气、余气，所以返回结果可能为1到3个元素
    /// - Returns: 例：[食神, 偏财, 七杀]
    @objc public func getMonthShiShenZhi() -> [String]? {
        let getMonthShiShenZhi = eightChar?.invokeMethod("getMonthShiShenZhi", withArguments: nil)
        return getMonthShiShenZhi?.toArray() as? [String]
    }

    /// 获取月柱地势(长生十二神)
    /// - Returns:
    @objc public func getMonthDiShi() -> String? {
        let getMonthDiShi = eightChar?.invokeMethod("getMonthDiShi", withArguments: nil)
        return getMonthDiShi?.toString()
    }

    /// 获取月柱所在旬
    /// - Returns:
    @objc public func getMonthXun() -> String? {
        let getMonthXun = eightChar?.invokeMethod("getMonthXun", withArguments: nil)
        return getMonthXun?.toString()
    }

    /// 获取月柱旬空(空亡)
    /// - Returns:
    @objc public func getMonthXunKong() -> String? {
        let getMonthXunKong = eightChar?.invokeMethod("getMonthXunKong", withArguments: nil)
        return getMonthXunKong?.toString()
    }

    //MARK: - 日柱
    // 八字中的日柱区分早晚子时，请注意流派，使用EightChar的下属方法获得八字日柱相关信息：
    
    /// 获取日柱
    /// - Returns: 例：辛亥
    @objc public func getDay() -> String? {
        let getDay = eightChar?.invokeMethod("getDay", withArguments: nil)
        return getDay?.toString()
    }

    /// 获取日柱天干
    /// - Returns: 例：辛
    @objc public func getDayGan() -> String? {
        let getDayGan = eightChar?.invokeMethod("getDayGan", withArguments: nil)
        return getDayGan?.toString()
    }

    /// 获取日柱地支藏干，由于藏干分本气、中气、余气，所以返回结果可能为1到3个元素
    /// - Returns: 例：["甲", "丙", "戊]
    @objc public func getDayHideGan() -> [String]? {
        let getDayHideGan = eightChar?.invokeMethod("getDayHideGan", withArguments: nil)
        return getDayHideGan?.toArray() as? [String]
    }

    /// 获取日柱地支
    /// - Returns: 例：亥
    @objc public func getDayZhi() -> String? {
        let getDayZhi = eightChar?.invokeMethod("getDayZhi", withArguments: nil)
        return getDayZhi?.toString()
    }

    /// 获取日柱五行
    /// - Returns: 例：金木
    @objc public func getDayWuXing() -> String? {
        let getDayWuXing = eightChar?.invokeMethod("getDayWuXing", withArguments: nil)
        return getDayWuXing?.toString()
    }

    /// 获取日柱纳音
    /// - Returns: 例：杨柳木
    @objc public func getDayNaYin() -> String? {
        let getDayNaYin = eightChar?.invokeMethod("getDayNaYin", withArguments: nil)
        return getDayNaYin?.toString()
    }

    /// 获取日柱天干十神，日柱天干十神固定为：日主，也称日元、日干
    /// - Returns:
    @objc public func getDayShiShenGan() -> String? {
        let getDayShiShenGan = eightChar?.invokeMethod("getDayShiShenGan", withArguments: nil)
        return getDayShiShenGan?.toString()
    }

    /// 获取日柱地支十神，由于藏干分本气、中气、余气，所以返回结果可能为1到3个元素
    /// - Returns: 例：[食神, 偏财, 七杀]
    @objc public func getDayShiShenZhi() -> [String]? {
        let getDayShiShenZhi = eightChar?.invokeMethod("getDayShiShenZhi", withArguments: nil)
        return getDayShiShenZhi?.toArray() as? [String]
    }

    /// 获取日柱地势(长生十二神)
    /// - Returns:
    @objc public func getDayDiShi() -> String? {
        let getDayDiShi = eightChar?.invokeMethod("getDayDiShi", withArguments: nil)
        return getDayDiShi?.toString()
    }

    /// 获取日柱所在旬
    /// - Returns:
    @objc public func getDayXun() -> String? {
        let getDayXun = eightChar?.invokeMethod("getDayXun", withArguments: nil)
        return getDayXun?.toString()
    }

    /// 获取日柱旬空(空亡)
    /// - Returns:
    @objc public func getDayXunKong() -> String? {
        let getDayXunKong = eightChar?.invokeMethod("getDayXunKong", withArguments: nil)
        return getDayXunKong?.toString()
    }

    //MARK: - 时柱
        
    /// 获取时柱
    /// - Returns: 例：辛亥
    @objc public func getTime() -> String? {
        let getTime = eightChar?.invokeMethod("getTime", withArguments: nil)
        return getTime?.toString()
    }

    /// 获取时柱天干
    /// - Returns: 例：辛
    @objc public func getTimeGan() -> String? {
        let getTimeGan = eightChar?.invokeMethod("getTimeGan", withArguments: nil)
        return getTimeGan?.toString()
    }

    /// 获取时柱地支藏干，由于藏干分本气、中气、余气，所以返回结果可能为1到3个元素
    /// - Returns: 例：["甲", "丙", "戊]
    @objc public func getTimeHideGan() -> [String]? {
        let getTimeHideGan = eightChar?.invokeMethod("getTimeHideGan", withArguments: nil)
        return getTimeHideGan?.toArray() as? [String]
    }

    /// 获取时柱地支
    /// - Returns: 例：亥
    @objc public func getTimeZhi() -> String? {
        let getTimeZhi = eightChar?.invokeMethod("getTimeZhi", withArguments: nil)
        return getTimeZhi?.toString()
    }

    /// 获取时柱五行
    /// - Returns: 例：金木
    @objc public func getTimeWuXing() -> String? {
        let getTimeWuXing = eightChar?.invokeMethod("getTimeWuXing", withArguments: nil)
        return getTimeWuXing?.toString()
    }

    /// 获取时柱纳音
    /// - Returns: 例：杨柳木
    @objc public func getTimeNaYin() -> String? {
        let getTimeNaYin = eightChar?.invokeMethod("getTimeNaYin", withArguments: nil)
        return getTimeNaYin?.toString()
    }

    /// 获取时柱天干十神，日柱天干十神固定为：日主，也称日元、日干
    /// - Returns:
    @objc public func getTimeShiShenGan() -> String? {
        let getTimeShiShenGan = eightChar?.invokeMethod("getTimeShiShenGan", withArguments: nil)
        return getTimeShiShenGan?.toString()
    }

    /// 获取时柱地支十神，由于藏干分本气、中气、余气，所以返回结果可能为1到3个元素
    /// - Returns: 例：[食神, 偏财, 七杀]
    @objc public func getTimeShiShenZhi() -> [String]? {
        let getTimeShiShenZhi = eightChar?.invokeMethod("getTimeShiShenZhi", withArguments: nil)
        return getTimeShiShenZhi?.toArray() as? [String]
    }

    /// 获取时柱地势(长生十二神)
    /// - Returns:
    @objc public func getTimeDiShi() -> String? {
        let getTimeDiShi = eightChar?.invokeMethod("getTimeDiShi", withArguments: nil)
        return getTimeDiShi?.toString()
    }

    /// 获取时柱所在旬
    /// - Returns:
    @objc public func getTimeXun() -> String? {
        let getTimeXun = eightChar?.invokeMethod("getTimeXun", withArguments: nil)
        return getTimeXun?.toString()
    }

    /// 获取时柱旬空(空亡)
    /// - Returns:
    @objc public func getTimeXunKong() -> String? {
        let getTimeXunKong = eightChar?.invokeMethod("getTimeXunKong", withArguments: nil)
        return getTimeXunKong?.toString()
    }

    //MARK: - 胎元、命宫、身宫
    
    /// 获取胎元
    /// - Returns:
    @objc public func getTaiYuan() -> String? {
        let getTaiYuan = eightChar?.invokeMethod("getTaiYuan", withArguments: nil)
        return getTaiYuan?.toString()
    }
    
    /// 获取命宫
    /// - Returns:
    @objc public func getMingGong() -> String? {
        let getMingGong = eightChar?.invokeMethod("getMingGong", withArguments: nil)
        return getMingGong?.toString()
    }

    /// 获取身宫
    /// - Returns:
    @objc public func getShenGong() -> String? {
        let getShenGong = eightChar?.invokeMethod("getShenGong", withArguments: nil)
        return getShenGong?.toString()
    }
    
    //MARK: - 获取运对象（起运、大运）
    
    /**
     流派1：阳年(年干为甲、丙、戊、庚、壬为阳)生男、阴年(年干为乙、丁、己、辛、癸为阴)生女从出生时辰开始往后推至下一个节令时辰，阴年(年干为乙、丁、己、辛、癸为阴)生男、阳年(年干为甲、丙、戊、庚、壬为阳)生女从出生时辰开始往前倒推至上一个节令时辰，计算经历的天数和时辰数，按3天为1年，1天为4个月，1个时辰为10天进行换算，得到出生几年几个月几天后起运。

     流派2：阳年(年干为甲、丙、戊、庚、壬为阳)生男、阴年(年干为乙、丁、己、辛、癸为阴)生女从出生时辰开始往后推至下一个节令时辰，阴年(年干为乙、丁、己、辛、癸为阴)生男、阳年(年干为甲、丙、戊、庚、壬为阳)生女从出生时辰开始往前倒推至上一个节令时辰，计算经历的分钟数，按4320分钟为1年，360分钟为1个月，12分钟为1天，1分钟为2小时进行换算，得到出生几年几个月几天几小时后起运。
     */
    /// 获取运对象
    /// - Parameters:
    ///   - gender: 性别，1为男，0为女
    ///   - sect: 为流派，1为流派1，2为流派2
    /// - Returns: 运对象
    @objc public func getYun(gender: Int, sect: Int) -> Yun? {
        let getYun = eightChar?.invokeMethod("getYun", withArguments: [gender, sect])
        guard let getYun = getYun else {
            return nil
        }
        return Yun(jsValue: getYun)
    }

}
