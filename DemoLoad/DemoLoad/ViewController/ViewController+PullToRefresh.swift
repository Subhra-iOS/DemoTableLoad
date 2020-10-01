//
//  ViewController+PullToRefresh.swift
//  DemoLoad
//
//  Created by Subhra Roy on 27/09/20.
//

import Foundation
import UIKit

extension ViewController{
    
    /// Refresh Handler for pull to refresh
    /// - Parameter refreshControl: UIRefreshControl Object
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.fetchMetaDataFromServer()
    }
    
    //MARK:----- Fetch metadata from server--------
    func fetchMetaDataFromServer() {
        self.viewModel.fetchMetaDataFromServerWith({ (status) in
            DispatchQueue.main.async { [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.viewActivityLoader.stopAnimating()
                weakSelf.lazyTable.isHidden = false
                weakSelf.title = self?.viewModel?.title
                weakSelf.lazyTable.reloadData()
                if weakSelf.refreshControl.isRefreshing {
                    self?.refreshControl.endRefreshing()
                    self?.lazyTable.contentOffset = CGPoint.zero
                }
            }
        })
    }
}
