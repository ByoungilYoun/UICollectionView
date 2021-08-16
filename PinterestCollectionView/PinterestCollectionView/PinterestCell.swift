//
//  PinterestCell.swift
//  PinterestCollectionView
//
//  Created by 윤병일 on 2021/08/16.
//

import UIKit

class PinterestCell : UICollectionViewCell {
  
  //MARK: - Properties
  static let identifier = "PinterestCell"
  
  var image : UIImage! {
    didSet {
      imageView.image = image
    }
  }
  
  fileprivate let imageView : UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  //MARK: - init
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.layer.cornerRadius = 12
    contentView.clipsToBounds = true
    contentView.addSubview(imageView)
    imageView.frame = contentView.frame
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 4, bottom: 10, right: 4))
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Functions
}
