//
//  SmallTableCell.swift
//  AppStoreUICollectionView
//
//  Created by 윤병일 on 2022/05/29.
//

import UIKit

class SmallTableCell: UICollectionViewCell, SelfConfiguringCell {
  
  //MARK: - Properties
  static let reuseIdentifier: String = "SmallTableCell"
  
  let name = UILabel()
  let imageView = UIImageView()
  
  //MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.layout()
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("How many times do I have to tell you? THIS. ISN'T. SUPPORTED.")
  }
  
  //MARK: - Functions
  private func layout() {
    name.font = UIFont.preferredFont(forTextStyle: .title2)
    name.textColor = .label
    
    imageView.layer.cornerRadius = 5
    imageView.clipsToBounds = true
    
    let stackView = UIStackView(arrangedSubviews: [imageView, name])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.alignment = .center
    stackView.spacing = 20
    contentView.addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }
  
  func configure(with app: App) {
    name.text = app.name
    imageView.image = UIImage(named: app.image)
  }
}
