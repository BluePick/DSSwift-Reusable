
import Foundation
import UIKit

class CollectionViewDataSource<Cell :UICollectionViewCell,ViewModel> : NSObject, UICollectionViewDataSource {
    
    private var cellIdentifier :String!
    private var items :[ViewModel]!
    var configureCell :(Cell,ViewModel) -> ()
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - cellIdentifier: <#cellIdentifier description#>
    ///   - items: <#items description#>
    ///   - configureCell: <#configureCell description#>
    init(cellIdentifier :String, items :[ViewModel], configureCell: @escaping (Cell,ViewModel) -> ()) {
        
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! Cell
        let item = self.items[indexPath.item]
        self.configureCell(cell,item)
        return cell
    }
    
}
