//
//  ViewController.swift
//  DragDropCollectionView
//
//  Created by 윤병일 on 2021/08/14.
//

import UIKit

class ViewController: UIViewController {

  //MARK: - Lifeycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: 100, height: 100)
    
    let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
    collectionView.backgroundColor = .cyan
    view.addSubview(collectionView)
    
  }
}

