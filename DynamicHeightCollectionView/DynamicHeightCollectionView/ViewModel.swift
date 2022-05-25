//
//  ViewModel.swift
//  DynamicHeightCollectionView
//
//  Created by 윤병일 on 2022/05/25.
//

import UIKit

class ViewModel : NSObject {
  
  private(set) var dataModel : [DynamicCollectionViewCellViewModel]!
  
  override init() {
    super.init() 
  }
  
  convenience init(dataModel : [DynamicCollectionViewCellViewModel]) {
    self.init()
    self.dataModel = dataModel
  }
}

struct DynamicCollectionViewCellViewModel {
  var title : String
  var message : String
  var imageName : String
  
  init(title : String, message : String, imageName : String) {
    self.title = title
    self.message = message
    self.imageName = imageName
  }
  
  var image : UIImage? {
    return UIImage(named: imageName)
  }
}
