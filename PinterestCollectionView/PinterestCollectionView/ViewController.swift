//
//  ViewController.swift
//  PinterestCollectionView
//
//  Created by 윤병일 on 2021/08/16.
//

import UIKit

protocol PinterestDelegate : AnyObject {
  func collectionView(_ collectionView : UICollectionView, numberOfColumns : Int, heightForPhotoAtIndexPath indexPath : IndexPath) -> CGFloat
}

class PinterestLayout : UICollectionViewFlowLayout {
  
  weak var delegate : PinterestDelegate?
  
  var cache = [UICollectionViewLayoutAttributes]()
  
  fileprivate let numberOfColumns = 2
  
  fileprivate var contentHeight : CGFloat = 0
  
  fileprivate var contentWidth : CGFloat {
    guard let collectionView = collectionView else {return 0.0}
    let insets = collectionView.contentInset
    return collectionView.bounds.width - (insets.left + insets.right)
  }
  
  override var collectionViewContentSize: CGSize {
    return CGSize(width: contentWidth, height: contentHeight)
  }
  
  override func prepare() {
    guard let collection = collectionView else {return}
    let columnWidth = contentWidth / CGFloat(numberOfColumns)
    
    let xOffset : [CGFloat] = [0,columnWidth]
    let yOffset : CGFloat = 100
   
    var columnToPlacePhoto = 0
    
    for item in 0 ..< collection.numberOfItems(inSection: 0) {
      let indexPath = IndexPath(item: item, section: 0)
      let photoHeight : CGFloat = delegate?.collectionView(collection, numberOfColumns: numberOfColumns, heightForPhotoAtIndexPath: indexPath) ?? 200
      let frame = CGRect(x: xOffset[columnToPlacePhoto], y: yOffset, width: columnWidth, height: photoHeight)
      let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      attributes.frame = frame
      self.cache.append(attributes)
      
      columnToPlacePhoto = 1
    }
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//    var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
    return cache
  }
}

class ViewController: UIViewController {

  //MARK: - Properties
  fileprivate var images : [String] = [
    "1",
    "2",
    "3"
  ]
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let layout = PinterestLayout()
    layout.minimumInteritemSpacing = 0
    layout.minimumLineSpacing = 0
    let collection = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
    collection.backgroundColor = .white
    view.addSubview(collection)
    
    if let layout = collection.collectionViewLayout as? PinterestLayout {
      layout.delegate = self
    }
    
    collection.dataSource = self
    collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    collection.contentInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
  }
}

  //MARK: - UICollectionViewDelegateFlowLayout
//extension ViewController : UICollectionViewDelegateFlowLayout {
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//    let cvWidth = collectionView.frame.width - 8
//    let columnWith = cvWidth / 2
//    return CGSize(width: columnWith, height: 400)
//  }
//}

  //MARK: - UICollectionViewDataSource
extension ViewController : UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return images.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    cell.backgroundColor = .red
    let imageView = UIImageView(image: UIImage(named: self.images[indexPath.row]))
    imageView.backgroundColor = .yellow
    imageView.frame = cell.contentView.frame
    imageView.contentMode = .scaleAspectFit
    cell.contentView.clipsToBounds = true
    cell.contentView.addSubview(imageView)
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
