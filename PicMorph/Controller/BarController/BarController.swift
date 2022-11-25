//
//  BarController.swift
//  PicMorph
//
//  Created by Alina Sitsko on 25.11.22.
//

import UIKit

class BarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
      settupControllers()
        tabBar.tintColor = UIColor.darkGray
        
    }
    
    private func settupControllers() {
        
        let homeVC = HomeVC(nibName: String(describing: HomeVC.self), bundle: nil)
        let historyVC = HistoryVC(nibName: String(describing: HistoryVC.self), bundle: nil)
        
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "h"), tag: 0)
        historyVC.tabBarItem = UITabBarItem(title: "History", image: UIImage(named: "hst"), tag: 1)
        
        self.viewControllers = [homeVC, historyVC]
    }
    
}
