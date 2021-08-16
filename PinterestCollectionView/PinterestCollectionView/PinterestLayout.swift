//
//  PinterestLayout.swift
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
    
    var xOffset = [CGFloat]()
    var yOffset = [CGFloat](repeating : 0, count : numberOfColumns)
   
    for column in 0 ..< numberOfColumns {
      xOffset.append(CGFloat(column) * columnWidth)
    }
    
    var columnToPlacePhoto = 0
    
    for item in 0 ..< collection.numberOfItems(inSection: 0) {
      let indexPath = IndexPath(item: item, section: 0)
      let photoHeight : CGFloat = delegate?.collectionView(collection, numberOfColumns: numberOfColumns, heightForPhotoAtIndexPath: indexPath) ?? 200
      let frame = CGRect(x: xOffset[columnToPlacePhoto], y: yOffset[columnToPlacePhoto], width: columnWidth, height: photoHeight)
      let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      attributes.frame = frame
      self.cache.append(attributes)
      
      yOffset[columnToPlacePhoto] = yOffset[columnToPlacePhoto] + photoHeight
      columnToPlacePhoto = columnToPlacePhoto < (numberOfColumns - 1) ? (columnToPlacePhoto + 1) : 0
    }
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    return cache
  }
}
