//
//  UIImageView+Utility.swift
//  DemoLoad
//
//  Created by Subhra Roy on 26/09/20.
//

import Foundation
import UIKit

extension UIImageView{
    

    private func fetchItemsImagePath(fileName:String?) -> String{
        
        let paths: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        var path: String = paths.appendingFormat("/Downloads/Images/")
        
        path = path.appendingFormat("Thumbnail/")
        _ =   CommomUtility().createDirectoryIfNecessaryForPath(path: path)
        
        if let _fileName : String = fileName, _fileName.count > 0 {
            path = path.appendingFormat("%@", _fileName)
        }else{
            path = ""
        }
        
        return  path
    }
    
    func downloadImageWith(imageUrl: String, identifier: String, completion: @escaping (_ status: Bool, _ filePath: String?, _ taskIdentifier: String?) -> Void) -> Void{
        
        let fileName: String = imageUrl.lastPathComponent()
        let storePath = self.fetchItemsImagePath(fileName: fileName)
        let fileDownloader: FileDownloader = FileDownloader(url: imageUrl, filePath: storePath, taskIdentifier: identifier)
        
        if CommomUtility().isFileExistAt(storePath){
            completion(true, storePath, identifier)
        }else{
            fileDownloader.operationStateHandler = { ( status,  fileStorePath,  _identifier) in
                completion(status, fileStorePath, _identifier)
            }
        }
    
    }
    
}
