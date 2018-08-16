//
//  DLTOfflineDownController.swift
//  news
//
//  Created by dongliang on 2018/8/15.
//  Copyright © 2018年 dl. All rights reserved.
//

import UIKit

class DLTOfflineDownController: UITableViewController {
    
    var dataArray = [DLTHomeNewsTitle]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dl_registerCell(cell: DLTOfflineDownLoadCell.self)
        tableView.theme_separatorColor = "colors.separatorViewColor"
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableView.theme_backgroundColor = "colors.tableViewBackgroundColor"
        NetWorkTool.loadHomeNewsTitleData { (response) in
            print("新闻标题",response)
            self.dataArray = response
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dl_dequeueReusableCell(indexPath: indexPath) as DLTOfflineDownLoadCell
        cell.selectionStyle = .none
        cell.model = dataArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! DLTOfflineDownLoadCell
        if cell.model?.flags == 0 {
            cell.rightImageView.theme_image = "images.offlineDownLoadTipChoose"
            dataArray[indexPath.row].flags = 1
        }else{
            cell.rightImageView.theme_image = "images.offlineDownLoadTip"
            dataArray[indexPath.row].flags = 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenW, height: 40))
        view.theme_backgroundColor = "colors.cellBackgroundColor"
        
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: screenW, height: 40))
        view.addSubview(label)
        label.text = "我的频道"
        label.theme_textColor = "colors.black"
        
        let separatorView = UIView(frame: CGRect(x: 0, y: 39, width: screenW, height: 1))
        view.addSubview(separatorView)
        separatorView.theme_backgroundColor = "colors.separatorViewColor"
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

}
