//
//  TaoFestivals.swift
//  Lunar-iOS
//
//  Created by HL on 2022/9/6.
//
// 道历节日

import UIKit
import JavaScriptCore

public class TaoFestivals: NSObject {
    
    public var taoFestivals: JSValue?
    
    /// 使用JSValue初始化
    /// - Parameter jsValue: JSValue
    @objc public init(jsValue: JSValue) {
        self.taoFestivals = jsValue
    }

}

extension TaoFestivals {
    
    /// 获取是日何日，即名称
    /// - Returns: 例：何仙姑圣诞
    @objc public func getName() -> String? {
        let getName = taoFestivals?.invokeMethod("getName", withArguments: nil)
        return getName?.toString()
    }

    /// 获取备注（字符串），如果没有，返回空字符串
    /// - Returns: 例：天腊，此日五帝会于束方九炁青天
    @objc public func getRemark() -> String? {
        let getRemark = taoFestivals?.invokeMethod("getRemark", withArguments: nil)
        return getRemark?.toString()
    }

    /// 字符串输出名称
    /// - Returns: 例：何仙姑圣诞
    @objc public func toString() -> String? {
        let toString = taoFestivals?.invokeMethod("toString", withArguments: nil)
        return toString?.toString()
    }

    /// 字符串输出名称和备注
    /// - Returns: 例：天腊之辰[天腊，此日五帝会于束方九炁青天]
    @objc public func toFullString() -> String? {
        let toFullString = taoFestivals?.invokeMethod("toFullString", withArguments: nil)
        return toFullString?.toString()
    }

}
