//
//  MenuCell.swift
//  TopTabBarSpike
//
//  Created by DNA on 2/15/17.
//  Copyright © 2017 DNA. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    var color: UIColor!
    var image: UIImage!
    var selectedImage: UIImage!
    
    let imageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "1"))
        return iv
    }()
    
    override var isSelected: Bool {
        didSet {
            self.imageView.image = isSelected ? self.selectedImage : self.image
            //            self.changeImage(isSelected: isSelected)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.prepare()
    }
    
    public func prepare() {
        self.imageView.image = isSelected ? self.selectedImage : self.image
        self.addSubview(self.imageView)
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
    }
    
    private func changeImage(isSelected: Bool) {
        if isSelected {
            self.imageView.image = self.selectedImage
        }
        else {
            self.imageView.image = self.image
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
