//
//  DLTMyConcernCollectionCell.swift
//  news
//
//  Created by dongliang on 2018/7/27.
//  Copyright © 2018年 dl. All rights reserved.
//

import UIKit
import Kingfisher

class DLTMyConcernCollectionCell: UICollectionViewCell, RegisterCellOrNib {
    
    ///用户头像
    @IBOutlet weak var avatarImageView: UIImageView!
    ///vip标识
     @IBOutlet weak var vipImageView: UIImageView!
    //用户名字
    @IBOutlet weak var nameLabel: UILabel!
    //新消息通知
    @IBOutlet weak var tipsButton: UIButton!
    var myConcern: MyConcern? {
        didSet{
            print("头像地址",myConcern?.icon ?? "地址不存在")
            avatarImageView.kf.setImage(with: URL(string: (myConcern?.icon)!))
            nameLabel.text = myConcern?.name
            //判断是不是vip
            if let isVerify = myConcern?.is_verify {
                vipImageView.isHidden = !isVerify
            }
            if let tips = myConcern?.tips {
                tipsButton.isHidden = !tips
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        theme_backgroundColor = "colors.cellBackgroundColor"
        nameLabel.theme_textColor = "colors.black"
        
        tipsButton.layer.borderWidth = 1
        tipsButton.layer.borderColor = UIColor.white.cgColor
        
    }

}
