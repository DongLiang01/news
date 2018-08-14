//
//  DLTMyLoginViewController.swift
//  news
//
//  Created by dongliang on 2018/8/6.
//  Copyright © 2018年 dl. All rights reserved.
//

import UIKit
import IBAnimatable

class DLTMyLoginViewController: AnimatableModalViewController {
    ///顶部标题
    @IBOutlet weak var topLabel: UILabel!
    ///手机号view
    @IBOutlet weak var mobileView: AnimatableView!
    ///发送验证码view
    @IBOutlet weak var sendeVerifyView: UIView!
    ///发送验证码button
    @IBOutlet weak var sendVerrifyButton: UIButton!
    ///手机号输入框
    @IBOutlet weak var mobileTextField: UITextField!
    ///验证码view
    @IBOutlet weak var passwordView: AnimatableView!
    ///找回密码view
    @IBOutlet weak var findPasswordView: UIView!
    ///找回密码button
    @IBOutlet weak var findPasswordButton: UIButton!
    ///密码输入框
    @IBOutlet weak var passwordTextField: UITextField!
    ///未注册的提示label
    @IBOutlet weak var middleTipLabel: UILabel!
    ///进入头条
    @IBOutlet weak var enterToutiaoButton: AnimatableButton!
    ///阅读协议label
    @IBOutlet weak var readLabel: UILabel!
    ///阅读按钮
    @IBOutlet weak var readButton: UIButton!
    ///账号密码登录按钮
    @IBOutlet weak var loginModeButton: UIButton!
    ///页面关闭按钮
    @IBOutlet weak var loginCloseButton: UIButton!
    
    @IBOutlet weak var wechatButton: UIButton!
    @IBOutlet weak var qqButton: UIButton!
    @IBOutlet weak var tianyiButton: UIButton!
    @IBOutlet weak var mailButton: UIButton!
    
    @IBAction func loginModeButtonClick(_ sender: UIButton) {
        loginModeButton.isSelected = !sender.isSelected
        
        sendeVerifyView.isHidden = sender.isSelected
        findPasswordView.isHidden = !sender.isSelected
        middleTipLabel.isHidden = sender.isSelected
        passwordTextField.placeholder = sender.isSelected ? "请输入密码" : "请输入验证码"
        topLabel.text = sender.isSelected ? "账号密码登录" : "登录你的头条，精彩永不消失"
    }
    

    @IBAction func readButtonClick(_ sender: UIButton) {
        readButton.isSelected = !sender.isSelected
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginModeButton.setTitle("免密码登录", for: .selected)
        
        view.theme_backgroundColor = "colors.cellBackgroundColor"
        topLabel.theme_textColor = "colors.black"
        middleTipLabel.theme_textColor = "colors.cellRightTextColor"
        readLabel.theme_textColor = "colors.black"
        enterToutiaoButton.theme_backgroundColor = "colors.enterTouTiaoBackgroundColor"
        enterToutiaoButton.theme_setTitleColor("colors.enterTouTiaoTextColor", forState: .normal)
        readButton.isSelected = true
        readButton.theme_setImage("images.loginReadButton", forState: .normal)
        readButton.theme_setImage("images.loginReadButtonSelected", forState: .selected)
        mobileView.theme_backgroundColor = "colors.loginMobileViewBackgroundColor"
        passwordView.theme_backgroundColor = "colors.loginMobileViewBackgroundColor"
        loginCloseButton.theme_setImage("images.loginCloseButtonImage", forState: .normal)
        wechatButton.theme_setImage("images.moreLoginWechatButton", forState: .normal)
        qqButton.theme_setImage("images.moreLoginQQButton", forState: .normal)
        tianyiButton.theme_setImage("images.moreLoginTianyiButton", forState: .normal)
        mailButton.theme_setImage("images.moreLoginMailButton", forState: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(_ sender: UIButton) {
       dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
