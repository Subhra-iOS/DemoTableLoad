//
//  TableViewCell+MetaData.swift
//  DemoLoad
//
//  Created by Subhra Roy on 26/09/20.
//

import Foundation
import  UIKit

extension TableViewCell{
    
    func loadMetaDataWith(listItem: ItemModel){
        self.nameLabel.text = listItem.title ?? ""
        self.detailedLabel.text = listItem.description ?? ""
        self.imageUrl = listItem.imageHref ?? ""
        self.taskId = listItem.identifier ?? ""
    }
    
    func reloadImages(){
        self.activityLoader.startAnimating()
        self.iconImageView.downloadImageWith(imageUrl: self.imageUrl ?? "", identifier: self.taskId) { [weak self] (state, fileStorePath, taskIdentifier) in
            
            guard  let weakSelf = self, let currentID: String = taskIdentifier,  weakSelf.taskId.isEqual(currentID) else {
                return
            }
            
            DispatchQueue.main.async{
                weakSelf.activityLoader.stopAnimating()
                if  let image: UIImage = UIImage(contentsOfFile: fileStorePath ?? ""){
                    weakSelf.iconImageView.image = image
                    weakSelf.iconImageView.backgroundColor = UIColor.clear
                }else{
                    weakSelf.iconImageView.image = nil
                    CommomUtility().deleteFileFromDocumentDirectory(destinationStorePath: fileStorePath ?? "")
                }
            }
            
        }
    }
    
}
