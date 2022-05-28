//
//  App.swift
//  AppStoreUICollectionView
//
//  Created by 윤병일 on 2022/05/29.
//

import Foundation

struct App : Decodable, Hashable {
  let id : Int
  let tagline : String
  let name : String
  let subheading : String
  let image : String
  let iap : Bool
}
