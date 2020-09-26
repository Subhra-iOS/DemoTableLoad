//
//  FileDownloader.swift
//  DemoLoad
//
//  Created by Subhra Roy on 26/09/20.
//

import Foundation

typealias FileDownloaderHandler = (_ status : Bool, _ fileStorePath : String?, _  identifier: String?) -> Void

final class FileDownloader{
    
    private var downloadQueue: DispatchQueue = DispatchQueue(label: "com.download.Queue", attributes: .concurrent)
    private var _url: String?
    private var storePath: String?
    public   var operationStateHandler : FileDownloaderHandler?
    let downloadSession = URLSession(configuration: .default)
    private var identifier: String?
    
    init(url: String, filePath: String, taskIdentifier: String) {
        self._url = url
        self.storePath = filePath
        self.identifier = taskIdentifier
    }
    
    func downloadFile(){
    
        downloadQueue.async { [unowned self] in
            let task = downloadSession.dataTask(with: URL(string: self._url ?? "")!) { (data, _, error) in
                
                if let imageData: Data = data{
                    DispatchQueue.global(qos: .background).async {
                        do{
                            try imageData.write(to: URL(fileURLWithPath: self._url ?? ""), options: [])
                            self.operationStateHandler?(true, self.storePath, self.identifier)
                        }catch{
                            self.operationStateHandler?(false, self.storePath, self.identifier)
                        }
                    }
                }else{
                    self.operationStateHandler?(false, self.storePath, self.identifier)
                }
                
            }
            
            task.resume()
        }
        
    }
    
}
