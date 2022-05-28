//
//  AppsViewController.swift
//  AppStoreUICollectionView
//
//  Created by 윤병일 on 2022/05/28.
//

import UIKit

class AppsViewController : UIViewController {
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setNavi()
  }
  
  //MARK: - Functions
  private func setNavi() {
    self.title = "Apps"
    self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.black]
    self.navigationController?.navigationBar.prefersLargeTitles = true
  }
}
