//
//  TableViewCell+MetaData.swift
//  DemoLoad
//
//  Created by Subhra Roy on 26/09/20.
//

import Foundation
import  UIKit

extension TableViewCell{
    
    func reloadImages(){
        
        self.iconImageView.backgroundColor = UIColor(red: (224.0/255.0), green: (224.0/255.0), blue: (224.0/255.0), alpha: 1.0)
        guard let url = self.imageUrl else {
            return
        }
        
        self.activityLoader.startAnimating()
        self.iconImageView.downloadImageWith(imageUrl: url, identifier: self.taskId) { [weak self] (state, fileStorePath, taskIdentifier) in
            
            guard  let weakSelf = self, let currentID: String = taskIdentifier,  weakSelf.taskId.isEqual(currentID) else {
                return
            }
            
            DispatchQueue.main.async{
                weakSelf.activityLoader.stopAnimating()
                if  let image: UIImage = UIImage(contentsOfFile: fileStorePath ?? ""){
                    weakSelf.iconImageView.image = nil
                    weakSelf.iconImageView.image = image
                    weakSelf.iconImageView.backgroundColor = UIColor.clear
                }else{
                    weakSelf.iconImageView.backgroundColor = UIColor(red: (224.0/255.0), green: (224.0/255.0), blue: (224.0/255.0), alpha: 1.0)
                }
            }
            
        }
    }
    
}
