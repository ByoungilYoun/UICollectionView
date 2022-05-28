//
//  TabBarController.swift
//  AppStoreUICollectionView
//
//  Created by 윤병일 on 2022/05/28.
//

import UIKit

class TabBarController : UITabBarController {
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setTabBarControllers()
  }
  
  //MARK: - Functions
  private func setTabBarControllers() {
    let appsViewController = AppsViewController()
    let appsNavi = UINavigationController(rootViewController: appsViewController)
    appsNavi.tabBarItem = UITabBarItem(title: "Apps", image: UIImage(systemName: "square.stack.3d.up"), selectedImage: UIImage(systemName: "square.stack.3d.up.fill"))
    
    let gamesViewController = GamesViewController()
    let gamesNavi = UINavigationController(rootViewController: gamesViewController)
    gamesNavi.tabBarItem = UITabBarItem(title: "Games", image: UIImage(systemName: "gamecontroller"), selectedImage: UIImage(systemName: "gamecontroller.fill"))
    
    let arcadeViewController = ArcadeViewController()
    let arcadeNavi = UINavigationController(rootViewController: arcadeViewController)
    arcadeNavi.tabBarItem = UITabBarItem(title: "Arcade", image: UIImage(systemName: "dollarsign.circle"), selectedImage: UIImage(systemName: "dollarsign.circle.fill"))
    
    let searchViewController = SearchViewController()
    let searchNavi = UINavigationController(rootViewController: searchViewController)
    searchNavi.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
    
    self.viewControllers = [appsNavi, gamesNavi, arcadeNavi, searchNavi]
    
  }
}


