//
//  ViewController.swift
//  PinterestCollectionView
//
//  Created by 윤병일 on 2021/08/16.
//

import UIKit

class PinterestLayout : UICollectionViewFlowLayout {
  
  override init() {
    super.init()
      self.minimumInteritemSpacing = 0
      self.minimumLineSpacing = 0
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
    let width = UIScreen.main.bounds.width / 2
    let rectOne = CGRect(x: 0, y: 0, width: width, height: 300)
    let indexPath = IndexPath(item: 0, section: 0)
    let attributesOne = UICollectionViewLayoutAttributes(forCellWith: indexPath)
    attributesOne.frame = rectOne
    visibleLayoutAttributes.append(attributesOne)
    
    let rectOne1 = CGRect(x: width, y: 150, width: width, height: 300)
    let indexPath1 = IndexPath(item: 1, section: 0)
    let attributesOne1 = UICollectionViewLayoutAttributes(forCellWith: indexPath1)
    attributesOne1.frame = rectOne1
    visibleLayoutAttributes.append(attributesOne1)
    
    let rectOne2 = CGRect(x: 0, y: 300, width: width, height: 150)
    let indexPath2 = IndexPath(item: 2, section: 0)
    let attributesOne2 = UICollectionViewLayoutAttributes(forCellWith: indexPath2)
    attributesOne2.frame = rectOne2
    visibleLayoutAttributes.append(attributesOne2)
    return visibleLayoutAttributes
  }
}

class ViewController: UIViewController {

  //MARK: - Properties
  fileprivate var images : [String] = [
    "1",
    "2",
    "3"
  ]
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let layout = PinterestLayout()

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
    return images.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    cell.backgroundColor = .red
    let imageView = UIImageView(image: UIImage(named: self.images[indexPath.row]))
    imageView.backgroundColor = .yellow
    imageView.frame = cell.contentView.frame
    imageView.contentMode = .scaleAspectFit
    cell.contentView.clipsToBounds = true
    cell.contentView.addSubview(imageView)
    return cell
  }
}
