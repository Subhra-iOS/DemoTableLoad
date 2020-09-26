//
//  CommomUtility.swift
//  DemoLoad
//
//  Created by Subhra Roy on 26/09/20.
//

import Foundation

struct CommomUtility {
    //MARK:----------Unique task id----------//
    func uniqueTaskIdentifier() -> String {
        
        let timeIntervalToday: TimeInterval = Date().timeIntervalSince1970
        let taskIdentitfier : Int64 = Int64(timeIntervalToday * 1000000)
        
        let  taskIdentitfierInString : String = String(taskIdentitfier)
        return  taskIdentitfierInString
        
    }
    //MARK:------Check file existance------------//
    func isFileExistAt(_ path : String) -> Bool {
        
        if FileManager.default.fileExists(atPath: path) {
            
            return  true
            
        }else{
            
            return  false
        }
        
    }
    //MARK:-------Delete corrupted data----------//
    func deleteFileFromDocumentDirectory(destinationStorePath : String) ->Void{
        
        do{
            try  FileManager.default.removeItem(at: URL(fileURLWithPath: destinationStorePath))
            print("File remove sucessfully")
        }catch{
            print("File not removed")
        }
        
    }
    
    //MARK:---------Check or Create Directory If Necessary-------//
    func createDirectoryIfNecessaryForPath(path : String) -> Bool {
        
        if !FileManager.default.fileExists(atPath: path) {
            
            do{
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: [:])
                
                return true
                
            }catch{
                
                return false
            }
            
        }else{
            
            return true
        }
        
    }
    //MARK:-------Creat file path to write JSON file----------//
    func writeJSONWith(fileName: String) -> String{
        
        let paths: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        var path: String = paths.appendingFormat("/Downloads/JSON/")
        
        _ =   CommomUtility().createDirectoryIfNecessaryForPath(path: path)
        
        if fileName.count > 0 {
            path = path.appendingFormat("%@", fileName)
        }else{
            path = ""
        }
        return path
    }
    
    
}
