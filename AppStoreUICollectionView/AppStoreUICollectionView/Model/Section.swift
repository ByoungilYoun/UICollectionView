//
//  Section.swift
//  AppStoreUICollectionView
//
//  Created by 윤병일 on 2022/05/29.
//

import Foundation

struct Section : Decodable, Hashable {
  let id : Int
  let type : String
  let title : String
  let subtitle : String
  let items : [App]
}
