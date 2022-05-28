//
//  AppsViewController.swift
//  AppStoreUICollectionView
//
//  Created by 윤병일 on 2022/05/28.
//

import UIKit

class AppsViewController : UIViewController {
  
  //MARK: - Properties
  let sections = Bundle.main.decode([Section].self, from: "appstore.json")
  
  var collectionView : UICollectionView!
  
  var dataSource : UICollectionViewDiffableDataSource<Section, App>?
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setNavi()
    configureCollectionView()
  }
  
  //MARK: - Functions
  private func setNavi() {
    self.title = "Apps"
    self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.black]
    self.navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  private func configureCollectionView() {
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.backgroundColor = .systemBackground
    view.addSubview(collectionView)
  }
}
