//
//  SolarUtil.swift
//  Lunar-iOS
//
//  Created by HL on 2022/9/6.
//

import UIKit
import JavaScriptCore

public class SolarUtil: NSObject {
    
    /// 判断某年是否闰年。
    /// - Parameter year: 年份
    /// - Returns: true：是闰年。 false：非闰年。
    public class func convertTime(year: Int) -> Bool {
        let isLeapYear = LunarManager.stand.solarUtilJsValue?.invokeMethod("isLeapYear", withArguments: [year])
        return isLeapYear?.toBool() ?? false
    }
    
    /// 获取某年天数
    /// - Parameter year: 年份
    /// - Returns: 闰年366天，平年365天。
    public class func getDaysOfYear(year: Int) -> Int32 {
        let getDaysOfYear = LunarManager.stand.solarUtilJsValue?.invokeMethod("getDaysOfYear", withArguments: [year])
        return getDaysOfYear?.toInt32() ?? 0
    }
    
    /// 获取阳历某月天数
    /// - Parameters:
    ///   - year: 年份
    ///   - month: 月份
    /// - Returns: 这个月的天数
    public class func getDaysOfMonth(year: Int, month: Int) -> Int32 {
        let getDaysOfMonth = LunarManager.stand.solarUtilJsValue?.invokeMethod("getDaysOfMonth", withArguments: [year, month])
        return getDaysOfMonth?.toInt32() ?? 0
    }
    
    /// 获取某月周数
    /// - Parameters:
    ///   - year: 阳历年(数字)。
    ///   - month: 阳历月(数字)。
    ///   - start: 星期几作为一周的开始，1234560分别代表星期一至星期天(数字)。
    /// - Returns: 某月周数
    public class func getWeeksOfMonth(year: Int, month: Int, start: Int) -> Int32 {
        let getWeeksOfMonth = LunarManager.stand.solarUtilJsValue?.invokeMethod("getWeeksOfMonth", withArguments: [year, month, start])
        return getWeeksOfMonth?.toInt32() ?? 0
    }
    
    /// 获取某天位于当年第几天
    /// - Parameters:
    ///   - year: 阳历年(数字)。
    ///   - month: 阳历月(数字)。
    ///   - day: 阳历日(数字)。
    /// - Returns: 某天位于当年第几天
    public class func getDaysInYear(year: Int, month: Int, day: Int) -> Int32 {
        let getDaysInYear = LunarManager.stand.solarUtilJsValue?.invokeMethod("getDaysInYear", withArguments: [year, month, day])
        return getDaysInYear?.toInt32() ?? 0
    }

}
