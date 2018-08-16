//
//  DLTOfflineDownLoadCell.swift
//  news
//
//  Created by dongliang on 2018/8/15.
//  Copyright © 2018年 dl. All rights reserved.
//

import UIKit

class DLTOfflineDownLoadCell: UITableViewCell,RegisterCellOrNib {

    ///标题
    @IBOutlet weak var titleLabel: UILabel!
    ///勾选图片
    @IBOutlet weak var rightImageView: UIImageView!
    
    var dataModel:DLTHomeNewsTitle?
    var model:DLTHomeNewsTitle? {
//        set{
//            dataModel = newValue
//            print((dataModel?.name)! + "\(dataModel?.flags ?? 3)")
//            titleLabel.text = model?.name
//            if model?.flags == 0 {
//                rightImageView.theme_image = "images.offlineDownLoadTip"
//            }else{
//                rightImageView.theme_image = "images.offlineDownLoadTipChoose"
//            }
//        }
//        get{
//            return dataModel
//        }
        didSet{
            titleLabel.text = model?.name
            if model?.flags == 0 {
                rightImageView.theme_image = "images.offlineDownLoadTip"
            }else{
                rightImageView.theme_image = "images.offlineDownLoadTipChoose"
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        theme_backgroundColor = "colors.cellBackgroundColor"
        titleLabel.theme_textColor = "colors.black"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
