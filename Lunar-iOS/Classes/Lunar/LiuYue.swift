//
//  LiuYue.swift
//  Lunar-iOS
//
//  Created by HL on 2022/9/6.
//
// 流月

import UIKit
import JavaScriptCore

public class LiuYue: NSObject {
    
    public var liuYue: JSValue?

    /// 使用JSValue初始化
    /// - Parameter jsValue: JSValue
    @objc public init(jsValue: JSValue) {
        self.liuYue = jsValue
    }

}

extension LiuYue {
    
    /// 获取中文月份。
    /// - Returns:
    @objc public func getMonthInChinese() -> String? {
        let getMonthInChinese = liuYue?.invokeMethod("getMonthInChinese", withArguments: nil)
        return getMonthInChinese?.toString()
    }
    
    /// 获取月序号(数字，0-11)。
    /// - Returns: 例：1
    @objc public func getIndex() -> Int32 {
        let getIndex = liuYue?.invokeMethod("getIndex", withArguments: nil)
        return getIndex?.toInt32() ?? -1
    }

    /// 获取干支。
    /// - Returns:
    @objc public func getGanZhi() -> String? {
        let getGanZhi = liuYue?.invokeMethod("getGanZhi", withArguments: nil)
        return getGanZhi?.toString()
    }

    /// 获取所在旬。
    /// - Returns:
    @objc public func getXun() -> String? {
        let getXun = liuYue?.invokeMethod("getXun", withArguments: nil)
        return getXun?.toString()
    }

    /// 获取旬空(空亡)。
    /// - Returns:
    @objc public func getXunKong() -> String? {
        let getXunKong = liuYue?.invokeMethod("getXunKong", withArguments: nil)
        return getXunKong?.toString()
    }

}
