//
//  LunarTime.swift
//  Lunar-iOS
//
//  Created by HL on 2022/9/6.
//
// 阴历时

import UIKit
import JavaScriptCore

public class LunarTime: NSObject {
    
    public var lunarTime: JSValue?

    /// 使用JSValue初始化
    /// - Parameter jsValue: JSValue
    @objc public init(jsValue: JSValue) {
        self.lunarTime = jsValue
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
        let yMdSubscript = LunarManager.stand.lunarTimeJsValue?.objectForKeyedSubscript("fromYmdHms")
        let call = yMdSubscript?.call(withArguments: [year, month, day, hour, minute, second])
        self.lunarTime = call
    }
}

extension LunarTime {
    
    /// 获取时辰天干
    /// - Returns:
    @objc public func getGan() -> String? {
        let getGan = lunarTime?.invokeMethod("getGan", withArguments: nil)
        return getGan?.toString()
    }

    /// 获取时辰地支
    /// - Returns:
    @objc public func getZhi() -> String? {
        let getZhi = lunarTime?.invokeMethod("getZhi", withArguments: nil)
        return getZhi?.toString()
    }

    /// 获取时辰干支
    /// - Returns:
    @objc public func getGanZhi() -> String? {
        let getGanZhi = lunarTime?.invokeMethod("getGanZhi", withArguments: nil)
        return getGanZhi?.toString()
    }
    
    /// 获取生肖
    /// - Returns:
    @objc public func getShengXiao() -> String? {
        let getShengXiao = lunarTime?.invokeMethod("getShengXiao", withArguments: nil)
        return getShengXiao?.toString()
    }
    
    /// 获取喜神方位
    /// - Returns:
    @objc public func getPositionXi() -> String? {
        let getPositionXi = lunarTime?.invokeMethod("getPositionXi", withArguments: nil)
        return getPositionXi?.toString()
    }

    /// 获取喜神方位描述
    /// - Returns:
    @objc public func getPositionXiDesc() -> String? {
        let getPositionXiDesc = lunarTime?.invokeMethod("getPositionXiDesc", withArguments: nil)
        return getPositionXiDesc?.toString()
    }

    /// 获取阳贵神方位
    /// - Returns:
    @objc public func getPositionYangGui() -> String? {
        let getPositionYangGui = lunarTime?.invokeMethod("getPositionYangGui", withArguments: nil)
        return getPositionYangGui?.toString()
    }

    /// 获取阳贵神方位描述
    /// - Returns:
    @objc public func getPositionYangGuiDesc() -> String? {
        let getPositionYangGuiDesc = lunarTime?.invokeMethod("getPositionYangGuiDesc", withArguments: nil)
        return getPositionYangGuiDesc?.toString()
    }

    /// 获取阴贵神方位
    /// - Returns:
    @objc public func getPositionYinGui() -> String? {
        let getPositionYinGui = lunarTime?.invokeMethod("getPositionYinGui", withArguments: nil)
        return getPositionYinGui?.toString()
    }

    /// 获取阴贵神方位描述
    /// - Returns:
    @objc public func getPositionYinGuiDesc() -> String? {
        let getPositionYinGuiDesc = lunarTime?.invokeMethod("getPositionYinGuiDesc", withArguments: nil)
        return getPositionYinGuiDesc?.toString()
    }

    /// 获取福神方位
    /// - Returns:
    @objc public func getPositionFu() -> String? {
        let getPositionFu = lunarTime?.invokeMethod("getPositionFu", withArguments: nil)
        return getPositionFu?.toString()
    }

    /// 获取福神方位描述
    /// - Returns:
    @objc public func getPositionFuDesc() -> String? {
        let getPositionFuDesc = lunarTime?.invokeMethod("getPositionFuDesc", withArguments: nil)
        return getPositionFuDesc?.toString()
    }

    /// 获取财神方位
    /// - Returns:
    @objc public func getPositionCai() -> String? {
        let getPositionCai = lunarTime?.invokeMethod("getPositionCai", withArguments: nil)
        return getPositionCai?.toString()
    }
    
    /// 获取财神方位描述
    /// - Returns:
    @objc public func getPositionCaiDesc() -> String? {
        let getPositionCaiDesc = lunarTime?.invokeMethod("getPositionCaiDesc", withArguments: nil)
        return getPositionCaiDesc?.toString()
    }

    /// 获取纳音
    /// - Returns:
    @objc public func getNaYin() -> String? {
        let getNaYin = lunarTime?.invokeMethod("getNaYin", withArguments: nil)
        return getNaYin?.toString()
    }
    
    /// 获取天神
    /// - Returns:
    @objc public func getTianShen() -> String? {
        let getTianShen = lunarTime?.invokeMethod("getTianShen", withArguments: nil)
        return getTianShen?.toString()
    }

    /// 获取天神类型：黄道/黑道
    /// - Returns:
    @objc public func getTianShenType() -> String? {
        let getTianShenType = lunarTime?.invokeMethod("getTianShenType", withArguments: nil)
        return getTianShenType?.toString()
    }

    /// 获取值时天神吉凶：吉/凶
    /// - Returns:
    @objc public func getTianShenLuck() -> String? {
        let getTianShenLuck = lunarTime?.invokeMethod("getTianShenLuck", withArguments: nil)
        return getTianShenLuck?.toString()
    }

    /// 获取时冲
    /// - Returns:
    @objc public func getChong() -> String? {
        let getChong = lunarTime?.invokeMethod("getChong", withArguments: nil)
        return getChong?.toString()
    }

    /// 获取时煞
    /// - Returns:
    @objc public func getSha() -> String? {
        let getSha = lunarTime?.invokeMethod("getSha", withArguments: nil)
        return getSha?.toString()
    }

    /// 获取时冲生肖
    /// - Returns:
    @objc public func getChongShengXiao() -> String? {
        let getChongShengXiao = lunarTime?.invokeMethod("getChongShengXiao", withArguments: nil)
        return getChongShengXiao?.toString()
    }

    /// 获取时冲描述
    /// - Returns:
    @objc public func getChongDesc() -> String? {
        let getChongDesc = lunarTime?.invokeMethod("getChongDesc", withArguments: nil)
        return getChongDesc?.toString()
    }

    /// 获取无情之克的时冲天干
    /// - Returns:
    @objc public func getChongGan() -> String? {
        let getChongGan = lunarTime?.invokeMethod("getChongGan", withArguments: nil)
        return getChongGan?.toString()
    }

    /// 获取有情之克的时冲天干
    /// - Returns:
    @objc public func getChongGanTie() -> String? {
        let getChongGanTie = lunarTime?.invokeMethod("getChongGanTie", withArguments: nil)
        return getChongGanTie?.toString()
    }
    
    /// 获取宜，如果没有，返回["无"]
    /// - Returns:
    @objc public func getYi() -> [String]? {
        let getYi = lunarTime?.invokeMethod("getYi", withArguments: nil)
        return getYi?.toArray() as? [String]
    }

    /// 获取忌，如果没有，返回["无"]
    /// - Returns:
    @objc public func getJi() -> [String]? {
        let getJi = lunarTime?.invokeMethod("getJi", withArguments: nil)
        return getJi?.toArray() as? [String]
    }

    /// 获取值时九星
    /// - Returns: 九星对象
    @objc public func getNineStar() -> NineStar? {
        let getNineStar = lunarTime?.invokeMethod("getNineStar", withArguments: nil)
        guard let getNineStar = getNineStar else {
            return nil
        }
        return NineStar(jsValue: getNineStar)
    }

    /// 获取所在旬
    /// - Returns:
    @objc public func getXun() -> String? {
        let getXun = lunarTime?.invokeMethod("getXun", withArguments: nil)
        return getXun?.toString()
    }

    /// 获取值时空亡
    /// - Returns:
    @objc public func getXunKong() -> String? {
        let getXunKong = lunarTime?.invokeMethod("getXunKong", withArguments: nil)
        return getXunKong?.toString()
    }

    /// 获取当前时辰的最早时分
    /// - Returns: 例：21:00
    @objc public func getMinHm() -> String? {
        let getMinHm = lunarTime?.invokeMethod("getMinHm", withArguments: nil)
        return getMinHm?.toString()
    }
    
    /// 获取当前时辰的最晚时分
    /// - Returns: 例：22:59
    @objc public func getMaxHm() -> String? {
        let getMaxHm = lunarTime?.invokeMethod("getMaxHm", withArguments: nil)
        return getMaxHm?.toString()
    }

    /// 获取字符串输出，默认输出干支
    /// - Returns:
    @objc public func toString() -> String? {
        let toString = lunarTime?.invokeMethod("toString", withArguments: nil)
        return toString?.toString()
    }
}
