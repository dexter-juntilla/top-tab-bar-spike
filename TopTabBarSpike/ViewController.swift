//
//  ViewController.swift
//  TopTabBarSpike
//
//  Created by DNA on 2/15/17.
//  Copyright © 2017 DNA. All rights reserved.
//

import UIKit

@objc protocol MenuBarDelegate {
    @objc func selectedMenuItem(indexPath: IndexPath)
}

class ViewController: UIViewController {

    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.delegate = self
        return mb
    }()
    
    let contentView: UIView = {
        let cv = UIView()
        cv.backgroundColor = UIColor.red
        return cv
    }()
    
    var currentViewController: UIViewController?
    
    lazy var first: UIViewController? = {
        var storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "RedViewController")
        let c = controller as? RedViewController
        return c
    }()
    
    lazy var second: UIViewController? = {
        var storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "BlueViewController")
        let c = controller as? BlueViewController
        return c
    }()
    
    lazy var third: UIViewController? = {
        var storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "GreenViewController")
        let c = controller as? GreenViewController
        return c
    }()
    
    lazy var fourth: UIViewController? = {
        var storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "YellowViewController")
        let c = controller as? YellowViewController
        return c
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpMenuBar()
        self.setContentView()
        self.displayCurrentTab(0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: -
    private func setUpMenuBar() {
        self.view.addSubview(self.contentView)
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let viewsDictionary: [String: UIView] = [
            "cv": self.contentView
        ]
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[cv]|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[cv]|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    func viewControllerForSelectedSegmentIndex(_ index: Int) -> UIViewController? {
        var vc: UIViewController?
        switch index {
        case 0 :
            vc = first
        case 1:
            vc = second
        case 2:
            vc = third
        case 3:
            vc = fourth
        default:
            return nil
        }
        
        return vc
    }
    
    func displayCurrentTab(_ tabIndex: Int){
        if let vc = viewControllerForSelectedSegmentIndex(tabIndex) {
            
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
            vc.view.frame = self.contentView.bounds
            self.contentView.addSubview(vc.view)
            self.currentViewController = vc
        }
    }
    
    private func setContentView() {
        self.view.addSubview(self.menuBar)
        
        self.menuBar.translatesAutoresizingMaskIntoConstraints = false
        
        let viewsDictionary: [String: UIView] = [
            "mb": self.menuBar
        ]
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[mb]|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[mb(50)]", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

extension ViewController: MenuBarDelegate {
    func selectedMenuItem(indexPath: IndexPath) {
        self.displayCurrentTab(indexPath.item)
    }
}
