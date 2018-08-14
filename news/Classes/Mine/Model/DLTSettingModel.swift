//
//  DLTSettingModel.swift
//  news
//
//  Created by dongliang on 2018/8/8.
//  Copyright © 2018年 dl. All rights reserved.
//

import Foundation
import HandyJSON

struct SettingModel: HandyJSON {
    var title = ""
    var subtitle = ""
    var rightTitle = ""
    var isHiddenSubtitle: Bool = false
    var isHiddenRightTitle: Bool = false
    var isHiddenRightArraw: Bool = false
    var isHiddenSwitch: Bool = false    
}
