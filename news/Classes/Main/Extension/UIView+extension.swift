//
//  UIView+extension.swift
//  news
//
//  Created by dongliang on 2018/7/26.
//  Copyright © 2018年 dl. All rights reserved.
//

import UIKit

protocol RegisterCellOrNib {}

extension RegisterCellOrNib {
    static var identifier: String {
        return "\(self)"
    }
    static var nib: UINib? {
        return UINib(nibName: "\(self)", bundle: nil)
    }
    
}
