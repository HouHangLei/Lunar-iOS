//
//  LunarManager.swift
//  Lunar-iOS
//
//  Created by HL on 2022/9/2.
//

import UIKit
import JavaScriptCore

///*
// 指定阴历年(数字)、阴历月(数字)、阴历日(数字)生成阴历对象。注意月份为1到12，闰月为负，即闰2月=-2。
// 例：[2022, 9, 2] 2022年九月初二
// **/
//public typealias yMdArray = [Int] // oc使用数组传入年月日
//public typealias yMd = (year: Int, month: Int, day: Int)
//
///*
// 指定阴历年(数字)、阴历月(数字)、阴历日(数字)、阳历小时(数字)、阳历分钟(数字)、阳历秒钟(数字)生成阴历对象。注意月份为1到12，闰月为负，即闰2月=-2。
// 例：[2022, 9, 2, 17, 21, 30] 2022年九月初二17时21分30秒
// **/
//public typealias yMdHmsArray = [Int] // oc使用数组传入年月日时分秒
//public typealias yMdHms = (year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int)

@objcMembers public class LunarManager {
    
    static let stand = LunarManager()
    
    public let jsContext = JSContext()

    // 阴历
    lazy var lunarJsValue: JSValue? = {
        let value = self.jsContext?.objectForKeyedSubscript("Lunar")
        return value
    }()
    
    // 阴历年
    lazy var lunarYearJsValue: JSValue? = {
        let value = self.jsContext?.objectForKeyedSubscript("LunarYear")
        return value
    }()

    // 阴历月
    lazy var lunarMonthJsValue: JSValue? = {
        let value = self.jsContext?.objectForKeyedSubscript("LunarMonth")
        return value
    }()
    
    // 阴历时辰
    lazy var lunarTimeJsValue: JSValue? = {
        let value = self.jsContext?.objectForKeyedSubscript("LunarTime")
        return value
    }()

    // 阴历工具
    lazy var lunarUtilJsValue: JSValue? = {
        let value = self.jsContext?.objectForKeyedSubscript("LunarUtil")
        return value
    }()

    // 阳历
    lazy var solarJsValue: JSValue? = {
        let value = self.jsContext?.objectForKeyedSubscript("Solar")
        return value
    }()

    // 阳历周
    lazy var solarWeekJsValue: JSValue? = {
        let value = self.jsContext?.objectForKeyedSubscript("SolarWeek")
        return value
    }()

    // 阳历月
    lazy var solarMonthJsValue: JSValue? = {
        let value = self.jsContext?.objectForKeyedSubscript("SolarMonth")
        return value
    }()

    // 阳历季度
    lazy var solarSeasonJsValue: JSValue? = {
        let value = self.jsContext?.objectForKeyedSubscript("SolarSeason")
        return value
    }()
    
    // 阳历半年
    lazy var solarHalfYearJsValue: JSValue? = {
        let value = self.jsContext?.objectForKeyedSubscript("SolarHalfYear")
        return value
    }()
    
    // 阳历年
    lazy var solarYearJsValue: JSValue? = {
        let value = self.jsContext?.objectForKeyedSubscript("SolarYear")
        return value
    }()
    
    // 阳历工具
    lazy var solarUtilJsValue: JSValue? = {
        let value = self.jsContext?.objectForKeyedSubscript("SolarUtil")
        return value
    }()
    
    // 佛历
    lazy var fotoJsValue: JSValue? = {
        let value = self.jsContext?.objectForKeyedSubscript("Foto")
        return value
    }()

    // 道历
    lazy var taoJsValue: JSValue? = {
        let value = self.jsContext?.objectForKeyedSubscript("Tao")
        return value
    }()

    // 法定假日
    lazy var holidayUtilJsValue: JSValue? = {
        let value = self.jsContext?.objectForKeyedSubscript("HolidayUtil")
        return value
    }()

    private init() {
#if SWIFT_PACKAGE
        let lunarBundle = SWIFTPM_MODULE_BUNDLE
#else
        let lunarBundle = Bundle(for: LunarManager.self)
#endif
        guard let bundlePath = lunarBundle.path(forResource: "Lunar-iOS", ofType: "bundle") else {
            return
        }
        let resourceBundle = Bundle(path: bundlePath)
        guard let path = resourceBundle!.path(forResource: "lunar", ofType: "js") else {
            return
        }
        guard let lunarJS = try? String(contentsOfFile: path, encoding: .utf8) else {
            return
        }
        self.jsContext?.evaluateScript(lunarJS)
    }
}
