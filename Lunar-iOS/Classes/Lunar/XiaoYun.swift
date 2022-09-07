//
//  XiaoYun.swift
//  Lunar-iOS
//
//  Created by HL on 2022/9/6.
//
// 小运

import UIKit
import JavaScriptCore

public class XiaoYun: NSObject {
    
    public var xiaoYun: JSValue?

    /// 使用JSValue初始化
    /// - Parameter jsValue: JSValue
    @objc public init(jsValue: JSValue) {
        self.xiaoYun = jsValue
    }

}

extension XiaoYun {
    
    /// 获取年份。
    /// - Returns: 例：2022
    @objc public func getYear() -> String? {
        let getYear = xiaoYun?.invokeMethod("getYear", withArguments: nil)
        return getYear?.toString()
    }

    /// 获取年龄。
    /// - Returns: 例：12
    @objc public func getAge() -> String? {
        let getAge = xiaoYun?.invokeMethod("getAge", withArguments: nil)
        return getAge?.toString()
    }

    /// 获取位于当前大运中的序号(数字，0-9)。
    /// - Returns: 例：1
    @objc public func getIndex() -> Int32 {
        let getIndex = xiaoYun?.invokeMethod("getIndex", withArguments: nil)
        return getIndex?.toInt32() ?? -1
    }

    /// 获取干支。
    /// - Returns:
    @objc public func getGanZhi() -> String? {
        let getGanZhi = xiaoYun?.invokeMethod("getGanZhi", withArguments: nil)
        return getGanZhi?.toString()
    }

    /// 获取所在旬。
    /// - Returns:
    @objc public func getXun() -> String? {
        let getXun = xiaoYun?.invokeMethod("getXun", withArguments: nil)
        return getXun?.toString()
    }

    /// 获取旬空(空亡)。
    /// - Returns:
    @objc public func getXunKong() -> String? {
        let getXunKong = xiaoYun?.invokeMethod("getXunKong", withArguments: nil)
        return getXunKong?.toString()
    }

}
