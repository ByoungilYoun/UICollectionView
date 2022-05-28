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
    self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.label]
    self.navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  private func configureCollectionView() {
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.backgroundColor = .systemBackground
    view.addSubview(collectionView)
    
    collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseIdentifier)
    collectionView.register(FeaturedCell.self, forCellWithReuseIdentifier: FeaturedCell.reuseIdentifier)
    collectionView.register(MediumTableCell.self, forCellWithReuseIdentifier: MediumTableCell.reuseIdentifier)
    
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
      case "mediumTable" :
        return self.configure(MediumTableCell.self, with: app, for: indexPath)
      default :
        return self.configure(FeaturedCell.self, with: app, for: indexPath)
      }
    }
    
    dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
      guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseIdentifier, for: indexPath) as? SectionHeader else {
          return nil
    }
      
      guard let firstApp = self?.dataSource?.itemIdentifier(for: indexPath) else { return nil }
      guard let section = self?.dataSource?.snapshot().sectionIdentifier(containingItem: firstApp) else { return nil }
      if section.title.isEmpty { return nil }

      sectionHeader.title.text = section.title
      sectionHeader.subtitle.text = section.subtitle
      return sectionHeader
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
  
  func createCompositionalLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
      let section = self.sections[sectionIndex]
      
      switch section.type {
      case "mediumTable" :
        return self.createMediumTableSection(using: section)
      default :
        return self.createFeaturedSection(using: section)
      }
    }
    
    let config = UICollectionViewCompositionalLayoutConfiguration()
    config.interSectionSpacing = 20
    layout.configuration = config
    return layout
  }
  
  func createFeaturedSection(using section : Section) -> NSCollectionLayoutSection {
    // size -> item -> group -> section
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
    layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
    
    let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(350))
    let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
    
    let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
    layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
    return layoutSection
  }
  
  
  func createMediumTableSection(using section: Section) -> NSCollectionLayoutSection {
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.33))

      let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
      layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)

      let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .fractionalWidth(0.55))
      let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])

      let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
      layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
    
      let layoutSectionHeader = createSectionHeader()
      layoutSection.boundarySupplementaryItems = [layoutSectionHeader]

      return layoutSection
  }
  
  func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
      let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(80))
      let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
      return layoutSectionHeader
  }
}
