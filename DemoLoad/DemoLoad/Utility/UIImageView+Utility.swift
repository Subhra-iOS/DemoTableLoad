//
//  UIImageView+Utility.swift
//  DemoLoad
//
//  Created by Subhra Roy on 26/09/20.
//

import Foundation
import UIKit

extension UIImageView{

    //MARK:-------download image over network----------//
    func downloadImageWith(imageUrl: String, identifier: String, completion: @escaping (_ status: Bool, _ filePath: String?, _ taskIdentifier: String?) -> Void) -> Void{
        
        self.image = nil
        let fileName: String = imageUrl.lastPathComponent()
        let storePath = CommomUtility().fetchItemsImagePath(fileName: fileName)
        
        if CommomUtility().isFileExistAt(storePath){
            completion(true, storePath, identifier)
        }else{
            let fileDownloader: FileDownloader = FileDownloader(url: imageUrl, filePath: storePath, taskIdentifier: identifier)
            fileDownloader.downloadFile()
            fileDownloader.operationStateHandler = { ( status,  fileStorePath,  _identifier) in
                completion(status, fileStorePath, _identifier)
            }
        }
    
    }
    
}
