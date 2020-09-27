//
//  ViewController+UpdateUI.swift
//  DemoLoad
//
//  Created by Subhra Roy on 26/09/20.
//

import Foundation
import  UIKit

extension ViewController{
    //MARK:-------Initiate View model on load---------//
    func initiateViewModel(){
        let dataModel: DataModel = DataModel()
        self.viewModel = ViewModel(_dataModel: dataModel)
        self.fetchMetaDataFromServer()
    }
    
}
