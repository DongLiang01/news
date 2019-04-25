//
//  DLTRootTabBarController.swift
//  news
//
//  Created by dongliang on 2018/7/20.
//  Copyright © 2018年 dl. All rights reserved.
//

import UIKit

class DLTRootTabBarController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(tabBar.subviews)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let tabbar = UITabBar.appearance()
        tabbar.tintColor = UIColor(red: 245/255.0, green: 90/255.0, blue: 93/255.0, alpha: 1)
        
        addChidControllers()
        
        NotificationCenter.default.addObserver(self, selector: #selector(receiveDayOrNightButtonClicked(notification:)), name: NSNotification.Name(rawValue: "dayOrNightButtonClicked"), object: nil)
    }
    
    @objc func receiveDayOrNightButtonClicked(notification:Notification) -> () {
        let selected = notification.object as! Bool
        if selected {
            //设置夜间
            for childViewController in childViewControllers {
                switch childViewController.tabBarItem.title {
                    case "首页":
                         setNightChildController(controller: childViewController, imageName: "home")
                    case "西瓜视频":
                          setNightChildController(controller: childViewController, imageName: "video")
                    case "小视频":
                          setNightChildController(controller: childViewController, imageName: "huoshan")
                    case "未登录":
                          setNightChildController(controller: childViewController, imageName: "no_login")
                    case "我的":
                          setNightChildController(controller: childViewController, imageName: "mine")
                default:
                    break
                }
            }
        }else{
            //设置日间
            for childViewController in childViewControllers {
                switch childViewController.tabBarItem.title {
                case "首页":
                    setDayChildController(controller: childViewController, imageName: "home")
                case "西瓜视频":
                    setDayChildController(controller: childViewController, imageName: "video")
                case "小视频":
                    setDayChildController(controller: childViewController, imageName: "huoshan")
                case "未登录":
                    setDayChildController(controller: childViewController, imageName: "no_login")
                case "我的":
                    setDayChildController(controller: childViewController, imageName: "mine")
                default:
                    break
                }
            }
        }
    }
    
    ///设置夜间控制器
    func setNightChildController(controller: UIViewController, imageName: String) {
        controller.tabBarItem.image = UIImage(named: imageName + "_tabbar_night_32x32_")
        controller.tabBarItem.selectedImage = UIImage(named: imageName + "_tabbar_press_night_32x32_")
    }
    ///设置日间控制器
    func setDayChildController(controller: UIViewController, imageName:String) {
        controller.tabBarItem.image = UIImage(named: imageName + "_tabbar_32x32_")
        controller.tabBarItem.selectedImage = UIImage(named: imageName + "_tabbar_press_32x32_")
    }
    
    func addChidControllers() -> () {
        setChidViewController(DLTHomeViewController(), title: "首页", imageName: "home")
        setChidViewController(DLTVideoViewController(), title: "西瓜视频", imageName: "video")
       setChidViewController(DLTHuoShanViewController(), title: "小视频", imageName: "huoshan")
        setChidViewController(DLTMineViewController(), title: "未登录", imageName: "no_login")
        
        //tabBar是只读属性，不能直接设置，所以使用KVC对其进行设置
        setValue(DLTTabBar(frame: CGRect.zero), forKey: "tabBar")
    }
    
    func setChidViewController(_ childController:UIViewController, title:String, imageName:String) {
        childController.tabBarItem.title = title
        if UserDefaults.standard.bool(forKey: isNight) {
            setNightChildController(controller: childController, imageName: imageName)
        }else{
            setDayChildController(controller: childController, imageName: imageName)
        }
        childController.navigationItem.title = title
        let nav = DLTRootNavgationController(rootViewController: childController)
        addChildViewController(nav)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("点击了" + item.title!)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
