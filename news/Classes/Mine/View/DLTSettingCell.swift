//
//  DLTSettingCell.swift
//  news
//
//  Created by dongliang on 2018/8/8.
//  Copyright © 2018年 dl. All rights reserved.
//

import UIKit

class DLTSettingCell: UITableViewCell, RegisterCellOrNib {
    
    var settingModel: SettingModel? {
        didSet{
            titleLabel.text = settingModel!.title
            subtitleLabel.text = settingModel!.subtitle
            rightLabel.text = settingModel!.rightTitle
            rightArrowImageView.isHidden = settingModel!.isHiddenRightArraw
            switchView.isHidden = settingModel!.isHiddenSwitch
            if !settingModel!.isHiddenSubtitle {
                subtitleLabelHeight.constant = 20
                layoutIfNeeded()
            }
        }
    }
    
    @IBOutlet weak var subtitleLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var rightArrowImageView: UIImageView!
    @IBOutlet weak var switchView: UISwitch!
    @IBOutlet weak var bottomLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel.theme_textColor = "colors.black"
        rightLabel.theme_textColor = "colors.cellRightTextColor"
        rightArrowImageView.theme_image = "images.cellRightArrow"
        bottomLine.theme_backgroundColor = "colors.separatorViewColor"
        theme_backgroundColor = "colors.cellBackgroundColor"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
