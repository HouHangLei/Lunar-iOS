//
//  Fu.swift
//  Lunar-iOS
//
//  Created by HL on 2022/9/6.
//

import UIKit
import JavaScriptCore

public class Fu: NSObject {
    
    public var fu: JSValue?

    /// 使用JSValue初始化
    /// - Parameter jsValue: JSValue
    @objc public init(jsValue: JSValue) {
        self.fu = jsValue
    }
    
}

extension Fu {
    
    /// 获取数九名称
    /// - Returns: 例：一九、二九、三九等
    @objc public func getName() -> String? {
        let getName = fu?.invokeMethod("getName", withArguments: nil)
        return getName?.toString()
    }

    /// 获取当天位于当前数九的第几天
    /// - Returns: 数字1-9
    @objc public func getIndex() -> Int32 {
        let getIndex = fu?.invokeMethod("getIndex", withArguments: nil)
        return getIndex?.toInt32() ?? 1
    }

}
