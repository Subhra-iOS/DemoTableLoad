//
//  ViewController+PullToRefresh.swift
//  DemoLoad
//
//  Created by Subhra Roy on 27/09/20.
//

import Foundation
import UIKit

extension ViewController{
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.stopPullToRefresh()
        self.fetchMetaDataFromServer()
    }
    
    private func stopPullToRefresh(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.refreshControl.endRefreshing()
            self.lazyTable.contentOffset = CGPoint.zero
        }
    }
}
