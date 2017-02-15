//
//  MenuBar.swift
//  TopTabBarSpike
//
//  Created by DNA on 2/15/17.
//  Copyright © 2017 DNA. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var delegate: MenuBarDelegate!
    
    lazy var collectionView: UICollectionView = {
        let cvLayout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: cvLayout)
        
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        
        return cv
    }()
    
    let menuItemIdentifier = "MenuItemIdentifier"
    let imageNames = ["1", "2", "3", "4"]
    let selectedImageNames = ["s1", "s2", "s3", "s4"]
    let colors = [UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.register(MenuCell.self, forCellWithReuseIdentifier: self.menuItemIdentifier)
        
        let viewsDictionary: [String: UIView] = [
            "cv": self.collectionView
        ]
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[cv]|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[cv]|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .top)
        
        self.backgroundColor = UIColor.blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: self.menuItemIdentifier, for: indexPath) as! MenuCell
        if indexPath.item == 0 {
            cell.isSelected = true
        }
        cell.prepare()
        if indexPath.item == 0 {
            cell.imageView.image = UIImage(named: self.selectedImageNames[indexPath.item])
        }
        else {
            cell.imageView.image = UIImage(named: self.imageNames[indexPath.item])
        }
        cell.image = UIImage(named: self.imageNames[indexPath.item])
        cell.selectedImage = UIImage(named: self.selectedImageNames[indexPath.item])
        cell.color = self.colors[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width / 4, height: self.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate.selectedMenuItem(indexPath: indexPath)
    }
}
