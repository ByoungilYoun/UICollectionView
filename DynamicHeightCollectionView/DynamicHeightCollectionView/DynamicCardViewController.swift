//
//  DynamicCardViewController.swift
//  DynamicHeightCollectionView
//
//  Created by 윤병일 on 2022/05/26.
//

import UIKit

class DynamicCardViewController : UIViewController {
  
  //MARK: - Settings
  
  var viewModel : ViewModel = ViewModel(dataModel:
                                          [DynamicCollectionViewCellViewModel(title: "Pigen is a Great", message: "hello everybody sir app kaise hoo SwiftUI is a best foo swiftUI is a best framework hello everybody sir app kaise hoo swiftUI is a best framework", imageName: "pigen"),
                                           DynamicCollectionViewCellViewModel(title: "This is a car", message: "car driving is a best everybody sir app kaise hoo SwiftUI is a best foo swiftUI is a best framework hello everybody sir app kaise hoo swiftUI is a best framework everybody sir a", imageName: "car"),
                                           DynamicCollectionViewCellViewModel(title: "Guavava", message: "hoo swiftUI is a best oo swiftUI", imageName: "guavava"),
                                           DynamicCollectionViewCellViewModel(title: "Pigen is a beautiful", message: "hello everybody sir app kaise hoo SwiftUI is a best foo swiftUI is a best framework hello everybody sir app kaise hoo swiftUI is a best framework everybody sir app kaise hoo SwiftUI is a best foo swiftUI is a best framework helleverybody sir app kaise hoo SwiftUI is a best foo swiftUI is a best framework hell pp kaise hoo swiftUI is a best framework everybody sir app kaise hoo SwiftUI is a best foo swiftUI is a best framework hellev", imageName: "pigen")
                                                   ])
  
  private lazy var collectionView : UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.estimatedItemSize = CGSize(width: self.view.bounds.size.width, height: 40)
    
    let view = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.dataSource = self
    view.delegate = self
    view.register(DynamicHeightUICollectionViewCell.self, forCellWithReuseIdentifier: DynamicHeightUICollectionViewCell.reuseIdentifier)
    view.reloadData()
    return view
  }()
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(collectionView)
    
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
  
}

  //MARK: - UICollectionViewDataSource
extension DynamicCardViewController : UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.dataModel.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DynamicHeightUICollectionViewCell.reuseIdentifier, for: indexPath) as? DynamicHeightUICollectionViewCell else { return UICollectionViewCell() }
    cell.viewModel = viewModel.dataModel[indexPath.row]
    return cell
  }
}

  //MARK: - UICollectionViewDelegate
extension DynamicCardViewController : UICollectionViewDelegate {
  func collectionView(_ collectionView : UICollectionView, layout collectionViewLayout : UICollectionViewLayout, sizeForItemAt indexPath : IndexPath) -> CGSize {
    let viewModel = viewModel.dataModel[indexPath.row]
    let width = view.bounds.size.width
    let newSize = DynamicHeightUICollectionViewCell.expectedCardSize(CGSize(width: width - 32.0, height: 0.0), viewModel: viewModel)
    return newSize
  }
}

extension DynamicCardViewController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 16, left: 16, bottom: -16, right: 16)
  }
}
