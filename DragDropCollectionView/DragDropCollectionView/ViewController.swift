//
//  ViewController.swift
//  DragDropCollectionView
//
//  Created by 윤병일 on 2021/08/14.
//

import UIKit

class ViewController: UIViewController {

  //MARK: - Properties
  fileprivate var items : [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
  
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
    collectionView.dragDelegate = self
    collectionView.dragInteractionEnabled = true
    collectionView.dropDelegate = self
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    collectionView.contentInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    view.addSubview(collectionView)
    
  }
  
  //MARK: - Functions
  fileprivate func reorderItems(coordinator : UICollectionViewDropCoordinator, destinationIndexPath : IndexPath, collectionView : UICollectionView) {
    if let item = coordinator.items.first,
       let sourceIndexPath = item.sourceIndexPath {
      
      collectionView.performBatchUpdates({
        // remove the item
        self.items.remove(at: sourceIndexPath.item)
        // inset the item
        self.items.insert(item.dragItem.localObject as! String, at: destinationIndexPath.item)
        collectionView.deleteItems(at: [sourceIndexPath])
        collectionView.insertItems(at: [destinationIndexPath])
      }, completion: nil)
      coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
    }
  }
}

  //MARK: - UICollectionViewDataSource
extension ViewController : UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 9
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

  //MARK: - UICollectionViewDragDelegate
extension ViewController : UICollectionViewDragDelegate {
  func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
    let item = self.items[indexPath.row]
    let itemProvider = NSItemProvider(object: item as NSString)
    let dragItem = UIDragItem(itemProvider: itemProvider)
    dragItem.localObject = item
    
    return [dragItem]
  }
}

  //MARK: - UICollectionViewDropDelegate
extension ViewController : UICollectionViewDropDelegate {
  func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
      if collectionView.hasActiveDrag {
        return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
      }
      return UICollectionViewDropProposal(operation: .forbidden)
  }
  
  func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
    let destinationIndexPath = coordinator.destinationIndexPath
    
    guard let indexPath = destinationIndexPath else {return}
    
    if coordinator.proposal.operation == .move {
      self.reorderItems(coordinator: coordinator, destinationIndexPath: indexPath, collectionView: collectionView)
    }
  }
}

  //MARK: - UICollectionViewDelegateFlowLayout
extension ViewController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let square = (collectionView.frame.width - 8) / 3
    return CGSize(width: square, height: square)
  }
}
