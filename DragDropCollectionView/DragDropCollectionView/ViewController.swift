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
    layout.minimumInteritemSpacing = 0
    
    let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
    collectionView.backgroundColor = .white
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    view.addSubview(collectionView)
    
  }
}

  //MARK: - UICollectionViewDataSource
extension ViewController : UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    cell.backgroundColor = .cyan
    return cell
  }
}

  //MARK: - UICollectionViewDelegateFlowLayout
extension ViewController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let square = collectionView.frame.width / 3
    return CGSize(width: square, height: square)
  }
}
