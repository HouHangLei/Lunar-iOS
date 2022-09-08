//
//  ViewController.swift
//  SPMTestExample
//
//  Created by HL on 2022/9/8.
//

import UIKit
import Lunar_iOS

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let lunar = Lunar(year: 2022, month: 10, day: 1)
        let jieqi = lunar.getJieQi()
        print("\(jieqi)")
    }


}

