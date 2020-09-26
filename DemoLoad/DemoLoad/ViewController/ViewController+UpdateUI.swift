//
//  ViewController+UpdateUI.swift
//  DemoLoad
//
//  Created by Subhra Roy on 26/09/20.
//

import Foundation
import  UIKit

extension ViewController{
    
    func initiateViewModel(){
        let dataModel: DataModel = DataModel()
        self.viewModel = ViewModel(_dataModel: dataModel)
        self.viewModel.fetchMetaDataFromServerWith({ (status) in
            DispatchQueue.main.async { [weak self] in
                self?.title = self?.viewModel?.title
                self?.lazyTable.reloadData()
            }
        })
    }
    
}
