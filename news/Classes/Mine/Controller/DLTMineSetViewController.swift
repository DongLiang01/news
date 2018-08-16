//
//  DLTMineSetViewController.swift
//  news
//
//  Created by dongliang on 2018/8/8.
//  Copyright © 2018年 dl. All rights reserved.
//

import UIKit
import Kingfisher

class DLTMineSetViewController: UITableViewController {
    
    ///存储plist文件中的数据
    var sections = [[SettingModel]]()

    override func viewDidLoad() {
        super.viewDidLoad()

        if UserDefaults.standard.bool(forKey: isNight) {
            ///夜间模式
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.RGB(112, 112, 112)]
        }else{
            ///日间模式
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.RGB(0, 0, 0)]
        }
        ///设置UI
        setupUI()
        
        let str = calculateDiskCashSize { (sizeString) in
            print("缓存大小" + sizeString)
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dl_dequeueReusableCell(indexPath: indexPath) as DLTSettingCell
        cell.selectionStyle = .none
        cell.settingModel = sections[indexPath.section][indexPath.row]
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                ///计算缓存的大小
                calculateDiskCashSize(cacheSize: { (sizeString) in
                    cell.rightLabel.text = sizeString
                })
            default:
                break
            }
        default:
            break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! DLTSettingCell
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                ///清除缓存
                clearCacheAlertController {
                    cell.rightLabel.text = "0.0M"
                }
            case 1:
                ///设置字体大小
                setupFontAlertController { (fontSize) in
                    cell.rightLabel.text = fontSize
                    self.changeFontSize()
                }
            case 3:
                ///设置非wifi网络流量模式
                setupNetWorkAlertController { (netMode) in
                    cell.rightLabel.text = netMode
                }
            case 4:
                ///设置非WIFI网络播放提醒
                setupPlayNoticeAlertController { (playNotice) in
                    cell.rightLabel.text = playNotice
                }
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                let vc = DLTOfflineDownController()
                vc.navigationItem.title = "离线下载"
                navigationController?.pushViewController(vc, animated: true)
            default:
                break
            }
        default:
            break
        }
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: screenW, height: 10))
        view.theme_backgroundColor = "colors.tableViewBackgroundColor"
        return view
    }
}

extension DLTMineSetViewController{
    ///从沙盒中获取缓存的大小
    fileprivate func calculateDiskCashSize(cacheSize:@escaping (String)->Void){
        let cache = KingfisherManager.shared.cache
        cache.calculateDiskCacheSize { (size) in
            //传来的参数单位是字节，需要转换成M
            let sizeM = Double(size) / 1024.0 / 1024.0
            let sizeString = String(format: "%.2fM", sizeM)
            //这个闭包是没有返回值的，所以return肯定会报错
            //所以需要使用闭包来进行传值
            cacheSize(sizeString)
        }
    }
    
    ///弹出清理缓存的提示框
    fileprivate func clearCacheAlertController(clearCache:@escaping ()->()) {
        let alertController = UIAlertController(title: "确定清除所有缓存？问答草稿、离线下载及图片均会被清除", message: nil, preferredStyle: .actionSheet)
        let cacelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定", style: .default) { (_) in
            let cache = KingfisherManager.shared.cache
            cache.clearDiskCache()
            cache.clearMemoryCache()
            cache.cleanExpiredDiskCache()
            clearCache()
        }
        alertController.addAction(cacelAction)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    ///设置字体的弹窗
    fileprivate func setupFontAlertController(fontSize:@escaping (String)->()){
        let alertController = UIAlertController(title: "设置字体大小", message: nil, preferredStyle: .actionSheet)
        let cacelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let smallAction = UIAlertAction(title: "小", style: .default) { (_) in
            fontSize("小")
        }
        let middleAction = UIAlertAction(title: "中", style: .default) { (_) in
            fontSize("中")
        }
        let bigAction = UIAlertAction(title: "大", style: .default) { (_) in
            fontSize("大")
        }
        let largeAction = UIAlertAction(title: "特大", style: .default) { (_) in
            fontSize("特大")
        }
        alertController.addAction(cacelAction)
        alertController.addAction(largeAction)
        alertController.addAction(bigAction)
        alertController.addAction(middleAction)
        alertController.addAction(smallAction)
        present(alertController, animated: true, completion: nil)
    }
    
    ///改变字体大小
   fileprivate func changeFontSize() {
        print("改变系统字体大小")
    }
    
    ///设置非wifi网络流量
    fileprivate func setupNetWorkAlertController(netMode: @escaping (String)->()) {
        let alertController = UIAlertController(title: "非WIFI网络流量", message: nil, preferredStyle: .actionSheet)
        let cacelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let bestAction = UIAlertAction(title: "最佳效果（下载大图）", style: .default) { (_) in
            netMode("最佳效果（下载大图）")
        }
        let betterAction = UIAlertAction(title: "较省流量（智能下图）", style: .default) { (_) in
            netMode("较省流量（智能下图）")
        }
        let leastAction = UIAlertAction(title: "极省流量（智能下图）", style: .default) { (_) in
            netMode("极省流量（智能下图）")
        }
        alertController.addAction(cacelAction)
        alertController.addAction(leastAction)
        alertController.addAction(betterAction)
        alertController.addAction(bestAction)
        present(alertController, animated: true, completion: nil)
    }
    ///设置非wifi网络播放提醒
    ///测试东西
    fileprivate func setupPlayNoticeAlertController(playNotice: @escaping (String)->()) {
        let alertController = UIAlertController(title: "非WIFI网络播放提醒", message: nil, preferredStyle: .actionSheet)
        let cacelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let everyAction = UIAlertAction(title: "每次提醒", style: .default) { (_) in
            playNotice("每次提醒")
        }
        let onceAction = UIAlertAction(title: "提醒一次", style: .default) { (_) in
            playNotice("提醒一次")
        }
        alertController.addAction(cacelAction)
        alertController.addAction(everyAction)
        alertController.addAction(onceAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension DLTMineSetViewController {
    
    ///设置UI
    fileprivate func setupUI() {
        ///plist文件的路径
        let path = Bundle.main.path(forResource: "settingPlist", ofType: "plist")
        let cellPlist = NSArray(contentsOfFile: path!) as! [Any]
        for dicts in cellPlist {
            let array = dicts as! [[String: Any]]
            var rows = [SettingModel]()
            for dict in array {
                let model = SettingModel.deserialize(from: dict)
                rows.append(model!)
            }
            sections.append(rows)
        }
        
        tableView.dl_registerCell(cell: DLTSettingCell.self)
        tableView.rowHeight = 44
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        tableView.theme_backgroundColor = "colors.tableViewBackgroundColor"
    }
}
