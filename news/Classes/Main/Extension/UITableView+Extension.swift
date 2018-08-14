//
//  UITableView+Extension.swift
//  news
//
//  Created by dongliang on 2018/7/26.
//  Copyright © 2018年 dl. All rights reserved.
//

import UIKit

extension UITableView {
    ///注册cell的方法
    func dl_registerCell<T: UITableViewCell>(cell: T.Type) where T: RegisterCellOrNib {
        if let nib = T.nib {
            register(nib, forCellReuseIdentifier: T.identifier)
        }else{
            register(cell, forCellReuseIdentifier: T.identifier)
        }
    }
    ///从缓存池中获取已经存在的cell
    func dl_dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T: RegisterCellOrNib {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
}

