//
//  ViewController.swift
//  PinterestCollectionView
//
//  Created by 윤병일 on 2021/08/16.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

  //MARK: - Properties
  fileprivate var images : [String] = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "5",
    "4",
    "3",
    "2",
    "1"
  ]
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let layout = PinterestLayout()
    let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collection.backgroundColor = .white
    collection.register(PinterestCell.self, forCellWithReuseIdentifier: PinterestCell.identifier)
    collection.dataSource = self
    if let layout = collection.collectionViewLayout as? PinterestLayout {
      layout.delegate = self
    }
    
    view.addSubview(collection)
    
    collection.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
    }
    
  }
}

  //MARK: - UICollectionViewDataSource
extension ViewController : UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return images.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PinterestCell.identifier, for: indexPath) as! PinterestCell
    let image = UIImage(named: self.images[indexPath.row])
    cell.image = image
    return cell
  }
}

  //MARK: - PinterestDelegate
extension ViewController : PinterestDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfColumns: Int, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
    let image = UIImage(named: self.images[indexPath.item])!
    let imageHeight = image.size.height
    let imageWidth = image.size.width
    let columnRatio : CGFloat = 1 / CGFloat(numberOfColumns)
    let imageSizeRatio = (collectionView.frame.width * columnRatio) / imageWidth
    return imageHeight * imageSizeRatio
  }
}
