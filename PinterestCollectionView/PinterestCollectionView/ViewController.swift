//
//  ViewController.swift
//  PinterestCollectionView
//
//  Created by 윤병일 on 2021/08/16.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let layout = UICollectionViewFlowLayout()
    layout.minimumInteritemSpacing = 0
    layout.minimumLineSpacing = 0
    let collection = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
    collection.backgroundColor = .white
    view.addSubview(collection)
    
    collection.delegate = self
    collection.dataSource = self
    collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    collection.contentInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
  }
}

  //MARK: - UICollectionViewDelegateFlowLayout
extension ViewController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cvWidth = collectionView.frame.width - 8
    let columnWith = cvWidth / 2
    return CGSize(width: columnWith, height: 400)
  }
}

  //MARK: - UICollectionViewDataSource
extension ViewController : UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    cell.backgroundColor = .red
    return cell
  }
}
