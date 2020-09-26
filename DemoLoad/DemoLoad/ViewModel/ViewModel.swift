//
//  ViewModel.swift
//  DemoLoad
//
//  Created by Subhra Roy on 26/09/20.
//

import Foundation

class ViewModel {
    public private(set) var list: [ItemModel]?
    public private(set) var title: String?
    public private(set) var dataModel: DataModel?

    
    init(_dataModel: DataModel) {
        self.dataModel = _dataModel
    }
    
    func fetchMetaDataFromServerWith(_ completionHandler: @escaping (_ status: Bool) -> Void){
        let fileURL : String = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        let session = URLSession(configuration: .default)
        let request: URLRequest = URLRequest(url: URL(string: fileURL)!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 120)
        let task = session.dataTask(with: request) { [weak self] (data, _ , error) in
            
            guard let weakSelf = self else {
                completionHandler(false)
                return
            }
            
            print("\(String(describing: String(data: data!, encoding: .utf8)))")
            
            if let _ = error {
                completionHandler(false)
            }else{
                
                guard let responseData: Data = data else {
                    completionHandler(false)
                    return
                }
                
                let jsonFile: String = fileURL.lastPathComponent()
                let storePath: String = CommomUtility().writeJSONWith(fileName: jsonFile)
               
                DispatchQueue.global(qos: .background).async {
                    do{
                        try responseData.write(to: URL(fileURLWithPath: storePath))
                        weakSelf.readJSONFileWith(path: storePath, closure: completionHandler)
                    }catch{
                        
                    }
                }

            }
        }
        task.resume()
            
    }
    
    private func readJSONFileWith(path: String, closure: @escaping (_ status: Bool) -> Void){
        do{
            let jsonData: Data = try Data(contentsOf: URL(fileURLWithPath: path))
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
            self.list = array
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
