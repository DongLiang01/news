//
//  DLTHomeViewController.swift
//  news
//
//  Created by dongliang on 2018/7/20.
//  Copyright © 2018年 dl. All rights reserved.
//

import UIKit

class DLTHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        countWord(str: "welcome  to")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func countWord(str: String) -> () {
        var flag : Bool = false
        var num : Int = 0
        for char in str {
            if String(char) == " " {
                flag = false
            }else if flag == false {
                flag = true
                num += 1
            }
        }
        print("单词个数\(num)---长度\(str.count)")
    }

}
