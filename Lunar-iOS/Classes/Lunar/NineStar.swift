//
//  NineStar.swift
//  Lunar-iOS
//
//  Created by HL on 2022/9/6.
//
// 九星

import UIKit
import JavaScriptCore

public class NineStar: NSObject {
    
    public var nineStar: JSValue?

    /// 使用JSValue初始化
    /// - Parameter jsValue: JSValue
    @objc public init(jsValue: JSValue) {
        self.nineStar = jsValue
    }

}

extension NineStar {
    
    /// 获取九数
    /// - Returns:
    @objc public func getNumber() -> String? {
        let getNumber = nineStar?.invokeMethod("getNumber", withArguments: nil)
        return getNumber?.toString()
    }

    /// 获取七色
    /// - Returns:
    @objc public func getColor() -> String? {
        let getColor = nineStar?.invokeMethod("getColor", withArguments: nil)
        return getColor?.toString()
    }

    /// 获取五行
    /// - Returns:
    @objc public func getWuXing() -> String? {
        let getWuXing = nineStar?.invokeMethod("getWuXing", withArguments: nil)
        return getWuXing?.toString()
    }

    /// 获取方位
    /// - Returns:
    @objc public func getPosition() -> String? {
        let getPosition = nineStar?.invokeMethod("getPosition", withArguments: nil)
        return getPosition?.toString()
    }

    /// 获取方位描述，如正北、东南等。
    /// - Returns:
    @objc public func getPositionDesc() -> String? {
        let getPositionDesc = nineStar?.invokeMethod("getPositionDesc", withArguments: nil)
        return getPositionDesc?.toString()
    }

    /// 获取北斗九星名称
    /// - Returns:
    @objc public func getNameInBeiDou() -> String? {
        let getNameInBeiDou = nineStar?.invokeMethod("getNameInBeiDou", withArguments: nil)
        return getNameInBeiDou?.toString()
    }

    /// 获取玄空九星名称
    /// - Returns:
    @objc public func getNameInXuanKong() -> String? {
        let getNameInXuanKong = nineStar?.invokeMethod("getNameInXuanKong", withArguments: nil)
        return getNameInXuanKong?.toString()
    }

    /// 获取奇门九星名称
    /// - Returns:
    @objc public func getNameInQiMen() -> String? {
        let getNameInQiMen = nineStar?.invokeMethod("getNameInQiMen", withArguments: nil)
        return getNameInQiMen?.toString()
    }

    /// 获取太乙九神名称
    /// - Returns:
    @objc public func getNameInTaiYi() -> String? {
        let getNameInTaiYi = nineStar?.invokeMethod("getNameInTaiYi", withArguments: nil)
        return getNameInTaiYi?.toString()
    }

    /// 获取玄空九星吉凶
    /// - Returns:
    @objc public func getLuckInXuanKong() -> String? {
        let getLuckInXuanKong = nineStar?.invokeMethod("getLuckInXuanKong", withArguments: nil)
        return getLuckInXuanKong?.toString()
    }

    /// 获取奇门九星吉凶
    /// - Returns:
    @objc public func getLuckInQiMen() -> String? {
        let getLuckInQiMen = nineStar?.invokeMethod("getLuckInQiMen", withArguments: nil)
        return getLuckInQiMen?.toString()
    }

    /// 获取奇门九星阴阳
    /// - Returns:
    @objc public func getYinYangInQiMen() -> String? {
        let getYinYangInQiMen = nineStar?.invokeMethod("getYinYangInQiMen", withArguments: nil)
        return getYinYangInQiMen?.toString()
    }

    /// 获取太乙九神类型（吉神/凶神/安神）
    /// - Returns:
    @objc public func getTypeInTaiYi() -> String? {
        let getTypeInTaiYi = nineStar?.invokeMethod("getTypeInTaiYi", withArguments: nil)
        return getTypeInTaiYi?.toString()
    }

    /// 获取奇门八门
    /// - Returns:
    @objc public func getBaMenInQiMen() -> String? {
        let getBaMenInQiMen = nineStar?.invokeMethod("getBaMenInQiMen", withArguments: nil)
        return getBaMenInQiMen?.toString()
    }

    /// 获取九星序号，从0开始
    /// - Returns:
    @objc public func getIndex() -> Int32 {
        let getIndex = nineStar?.invokeMethod("getIndex", withArguments: nil)
        return getIndex?.toInt32() ?? 0
    }

    /// 获取描述（九数+七色+五行+北斗九星），如：五黄土玉衡
    /// - Returns:
    @objc public func toString() -> String? {
        let toString = nineStar?.invokeMethod("toString", withArguments: nil)
        return toString?.toString()
    }

    /// 获取详细描述
    /// - Returns: 例：四绿木 巽(东南) 天权 玄空[文曲 吉] 奇门[天辅 大吉 杜门 阳] 太乙[招摇 安神]
    @objc public func toFullString() -> String? {
        let toFullString = nineStar?.invokeMethod("toFullString", withArguments: nil)
        return toFullString?.toString()
    }

}
