//
//  ViewModel.swift
//  DemoLoad
//
//  Created by Subhra Roy on 26/09/20.
//

import Foundation

class ViewModel {
    public var list: [TableCellViewModel]?
    public private(set) var title: String?
    public private(set) var dataModel: DataModel?

    
    init(_dataModel: DataModel) {
        self.dataModel = _dataModel
    }
    //MARK:--------------Fetch data from server-----------//
    func fetchMetaDataFromServerWith(_ completionHandler: @escaping (_ status: Bool) -> Void){
        let fileURL : String = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        let session = URLSession(configuration: .default)
        let request: URLRequest = URLRequest(url: URL(string: fileURL)!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 120)
        let task = session.dataTask(with: request) { [weak self] (data, _ , error) in
            
            guard let weakSelf = self else {
                completionHandler(false)
                return
            }
                    
            if let _ = error {
                completionHandler(false)
            }else{
                
                guard let responseData: Data = data else {
                    completionHandler(false)
                    return
                }
                
                print("\(String(describing: String(data: responseData, encoding: .utf8)))") // It gets nil for normal conversion, need to write facts.json
                
                let storePath: String = weakSelf.removeExistingFileAndReturnNewPathWith(fileUrl: fileURL)
                
                do{
                    try responseData.write(to: URL(fileURLWithPath: storePath))
                    print("json file path: \(storePath)")
                    weakSelf.readJSONFileWith(path: storePath, closure: completionHandler)
                }catch{
                    
                }

            }
        }
        task.resume()
            
    }
    
    private func removeExistingFileAndReturnNewPathWith(fileUrl: String) -> String{
        
        let jsonFileName: String = fileUrl.lastPathComponent()
        let storePath: String = CommomUtility().writeJSONWith(fileName: jsonFileName)
        
        if FileManager.default.fileExists(atPath: storePath){
            do{
                try FileManager.default.removeItem(at: URL(fileURLWithPath: storePath))
                
            }catch{
                print("Fails to remove")
            }
        }
        
        return storePath
    }
    
    //MARK:--------Read JSON file------------//
    private func readJSONFileWith(path: String, closure: @escaping (_ status: Bool) -> Void){
        do{
            let jsonStr = try String(contentsOf: URL(fileURLWithPath: path), encoding: .ascii)
           // let jsonData: Data = try Data(contentsOf: URL(fileURLWithPath: path)) //Didn't get proper data
            guard let jsonData: Data = jsonStr.data(using: .utf8) else {
                self.list = nil
                closure(false)
                return
            }
            let parseInfo = self.dataModel?.parsedMetaDataWith(data: jsonData)
            
            if let _title = parseInfo?.title{
                self.title = _title
            }else{
                self.title = "Country"
            }
            
            guard let array = parseInfo?.list else {
                self.list = nil
                closure(false)
                return
            }
            self.list = array.compactMap({ (model) -> TableCellViewModel in
                return TableCellViewModel(title: model.title, description: model.description, imageHref: model.imageHref, identifier: CommomUtility().uniqueTaskIdentifier())
            })
            closure(true)
        }catch{
            self.list = nil
            closure(false)
        }
  }
    
    deinit {
        print("ViewModel dealloc")
    }
    
}
