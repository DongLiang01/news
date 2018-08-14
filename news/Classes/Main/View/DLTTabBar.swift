//
//  DLTTabBar.swift
//  news
//
//  Created by dongliang on 2018/7/20.
//  Copyright © 2018年 dl. All rights reserved.
//

import UIKit

class DLTTabBar: UITabBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        theme_tintColor = "colors.tabbarTintColor"
        theme_barTintColor = "colors.cellBackgroundColor"
        addSubview(publishBtn)
    }
    
    //private  绝对私有，出了代码域就不能被访问
    //filepricate 在同一个文件中可以被访问
    //open 在任何地方都能被访问
    private lazy var publishBtn: UIButton = {
        let publishBtn = UIButton(type: .custom)
        publishBtn.theme_setBackgroundImage("images.publishButtonBackgroundImage", forState: .normal)
        publishBtn.theme_setBackgroundImage("images.publishButtonBackgroundSlectedImage", forState: .selected)
        publishBtn.sizeToFit()
        return publishBtn
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let height: CGFloat = 49
        publishBtn.center = CGPoint(x: frame.width * 0.5, y: height * 0.5 - 7)
        print("测试%f",frame.height)
        let btnW : CGFloat = frame.width * 0.2
        let btnH : CGFloat = height
        let btnY : CGFloat = 0
        
        //其他按钮的位置也要改变
        var index = 0
        for button in subviews {
            if !button.isKind(of: NSClassFromString("UITabBarButton")!) { continue }
            let btnX = btnW * (index > 1 ? CGFloat(index+1) : CGFloat(index))
            button.frame = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
            index += 1
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
