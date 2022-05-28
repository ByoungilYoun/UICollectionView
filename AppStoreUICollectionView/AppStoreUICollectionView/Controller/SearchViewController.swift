//
//  SearchViewController.swift
//  AppStoreUICollectionView
//
//  Created by 윤병일 on 2022/05/28.
//

import UIKit

class SearchViewController : UIViewController {
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setNavi()
  }
  
  //MARK: - Functions
  private func setNavi() {
    self.title = "Search"
    self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.black]
    self.navigationController?.navigationBar.prefersLargeTitles = true
  }
}
