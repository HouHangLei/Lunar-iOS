//
//  YinGuoFanJi.swift
//  Lunar-iOS
//
//  Created by HL on 2022/9/6.
//
// 因果犯忌

import UIKit
import JavaScriptCore

public class YinGuoFanJi: NSObject {

    public var yinGuoFanJi: JSValue?
    
    /// 使用JSValue初始化
    /// - Parameter jsValue: JSValue
    @objc public init(jsValue: JSValue) {
        self.yinGuoFanJi = jsValue
    }

}

extension YinGuoFanJi {
    
    /// 获取是日何日，即名称
    /// - Returns: 例：雷斋日
    @objc public func getName() -> String? {
        let getName = yinGuoFanJi?.invokeMethod("getName", withArguments: nil)
        return getName?.toString()
    }

    /// 获取犯之因果（字符串），如果没有，返回空字符串
    /// - Returns: 例：犯者夺纪
    @objc public func getResult() -> String? {
        let getResult = yinGuoFanJi?.invokeMethod("getResult", withArguments: nil)
        return getResult?.toString()
    }

    /// 是否每月同
    /// - Returns:
    @objc public func isEveryMonth() -> Bool {
        let isEveryMonth = yinGuoFanJi?.invokeMethod("isEveryMonth", withArguments: nil)
        return isEveryMonth?.toBool() ?? false
    }

    /// 获取备注（字符串），如果没有，返回空字符串
    /// - Returns: 例：宜先一日即戒
    @objc public func getRemark() -> String? {
        let getRemark = yinGuoFanJi?.invokeMethod("getRemark", withArguments: nil)
        return getRemark?.toString()
    }

    /// 字符串输出名称
    /// - Returns: 例：雷斋日
    @objc public func toString() -> String? {
        let toString = yinGuoFanJi?.invokeMethod("toString", withArguments: nil)
        return toString?.toString()
    }

    /// 字符串输出，将名称、犯之因果和备注以空格间隔拼接
    /// - Returns: 例：雷斋日 犯者减寿
    @objc public func toFullString() -> String? {
        let toFullString = yinGuoFanJi?.invokeMethod("toFullString", withArguments: nil)
        return toFullString?.toString()
    }

}
