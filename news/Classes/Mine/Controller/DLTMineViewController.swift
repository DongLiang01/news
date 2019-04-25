//
//  DLTMineViewController.swift
//  news
//
//  Created by dongliang on 2018/7/20.
//  Copyright © 2018年 dl. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class DLTMineViewController: UITableViewController {
    
    fileprivate let disposeBag = DisposeBag()
    var sections = [[MyCellModel]]()   //数据源
    var concerns = [MyConcern]()
    //懒加载头部
    lazy var headView : NoLoginHeaderView = {
        let headView = NoLoginHeaderView.headerView()
        return headView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableHeaderView = headView
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        tableView.separatorStyle = .none
        tableView.theme_backgroundColor = "colors.tableViewBackgroundColor"
        //注册cell
        tableView.dl_registerCell(cell: DLTMyFirstSectionCell.self)
        tableView.dl_registerCell(cell: DLTMyOtherCell.self)
        NetWorkTool.loadMyCellData { (sectionArray) in
            let string = "{\"text\":\"我的关注\",\"grey_text\":\"\"}"
            let myConcern = MyCellModel.deserialize(from: string)
            var myConcerns = [MyCellModel]()
            myConcerns.append(myConcern!)
            self.sections.append(myConcerns)
            self.sections += sectionArray
            self.tableView.reloadData()
            NetWorkTool.loadMyConcern { (sectionArray) in
                print("获取到的关注数据",sectionArray)
                self.concerns = sectionArray
                let indexSet = IndexSet(integer: 0)
                self.tableView.reloadSections(indexSet, with: .automatic)
            }
        }
        
        headView.moreLoginButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: { [weak self] in
                let storyboard = UIStoryboard(name: String(describing: DLTMyLoginViewController.self), bundle: nil)
                let loginVC = storyboard.instantiateViewController(withIdentifier: String(describing: DLTMyLoginViewController.self)) as! DLTMyLoginViewController
                loginVC.modalSize = (width: .full, height: .custom(size:Float(screenH - (isiPhoneX ? 44 : 20))))
                self!.present(loginVC, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)  //Disposable就相当于垃圾回收，会自动销毁序列
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    ///将状态栏的字设置成白色
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension DLTMineViewController{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
            let cell = tableView.dl_dequeueReusableCell(indexPath: indexPath) as DLTMyFirstSectionCell
            cell.selectionStyle = .none
            cell.myCellModel = sections[indexPath.section][indexPath.row]
            if concerns.count == 0 || concerns.count == 1 {
                cell.collectionView.isHidden = true
            }
            if concerns.count == 1 {
                cell.myConcern = concerns[0]
            }
            if concerns.count > 1 {
                cell.myConcerns = concerns
            }
            return cell
        }
        let cell = tableView.dl_dequeueReusableCell(indexPath: indexPath) as DLTMyOtherCell
        cell.selectionStyle = .none
        let model = sections[indexPath.section][indexPath.row]
        cell.leftLabel.text = model.text
        cell.rightLabel.text = model.grey_text
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 3 && indexPath.row == 1 {
            let settingVC = DLTMineSetViewController()
            settingVC.navigationItem.title = "设置"
            navigationController?.pushViewController(settingVC, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return (concerns.count == 0 || concerns.count == 1) ? 40 : 114
        }
        return 40
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 0 : 10
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenW, height: 10))
        view.theme_backgroundColor = "colors.tableViewBackgroundColor"
        return view
    }
    
    //增加一个下拉时头部的黏性效果
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offesetY = scrollView.contentOffset.y
        if offesetY < 0{
            //下拉
            let totalOffset = kMyHeadViewHeight + abs(offesetY)
            let f = totalOffset / kMyHeadViewHeight
            headView.bgImageView.frame = CGRect(x: -screenW * (f-1) * 0.5, y: offesetY, width: screenW * f, height: totalOffset)
        }
    }
}
