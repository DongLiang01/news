//
//  SQLiteManager.swift
//  news
//
//  Created by dongliang on 2018/8/27.
//  Copyright © 2018年 dl. All rights reserved.
//

import Foundation
import SQLite

struct SQLiteManager {
    var datebase :Connection!
    init() {
        do {
            let path = NSHomeDirectory() + "/Documents/news.sqlite3"
            datebase = try Connection(path)
        } catch  {
            print(error)
        }
    }
}

/// 首页新闻分类的标题数据表
struct NewsTitleTable {
    
    /// 数据库管理者
    private let sqlManager = SQLiteManager()
    /// 新闻标题 表
    private let news_title = Table("news_title")
    
}

