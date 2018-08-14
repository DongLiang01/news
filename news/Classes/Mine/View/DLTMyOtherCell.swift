//
//  DLTMyOtherCell.swift
//  news
//
//  Created by dongliang on 2018/7/26.
//  Copyright © 2018年 dl. All rights reserved.
//

import UIKit

class DLTMyOtherCell: UITableViewCell, RegisterCellOrNib {

    ///标题
    @IBOutlet weak var leftLabel: UILabel!
    ///副标题
    @IBOutlet weak var rightLabel: UILabel!
    ///右边箭头
    @IBOutlet weak var rightImageView: UIImageView!
    ///分割线
    @IBOutlet weak var separatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //设置主题颜色
        leftLabel.theme_textColor = "colors.black"
        rightLabel.theme_textColor = "colors.cellRightTextColor"
        rightImageView.theme_image = "images.cellRightArrow"
        separatorView.theme_backgroundColor = "colors.separatorViewColor"
        theme_backgroundColor = "colors.cellBackgroundColor"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
