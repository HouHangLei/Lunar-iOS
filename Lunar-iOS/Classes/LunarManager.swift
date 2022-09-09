//
//  LunarManager.swift
//  Lunar-iOS
//
//  Created by HL on 2022/9/2.
//

import UIKit
import JavaScriptCore

@objcMembers public class LunarManager: NSObject {
    
    public static let stand = LunarManager()
    
    public let jsContext = JSContext()

    // 阴历
    public lazy var lunarJsValue: JSValue? = {
        let value = self.jsContext?.objectForKeyedSubscript("Lunar")
        return value
    }()
    
    // 阴历年
    public lazy var lunarYearJsValue: JSValue? = {
        let value = self.jsContext?.objectForKeyedSubscript("LunarYear")
        return value
    }()

    // 阴历月
    public lazy var lunarMonthJsValue: JSValue? = {
        let value = self.jsContext?.objectForKeyedSubscript("LunarMonth")
        return value
    }()
    
    // 阴历时辰
    public lazy var lunarTimeJsValue: JSValue? = {
        let value = self.jsContext?.objectForKeyedSubscript("LunarTime")
        return value
    }()

    // 阴历工具
    public lazy var lunarUtilJsValue: JSValue? = {
        let value = self.jsContext?.objectForKeyedSubscript("LunarUtil")
        return value
    }()

    // 阳历
    public lazy var solarJsValue: JSValue? = {
        let value = self.jsContext?.objectForKeyedSubscript("Solar")
        return value
    }()

    // 阳历周
    public lazy var solarWeekJsValue: JSValue? = {
        let value = self.jsContext?.objectForKeyedSubscript("SolarWeek")
        return value
    }()

    // 阳历月
    public lazy var solarMonthJsValue: JSValue? = {
        let value = self.jsContext?.objectForKeyedSubscript("SolarMonth")
        return value
    }()

    // 阳历季度
    public lazy var solarSeasonJsValue: JSValue? = {
        let value = self.jsContext?.objectForKeyedSubscript("SolarSeason")
        return value
    }()
    
    // 阳历半年
    public lazy var solarHalfYearJsValue: JSValue? = {
        let value = self.jsContext?.objectForKeyedSubscript("SolarHalfYear")
        return value
    }()
    
    // 阳历年
    public lazy var solarYearJsValue: JSValue? = {
        let value = self.jsContext?.objectForKeyedSubscript("SolarYear")
        return value
    }()
    
    // 阳历工具
    public lazy var solarUtilJsValue: JSValue? = {
        let value = self.jsContext?.objectForKeyedSubscript("SolarUtil")
        return value
    }()
    
    // 佛历
    public lazy var fotoJsValue: JSValue? = {
        let value = self.jsContext?.objectForKeyedSubscript("Foto")
        return value
    }()

    // 道历
    public lazy var taoJsValue: JSValue? = {
        let value = self.jsContext?.objectForKeyedSubscript("Tao")
        return value
    }()

    // 法定假日
    public lazy var holidayUtilJsValue: JSValue? = {
        let value = self.jsContext?.objectForKeyedSubscript("HolidayUtil")
        return value
    }()

    private override init() {
        let lunarBundle = Bundle.moduleBundle ?? Bundle(for: LunarManager.self)
        guard let bundlePath = lunarBundle.path(forResource: "Resources", ofType: "bundle") else {
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
