//
//  NetWorkTool.swift
//  news
//
//  Created by dongliang on 2018/7/23.
//  Copyright © 2018年 dl. All rights reserved.
//

import Foundation
import Alamofire   ///Alamofire默认的是get请求
import SwiftyJSON

protocol NetWorkToolProtocol {
    ///测试
    ///等会要删除
    //------------------------------ 首页home ----------------------------------------
    ///首页顶部新闻标题数据
    static func loadHomeNewsTitleData(completionHandler: @escaping (_ newsTitles: [DLTHomeNewsTitle]) -> ())
    //------------------------------ 我的mine ----------------------------------------
    ///我的界面中cell的数据
    static func loadMyCellData(completionHandler: @escaping (_ sections: [[MyCellModel]]) -> ())
    ///我的关注数据
    static func loadMyConcern(completionHandler:@escaping (_ sections: [MyConcern]) -> ())
}

extension NetWorkToolProtocol {
    
    //------------------------------ 我的mine ----------------------------------------
    ///我的界面中cell的数据
    static func loadMyCellData(completionHandler:@escaping (_ sections: [[MyCellModel]]) -> ()){
        print("获取cell的数据")
        let url = BASE_URL + "/user/tab/tabs/?"
        let params = ["device_id" : device_id]
        Alamofire.request(url, parameters:params).responseJSON { (response) in
            guard response.result.isSuccess else {
                ///请求失败的提示信息
                print("请求失败了")
                return
            }
            print(response)
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else {
                    return
                }
                ///请求成功之后的操作
                if let data = json["data"].dictionary {
                    if let sections = data["sections"]?.array{
                        var sectionArray = [[MyCellModel]]()
                        for item in sections {
                            var rows = [MyCellModel]()
                            for row in item.arrayObject! {
                                let model = MyCellModel.deserialize(from: row as? Dictionary)
                                rows.append(model!)
                            }
                            sectionArray.append(rows)
                        }
                        //将数据通过闭包送出去
                        completionHandler(sectionArray)
                    }
                }
            }
        }
        
    }
    ///我的关注数据
    static func loadMyConcern(completionHandler:@escaping (_ sections: [MyConcern]) -> ()){
        print("获取我的关注的数据")
        let url = BASE_URL + "/concern/v2/follow/my_follow/?"
        let params = ["device_id" : device_id]
        Alamofire.request(url, parameters:params).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else {
                    return
                }
                if let data = json["data"].arrayObject {
                    var rows = [MyConcern]()
                    for item in data {
                        let model = MyConcern.deserialize(from: item as? Dictionary)
                        rows.append(model!)
                    }
                    completionHandler(rows)
                }
            }
        }
        
    }
    
    //------------------------------ 首页home ----------------------------------------
    ///首页顶部新闻标题数据
    static func loadHomeNewsTitleData(completionHandler: @escaping (_ newsTitles: [DLTHomeNewsTitle]) -> ()){
        let url = BASE_URL + "/article/category/get_subscribed/v1/?"
        let params = ["device_id" : device_id]
        Alamofire.request(url, parameters:params).responseJSON { (response) in
            guard response.result.isSuccess else{
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else {
                    return
                }
                if let data = json["data"].dictionary {
                    if let responseObject = data["data"]?.arrayObject {
                        var rowArray = [DLTHomeNewsTitle]()
                        for dic in responseObject {
                            let model = DLTHomeNewsTitle.deserialize(from: dic as? Dictionary)
                            rowArray.append(model!)
                        }
                        completionHandler(rowArray)
                    }
                }
            }
        }
    }
    
}

struct NetWorkTool: NetWorkToolProtocol {
 
}

