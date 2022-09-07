//
//  StringExtension.swift
//  Lunar-iOS
//
//  Created by HL on 2022/9/4.
//

import Foundation

extension String {
    
    func l_isEmpty() -> Bool {
        if self == "" || self == "undefined" { return true }
        return false
    }
    
}
