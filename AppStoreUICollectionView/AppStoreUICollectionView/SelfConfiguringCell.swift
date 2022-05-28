//
//  SelfConfiguringCell.swift
//  AppStoreUICollectionView
//
//  Created by 윤병일 on 2022/05/29.
//

import Foundation

protocol SelfConfiguringCell {
  static var reuseIdentifier : String { get }
  func configure(with app : App)
}
