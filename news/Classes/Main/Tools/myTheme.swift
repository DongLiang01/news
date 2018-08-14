//
//  myTheme.swift
//  news
//
//  Created by dongliang on 2018/7/31.
//  Copyright © 2018年 dl. All rights reserved.
//

import Foundation
import SwiftTheme

enum myTheme : Int{
    case day = 0
    case night = 1
    static var before = myTheme.day
    static var current = myTheme.day
    static func switchTo(_ theme: myTheme){
        before = current
        current = theme
        switch theme {
           case .day:
               ThemeManager.setTheme(plistName: "default_theme", path: .mainBundle)
           case .night:
                ThemeManager.setTheme(plistName: "night_theme", path: .mainBundle)
        }
    }
    
    
    static func switchNight(_ isToNight: Bool) {
        switchTo(isToNight ? .night : .day)
    }
    
    //判断当前是不是夜间主题
    static func isNight() -> Bool {
        return current == .night
    }
}


