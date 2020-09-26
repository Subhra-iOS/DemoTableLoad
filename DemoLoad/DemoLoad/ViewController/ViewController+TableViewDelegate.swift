//
//  ViewController+TableViewDelegate.swift
//  DemoLoad
//
//  Created by Subhra Roy on 26/09/20.
//

import Foundation
import UIKit

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _viewModel = self.viewModel, let array = _viewModel.list, array.count > 0 {
            return array.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TableViewCell{
            if let array = self.viewModel.list, array.count > 0 {
                let model: ItemModel = array[indexPath.row]
                cell.loadMetaDataWith(listItem: model)
                cell.reloadImages()
            }
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return UITableView.automaticDimension
    }
}
