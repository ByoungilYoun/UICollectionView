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
    
    collectionView.register(FeaturedCell.self, forCellWithReuseIdentifier: FeaturedCell.reuseIdentifier)
    
    createDataSource()
    reloadData()
  }
  
  func configure<T : SelfConfiguringCell>(_ cellType : T.Type, with app : App, for indexPath : IndexPath) -> T {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
      fatalError("Unable to dequeue \(cellType)")
    }
    
    cell.configure(with: app)
    return cell
  }
  
  func createDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, App>(collectionView: collectionView) { collectionView, indexPath, app in
      switch self.sections[indexPath.section].type {
      default :
        return self.configure(FeaturedCell.self, with: app, for: indexPath)
      }
    }
  }
  
  func reloadData() {
    var snapshot = NSDiffableDataSourceSnapshot<Section, App>()
    snapshot.appendSections(sections)
    
    for section in sections {
      snapshot.appendItems(section.items, toSection: section)
    }
    
    dataSource?.apply(snapshot)
  }
}
