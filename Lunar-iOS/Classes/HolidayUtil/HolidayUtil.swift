//
//  HolidayUtil.swift
//  Lunar-iOS
//
//  Created by HL on 2022/9/6.
//

import UIKit
import JavaScriptCore

public class HolidayUtil: NSObject {
    
    //MARK: - 指定日期是否放假或调休
    // https://6tail.cn/calendar/api.html#holiday-util.ymd.html
    
    /// 指定日期是否放假或调休(如果当天不是节假日或调休，返回空)
    /// - Parameters:
    ///   - year: 年
    ///   - month: 月
    ///   - day: 日
    /// - Returns: 假日对象
    @objc public class func getHoliday(year: Int, month: Int, day: Int) -> Holiday? {
        let holiday = LunarManager.stand.holidayUtilJsValue?.invokeMethod("getHoliday", withArguments: [year, month, day])
        return getHoliday(jsValue: holiday)
    }
    
    /// 指定日期是否放假或调休(如果当天不是节假日或调休，返回空)
    /// - Parameter ymd: 格式为YYYY-MM-dd日期字符串
    /// - Returns: 假日对象
    @objc public class func getHoliday(ymd: String) -> Holiday? {
        let holiday = LunarManager.stand.holidayUtilJsValue?.invokeMethod("getHoliday", withArguments: [ymd])
        return getHoliday(jsValue: holiday)
    }

    private class func getHoliday(jsValue: JSValue?) -> Holiday? {
        if jsValue?.isNull == true {
            return nil
        }
        let getDay = jsValue?.invokeMethod("getDay", withArguments: nil).toString()
        let isWork = jsValue?.invokeMethod("isWork", withArguments: nil).toBool() ?? false
        let getName = jsValue?.invokeMethod("getName", withArguments: nil).toString()
        let getTarget = jsValue?.invokeMethod("getTarget", withArguments: nil).toString()
        return Holiday(day: getDay, work: isWork, name: getName, target: getTarget)
    }
    
    //MARK: - 获取指定月份的假期列表
    // https://6tail.cn/calendar/api.html#holiday-util.month.html
    
    /// 获取指定月份的假期列表
    /// - Parameters:
    ///   - year: 年
    ///   - month: 月
    /// - Returns: 假日对象
    @objc public class func getHolidays(year: Int, month: Int) -> String? {
        let holidays = LunarManager.stand.holidayUtilJsValue?.invokeMethod("getHolidays", withArguments: [year, month])
        return holidays?.toString()
    }
    
    /// 获取指定月份的假期列表/获取指定年份的假期列表
    /// - Parameter ymd: 格式为YYYY-MM日期字符串（指定月份的）
    /// - Parameter ymd: 格式为YYYY日期字符串（指定年份）
    /// - Returns: 假日对象
    @objc public class func getHolidays(ymd: String) -> String? {
        let holidays = LunarManager.stand.holidayUtilJsValue?.invokeMethod("getHolidays", withArguments: [ymd])
        return holidays?.toString()
    }
    
    //MARK: - 获取指定年份的假期列表
    // https://6tail.cn/calendar/api.html#holiday-util.year.html
    
    /// 获取指定月份的假期列表
    /// - Parameters:
    ///   - year: 年
    /// - Returns: 假日对象
    @objc public class func getHolidays(year: Int) -> String? {
        let holidays = LunarManager.stand.holidayUtilJsValue?.invokeMethod("getHolidays", withArguments: [year])
        return holidays?.toString()
    }

    //MARK: - 获取节日相关的假期列表
    // https://6tail.cn/calendar/api.html#holiday-util.target.html
    
    /// 获取节日相关的假期列表
    /// - Parameters:
    ///   - year: 年
    ///   - month: 月
    ///   - day: 天
    /// - Returns: 假日对象
    @objc public class func getHolidays(year: Int, month: Int, day: Int) -> String? {
        let getHolidaysByTarget = LunarManager.stand.holidayUtilJsValue?.invokeMethod("getHolidaysByTarget", withArguments: [year, month, day])
        return getHolidaysByTarget?.toString()
    }

    /// 获取节日相关的假期列表
    /// - Parameters:
    ///   - ymd: 格式为YYYY-MM-DD的日期字符串
    /// - Returns:
    @objc public class func getHolidaysByTarget(ymd: String) -> String? {
        let getHolidaysByTarget = LunarManager.stand.holidayUtilJsValue?.invokeMethod("getHolidaysByTarget", withArguments: [ymd])
        return getHolidaysByTarget?.toString()
    }

}
