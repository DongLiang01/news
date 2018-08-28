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
