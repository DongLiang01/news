//
//  UIColor+Extension.swift
//  news
//
//  Created by dongliang on 2018/7/20.
//  Copyright © 2018年 dl. All rights reserved.
//

import UIKit   //因为UIkit中包含Foundation

extension UIColor {
    class func RGBA(_ r : CGFloat, _ g:CGFloat, _ b:CGFloat, _ a:CGFloat) -> UIColor {
        ///苹果官方说这个设置颜色的方法性能比较好
        let color = UIColor(displayP3Red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
        return color
    }
    
    class func RGB(_ r : CGFloat, _ g:CGFloat, _ b:CGFloat) -> UIColor {
        let color = RGBA(r, g, b, 1.0)
        return color
    }
    
    /// 背景灰色 f8f9f7
    class func globalBackgroundColor() -> UIColor {
        return UIColor.RGB(248, 249, 247)
    }
}

