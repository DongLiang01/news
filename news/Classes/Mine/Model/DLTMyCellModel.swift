//
//  DLTMyCellModel.swift
//  news
//
//  Created by dongliang on 2018/7/25.
//  Copyright © 2018年 dl. All rights reserved.
//

import Foundation
import HandyJSON    //直接将json字符串转换成model

struct MyCellModel : HandyJSON{
    var tip_new : Int = 0
    var grey_text : String = ""
    var text : String = ""
    var key : String = ""
    var url : String = ""
}

///关注的模型，因为关注返回的数据不统一，有时候会没有下面某些值，所以创建模型的时候最好将值设置为可选类型
struct MyConcern : HandyJSON{
    var name : String?
    var url : String?
    var total_count : Int?
    var description : String?
    var time : String?
    var type : String?
    var icon : String?
    var userid : Int?
    var is_verify : Bool?
    var media_id : Int?
    var tips : Bool?
    var id : Int?
    var user_auth_info : String?   //返回的是一个字符串，但是字符串中又是一个字典
    var userAuth : UserAuthInfo? {
        return UserAuthInfo.deserialize(from: user_auth_info)
    }
    
}

struct UserAuthInfo : HandyJSON {
    var auth_type : Int?
    var auth_info : Int?
}

