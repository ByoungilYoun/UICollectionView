//
//  FeaturedCell.swift
//  AppStoreUICollectionView
//
//  Created by 윤병일 on 2022/05/29.
//

import Foundation
import UIKit

class FeaturedCell : UICollectionViewCell, SelfConfiguringCell {
  
  //MARK: - Properties
  static let reuseIdentifier: String = "FeaturedCell"
  
  let tagline = UILabel()
  let name = UILabel()
  let subtitle = UILabel()
  let imageView = UIImageView()
  
  //MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Functions
  func layout() {
    let seperator = UIView(frame: .zero)
    seperator.translatesAutoresizingMaskIntoConstraints = false
    seperator.backgroundColor = .quaternaryLabel
    
    tagline.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 12, weight: .bold))
    tagline.textColor = .systemBlue
    
    name.font = UIFont.preferredFont(forTextStyle: .title2)
    name.textColor = .label
    
    subtitle.font = UIFont.preferredFont(forTextStyle: .title2)
    name.textColor = .secondaryLabel
    
    imageView.layer.cornerRadius = 5
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFit
    
    let stackView = UIStackView(arrangedSubviews: [seperator, tagline, name, subtitle, imageView])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    contentView.addSubview(stackView)
    
    NSLayoutConstraint.activate([
      seperator.heightAnchor.constraint(equalToConstant: 1),
      
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
    
    stackView.setCustomSpacing(10, after: seperator)
    stackView.setCustomSpacing(10, after: subtitle)
  }
  
  func configure(with app: App) {
    tagline.text = app.tagline.uppercased()
    name.text = app.name
    subtitle.text = app.subheading
    imageView.image = UIImage(named: app.image)
  }
  
  
}
