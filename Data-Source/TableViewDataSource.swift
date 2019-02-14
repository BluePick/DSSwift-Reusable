
import Foundation
import UIKit

class TableViewDataSource<Cell :UITableViewCell,ViewModel> : NSObject, UITableViewDataSource {
    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! Cell
        let item = self.items[indexPath.row]
        self.configureCell(cell,item)
        return cell
    }
    
}

// HOW TO USE
// =========
// DECLARATION
// private var dataSource: TableViewDataSource<CELL_MODEL_CLASS, DATA_MODEL_CLASS>!
// IMPLIMENTATION
// self.dataSource = TableViewDataSource(cellIdentifier: Cells.indetifier, items: [DATA_MODEL_CLASS], configureCell: { (cell, vm) in
//     cell.configureCell(viewModel: vm)
// })
// self.tblView.dataSource = self.dataSource
// self.tblView.reloadData()
