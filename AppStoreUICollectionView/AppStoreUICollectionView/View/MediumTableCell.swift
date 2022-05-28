//
//  MediumTableCell.swift
//  AppStoreUICollectionView
//
//  Created by 윤병일 on 2022/05/29.
//

import UIKit

class MediumTableCell : UICollectionViewCell, SelfConfiguringCell {

  //MARK: - Properties
  static let reuseIdentifier: String = "MediumTableCell"
  
  let name = UILabel()
  let subtitle = UILabel()
  let imageView = UIImageView()
  let buyButton = UIButton(type: .custom)
  
  //MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Functions

  private func layout() {
    name.font = UIFont.preferredFont(forTextStyle: .headline)
    name.textColor = .label

    subtitle.font = UIFont.preferredFont(forTextStyle: .subheadline)
    subtitle.textColor = .secondaryLabel

    imageView.layer.cornerRadius = 15
    imageView.clipsToBounds = true

    buyButton.setImage(UIImage(systemName: "icloud.and.arrow.down"), for: .normal)

    imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    buyButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    
    let innerStackView = UIStackView(arrangedSubviews: [name, subtitle])
    innerStackView.axis = .vertical

    let outerStackView = UIStackView(arrangedSubviews: [imageView, innerStackView, buyButton])
    outerStackView.translatesAutoresizingMaskIntoConstraints = false
    outerStackView.alignment = .center
    outerStackView.spacing = 10
    contentView.addSubview(outerStackView)

    NSLayoutConstraint.activate([
        outerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        outerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        outerStackView.topAnchor.constraint(equalTo: contentView.topAnchor)
    ])
  }
  
  func configure(with app: App) {
    name.text = app.name
    subtitle.text = app.subheading
    imageView.image = UIImage(named: app.image)
  }
  
  
}
