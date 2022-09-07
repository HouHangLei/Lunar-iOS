//
//  DaYun.swift
//  Lunar-iOS
//
//  Created by HL on 2022/9/6.
//
// 大运

import UIKit
import JavaScriptCore

public class DaYun: NSObject {
    
    public var daYun: JSValue?

    /// 使用JSValue初始化
    /// - Parameter jsValue: JSValue
    @objc public init(jsValue: JSValue) {
        self.daYun = jsValue
    }

}

extension DaYun {
    
    /// 获取大运起始年(包含)。
    /// - Returns: 例：1
    @objc public func getStartYear() -> String? {
        let getStartYear = daYun?.invokeMethod("getStartYear", withArguments: nil)
        return getStartYear?.toString()
    }

    /// 获取大运结束年(包含)。
    /// - Returns: 例：12
    @objc public func getEndYear() -> String? {
        let getEndYear = daYun?.invokeMethod("getEndYear", withArguments: nil)
        return getEndYear?.toString()
    }

    /// 获取大运起始年龄(即岁数，包含)。
    /// - Returns: 例：12
    @objc public func getStartAge() -> String? {
        let getStartAge = daYun?.invokeMethod("getStartAge", withArguments: nil)
        return getStartAge?.toString()
    }

    /// 获取大运结束年龄(即岁数，包含)。
    /// - Returns: 例：12
    @objc public func getEndAge() -> String? {
        let getEndAge = daYun?.invokeMethod("getEndAge", withArguments: nil)
        return getEndAge?.toString()
    }

    /// 获取第几轮大运(数字，0-9，0为出生年份，1为起大运)。
    /// - Returns: 例：1
    @objc public func getIndex() -> Int32 {
        let getIndex = daYun?.invokeMethod("getIndex", withArguments: nil)
        return getIndex?.toInt32() ?? -1
    }

    /// 获取干支。
    /// - Returns:
    @objc public func getGanZhi() -> String? {
        let getGanZhi = daYun?.invokeMethod("getGanZhi", withArguments: nil)
        return getGanZhi?.toString()
    }

    /// 获取流年表
    /// - Returns: 流年对象数组
    @objc public func getLiuNian() -> [LiuNian]? {
        let getLiuNian = daYun?.invokeMethod("getLiuNian", withArguments: nil)
        guard let array = getLiuNian?.toArray() else {
            return nil
        }
        var liuNians: [LiuNian] = []
        for i in 0..<array.count {
            if let jsValue = getLiuNian?.objectAtIndexedSubscript(i) {
                let liuNian = LiuNian(jsValue: jsValue)
                liuNians.append(liuNian)
            }
        }
        return liuNians
    }
    
    /// 获取小运表
    /// - Returns: 小运对象数组
    @objc public func getXiaoYun() -> [XiaoYun]? {
        let getXiaoYun = daYun?.invokeMethod("getXiaoYun", withArguments: nil)
        guard let array = getXiaoYun?.toArray() else {
            return nil
        }
        var xiaoYuns: [XiaoYun] = []
        for i in 0..<array.count {
            if let jsValue = getXiaoYun?.objectAtIndexedSubscript(i) {
                let xiaoYun = XiaoYun(jsValue: jsValue)
                xiaoYuns.append(xiaoYun)
            }
        }
        return xiaoYuns
    }

    /// 获取所在旬。
    /// - Returns:
    @objc public func getXun() -> String? {
        let getXun = daYun?.invokeMethod("getXun", withArguments: nil)
        return getXun?.toString()
    }

    /// 获取旬空(空亡)。
    /// - Returns:
    @objc public func getXunKong() -> String? {
        let getXunKong = daYun?.invokeMethod("getXunKong", withArguments: nil)
        return getXunKong?.toString()
    }

}
