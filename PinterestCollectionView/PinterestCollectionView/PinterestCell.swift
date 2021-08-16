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
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 12
    imageView.clipsToBounds = true
    return imageView
  }()
  
  fileprivate lazy var verticalStackView : UIStackView = {
    let stack = UIStackView(arrangedSubviews: [imageView, horizontalStackView])
    stack.axis = .vertical
    return stack
  }()
  
  fileprivate let label : UILabel = {
    let label = UILabel()
    label.text = "Jimmy Youn Practice"
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
    return label
  }()
  
  fileprivate let myButton : UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "heart"), for: .normal)
    button.imageView?.contentMode = .scaleAspectFit
    button.tintColor = .black
    return button
  }()
  
  fileprivate lazy var horizontalStackView : UIStackView = {
    let stack = UIStackView(arrangedSubviews: [label, myButton])
    stack.axis = .horizontal
    return stack
  }()
  
  //MARK: - init
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(verticalStackView)
    verticalStackView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
    }
    
    horizontalStackView.snp.makeConstraints {
      $0.height.equalTo(25)
    }
    
    myButton.snp.makeConstraints {
      $0.width.equalTo(24)
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 4, bottom: 6, right: 4))
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
