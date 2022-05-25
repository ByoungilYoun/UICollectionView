//
//  DynamicHeightUICollectionViewCell.swift
//  DynamicHeightCollectionView
//
//  Created by 윤병일 on 2022/05/25.
//

import UIKit

class DynamicHeightUICollectionViewCell : UICollectionViewCell {
  
  //MARK: - Properties
  
  static let reuseIdentifier = String(describing: DynamicHeightUICollectionViewCell.self)
  
  var viewModel : DynamicCollectionViewCellViewModel? {
    didSet {
      updateSubviews()
    }
  }
  
  private lazy var titleLabel : UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.textColor = UIColor.black
    label.font = UIFont.boldSystemFont(ofSize: 18.0)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var messageLabel : UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textColor = UIColor.black
    label.lineBreakMode = .byWordWrapping
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var imageView : UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      view.widthAnchor.constraint(equalToConstant: 150.0),
      view.heightAnchor.constraint(equalToConstant: 150.0)
    ])
    return view
  }()
  
  private lazy var containerView : UIStackView = {
    let view = UIStackView(arrangedSubviews: [titleLabel, imageView, messageLabel])
    view.backgroundColor = UIColor.green
    view.layer.cornerRadius = 12.0
    view.spacing = 12.0
    view.axis = .vertical
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var cardWidth : NSLayoutConstraint = {
    containerView.translatesAutoresizingMaskIntoConstraints = false
    let constraint = containerView.widthAnchor.constraint(equalToConstant: 1000)
    constraint.isActive = true
    return constraint
  }()
  
  //MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: .zero)
    configureAppearance()
    configureSubviews()
  }
  
  required init(viewModel : DynamicCollectionViewCellViewModel?) {
    self.init()
    self.viewModel = viewModel
    configureAppearance()
    configureSubviews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    viewModel = nil
  }
  
  //MARK: - Functions
  private func updateSubviews() {
    
    guard let viewModel = viewModel else {
      return
    }
    
    titleLabel.text = viewModel.title
    imageView.image = viewModel.image
    messageLabel.text = viewModel.message
  }
  
  private func configureAppearance() {
    self.contentView.backgroundColor = .white
  }
  
  private func configureSubviews() {
    contentView.addSubview(containerView)
    containerView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      containerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      containerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
    ])
  }
}

  //MARK: - Extension
extension DynamicHeightUICollectionViewCell {
  
  static func expectedCardSize(_ targetSize : CGSize, viewModel : DynamicCollectionViewCellViewModel) -> CGSize {
    
    let view = DynamicHeightUICollectionViewCell(viewModel : viewModel)
    let acsize = view.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 0.0), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
    return acsize
  }
  
  override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
    cardWidth.constant = targetSize.width
    
    return containerView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: horizontalFittingPriority, verticalFittingPriority: verticalFittingPriority)
  }
}
