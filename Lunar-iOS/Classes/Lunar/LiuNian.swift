//
//  LiuNian.swift
//  Lunar-iOS
//
//  Created by HL on 2022/9/6.
//
// 流年

import UIKit
import JavaScriptCore

public class LiuNian: NSObject {
    
    public var liuNian: JSValue?

    /// 使用JSValue初始化
    /// - Parameter jsValue: JSValue
    @objc public init(jsValue: JSValue) {
        self.liuNian = jsValue
    }

}

extension LiuNian {
    
    /// 获取年份。
    /// - Returns: 例：2022
    @objc public func getYear() -> String? {
        let getYear = liuNian?.invokeMethod("getYear", withArguments: nil)
        return getYear?.toString()
    }

    /// 获取年龄。
    /// - Returns: 例：12
    @objc public func getAge() -> String? {
        let getAge = liuNian?.invokeMethod("getAge", withArguments: nil)
        return getAge?.toString()
    }

    /// 获取位于当前大运中的序号(数字，0-9)。
    /// - Returns: 例：1
    @objc public func getIndex() -> Int32 {
        let getIndex = liuNian?.invokeMethod("getIndex", withArguments: nil)
        return getIndex?.toInt32() ?? -1
    }

    /// 获取干支。
    /// - Returns:
    @objc public func getGanZhi() -> String? {
        let getGanZhi = liuNian?.invokeMethod("getGanZhi", withArguments: nil)
        return getGanZhi?.toString()
    }

    /// 获取流年表
    /// - Returns: 流年对象数组
    @objc public func getLiuYue() -> [LiuYue]? {
        let getLiuYue = liuNian?.invokeMethod("getLiuYue", withArguments: nil)
        guard let array = getLiuYue?.toArray() else {
            return nil
        }
        var liuYues: [LiuYue] = []
        for i in 0..<array.count {
            if let jsValue = getLiuYue?.objectAtIndexedSubscript(i) {
                let liuYue = LiuYue(jsValue: jsValue)
                liuYues.append(liuYue)
            }
        }
        return liuYues
    }
    
    /// 获取所在旬。
    /// - Returns:
    @objc public func getXun() -> String? {
        let getXun = liuNian?.invokeMethod("getXun", withArguments: nil)
        return getXun?.toString()
    }

    /// 获取旬空(空亡)。
    /// - Returns:
    @objc public func getXunKong() -> String? {
        let getXunKong = liuNian?.invokeMethod("getXunKong", withArguments: nil)
        return getXunKong?.toString()
    }

}
