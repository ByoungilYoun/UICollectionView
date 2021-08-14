//
//  ViewController.swift
//  DragDropCollectionView
//
//  Created by 윤병일 on 2021/08/14.
//

import UIKit

class ViewController: UIViewController {

  //MARK: - Properties
  fileprivate var items : [String] = ["1", "2", "3"]
  
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
    collectionView.contentInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
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
    cell.backgroundColor = .white
    let image = UIImage(named: self.items[indexPath.row])
    let cellImage = UIImageView(image: image)
    cell.contentView.addSubview(cellImage)
    cellImage.contentMode = .scaleAspectFill
    cell.contentView.clipsToBounds = true
    cellImage.translatesAutoresizingMaskIntoConstraints = false
    cellImage.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 4).isActive = true
    cellImage.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 4).isActive = true
    cellImage.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -4).isActive = true
    cellImage.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -4).isActive = true
    return cell
  }
}

  //MARK: - UICollectionViewDelegateFlowLayout
extension ViewController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let square = (collectionView.frame.width - 8) / 3
    return CGSize(width: square, height: square)
  }
}
