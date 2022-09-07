//
//  JieQi.swift
//  Lunar-iOS
//
//  Created by HL on 2022/9/6.
//
// 节气

import UIKit
import JavaScriptCore

public class JieQi: NSObject {
    
    public var jieQi: JSValue?

    /// 使用JSValue初始化
    /// - Parameter jsValue: JSValue
    @objc public init(jsValue: JSValue) {
        self.jieQi = jsValue
    }
    
}

extension JieQi {
    
    /// 获取名称
    /// - Returns:
    @objc public func getName() -> String? {
        let getName = jieQi?.invokeMethod("getName", withArguments: nil)
        return getName?.toString()
    }

    /// 获取阳历对象
    /// - Returns: 阳历对象
    @objc public func getSolar() -> Solar? {
        let getSolar = jieQi?.invokeMethod("getSolar", withArguments: nil)
        guard let getSolar = getSolar else {
            return nil
        }
        return Solar(jsValue: getSolar)
    }

    /// 是否节令
    /// - Returns:
    @objc public func isJie() -> Bool {
        let isJie = jieQi?.invokeMethod("isJie", withArguments: nil)
        return isJie?.toBool() ?? false
    }

    /// 是否气令
    /// - Returns:
    @objc public func isQi() -> Bool {
        let isQi = jieQi?.invokeMethod("isQi", withArguments: nil)
        return isQi?.toBool() ?? false
    }

}
