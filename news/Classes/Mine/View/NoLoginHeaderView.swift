//
//  NoLoginHeaderView.swift
//  news
//
//  Created by dongliang on 2018/7/27.
//  Copyright © 2018年 dl. All rights reserved.
//

import UIKit
import IBAnimatable
import SwiftTheme

class NoLoginHeaderView: UIView {

    ///背景图片
    @IBOutlet weak var bgImageView: UIImageView!
    //手机按钮
    @IBOutlet weak var mobileButton: UIButton!
    //微信按钮
    @IBOutlet weak var wechatButton: UIButton!
    //QQ按钮
    @IBOutlet weak var qqButton: UIButton!
    //新浪按钮
    @IBOutlet weak var sinaButton: UIButton!
    //更多登录方式按钮
    @IBOutlet weak var moreLoginButton: AnimatableButton!
    //收藏按钮
    @IBOutlet weak var favoriteButton: UIButton!
    //历史按钮
    @IBOutlet weak var historyButton: UIButton!
    //日渐/夜间按钮
    @IBOutlet weak var dayOrNightButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    class func headerView() -> NoLoginHeaderView {
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.last as! NoLoginHeaderView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //ThemeManager.setTheme(plistName: "default_theme", path: .mainBundle)
        
        dayOrNightButton.isSelected = UserDefaults.standard.bool(forKey: isNight)
        
        mobileButton.theme_setImage("images.loginMobileButton", forState: .normal)
        wechatButton.theme_setImage("images.loginWechatButton", forState: .normal)
        qqButton.theme_setImage("images.loginQQButton", forState: .normal)
        sinaButton.theme_setImage("images.loginSinaButton", forState: .normal)
        favoriteButton.theme_setImage("images.mineFavoriteButton", forState: .normal)
        historyButton.theme_setImage("images.mineHistoryButton", forState: .normal)
        dayOrNightButton.theme_setImage("images.dayOrNightButton", forState: .normal)
        dayOrNightButton.setTitle("夜间", for: .normal)
        dayOrNightButton.setTitle("日间", for: .selected)
        moreLoginButton.theme_backgroundColor = "colors.moreLoginBackgroundColor"
        moreLoginButton.theme_setTitleColor("colors.moreLoginTextColor", forState: .normal)
        favoriteButton.theme_setTitleColor("colors.black", forState: .normal)
        historyButton.theme_setTitleColor("colors.black", forState: .normal)
        dayOrNightButton.theme_setTitleColor("colors.black", forState: .normal)
        bottomView.theme_backgroundColor = "colors.cellBackgroundColor"
    }
    
    ///点击了日间、夜间按钮
    @IBAction func dayOrNightButtonClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        //保存夜间模式
        UserDefaults.standard.set(sender.isSelected, forKey: isNight)
        myTheme.switchNight(sender.isSelected)
        //发送通知，改变tabBar的状态
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"dayOrNightButtonClicked"), object: sender.isSelected)
    }
    
}
