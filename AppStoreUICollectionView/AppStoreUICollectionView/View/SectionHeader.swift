//
//  SectionHeader.swift
//  AppStoreUICollectionView
//
//  Created by 윤병일 on 2022/05/29.
//

import UIKit

class SectionHeader: UICollectionReusableView {
  
  //MARK: - Properties
  static let reuseIdentifier = "SectionHeader"
  
  let title = UILabel()
  let subtitle = UILabel()
  
  //MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.layout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("Stop trying to make storyboards happen.")
  }
  
  //MARK: - Functions
  private func layout() {
    let separator = UIView(frame: .zero)
    separator.translatesAutoresizingMaskIntoConstraints = false
    separator.backgroundColor = .quaternaryLabel
    
    title.textColor = .label
    title.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 22, weight: .bold))
    subtitle.textColor = .secondaryLabel
    
    let stackView = UIStackView(arrangedSubviews: [separator, title, subtitle])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    addSubview(stackView)
    
    NSLayoutConstraint.activate([
      separator.heightAnchor.constraint(equalToConstant: 1),
      
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      stackView.topAnchor.constraint(equalTo: topAnchor),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
    ])
    
    stackView.setCustomSpacing(10, after: separator)
  }
}

