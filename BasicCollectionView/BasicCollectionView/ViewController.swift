//
//  ViewController.swift
//  BasicCollectionView
//
//  Created by 윤병일 on 2021/08/14.
//

import UIKit

class ViewController: UIViewController {

  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.backgroundColor = .red
    
    view.addSubview(collectionView)
    
    collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }
}
