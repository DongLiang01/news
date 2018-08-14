//
//  DLTMyFirstSectionCell.swift
//  news
//
//  Created by dongliang on 2018/7/26.
//  Copyright © 2018年 dl. All rights reserved.
//

import UIKit

class DLTMyFirstSectionCell: UITableViewCell, RegisterCellOrNib {

    ///标题
    @IBOutlet weak var leftLabel: UILabel!
    ///副标题
    @IBOutlet weak var rightLabel: UILabel!
    ///只关注一个人时的头像
    @IBOutlet weak var rightImageView: UIImageView!
    ///右边箭头
    @IBOutlet weak var rightArrowImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    ///分割线
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var topView: UIView!
    
    var myCellModel: MyCellModel? {
        didSet{
            leftLabel.text = myCellModel?.text
            rightLabel.text = myCellModel?.grey_text
        }
    }
    //关注了多个人时
    var myConcerns = [MyConcern]() {
        didSet{
            collectionView.reloadData()
        }
    }
    //只关注了一个人的时候
    var myConcern : MyConcern? {
        didSet{
            rightLabel.text = myConcern?.name
            rightImageView.kf.setImage(with: URL(string: (myConcern?.icon)!))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //设置主题颜色
        leftLabel.theme_textColor = "colors.black"
        rightLabel.theme_textColor = "colors.cellRightTextColor"
        rightArrowImageView.theme_image = "images.cellRightArrow"
        separatorView.theme_backgroundColor = "colors.separatorViewColor"
        theme_backgroundColor = "colors.cellBackgroundColor"
        topView.theme_backgroundColor = "colors.cellBackgroundColor"
        collectionView.theme_backgroundColor = "colors.cellBackgroundColor"
        
        collectionView.collectionViewLayout = MyConcernFlowLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.dl_registerCell(cell: DLTMyConcernCollectionCell.self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension DLTMyFirstSectionCell : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myConcerns.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dl_dequeueReusableCell(indexPath: indexPath) as DLTMyConcernCollectionCell
        cell.myConcern = myConcerns[indexPath.item]
        return cell
    }
}

class MyConcernFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        //每个cell的大小
        itemSize = CGSize(width: 58, height: 74)
        //行间距
        minimumLineSpacing = 0
        //列间距
        minimumInteritemSpacing = 0
        //内边距
        sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        //设置水平滚动
        scrollDirection = .horizontal
    }
}

