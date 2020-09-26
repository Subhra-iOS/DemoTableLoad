//
//  MetaDataModel.swift
//  DemoLoad
//
//  Created by Subhra Roy on 26/09/20.
//

import Foundation

protocol MetaDataParsingProtocol {
    func parsedMetaDataWith(data: Data?) -> (title: String?, list: [ItemModel]?)
}
//MARK:----------JSON codable structure for parsing---------//
struct MetaDataModel: Codable {
     var title: String?
     var rows: [ItemModel]?
    private enum CodingKeys: String, CodingKey{
        case title = "title"
        case rows = "rows"
    }
}

struct ItemModel: Codable {
    
    var title: String?
    var description: String?
    var imageHref: String?
     var identifier: String? {
        return CommomUtility().uniqueTaskIdentifier()
    }
    
    private enum CodingKeys: String, CodingKey{
        case title = "title"
        case description = "description"
        case imageHref = "imageHref"
    }
    
}
//MARK:-----------Data Model to retain Data in memory--------//
struct DataModel {
    var title: String?
    var list: [ItemModel]?
}

//MARK:------------Data Parsing Protocol----------//
extension DataModel: MetaDataParsingProtocol {
    
    func parsedMetaDataWith(data: Data?) -> (title: String?, list: [ItemModel]?) {
        
        do{
            if let responseData: Data = data {
                //******To check JSON Data*****//
                //*****Every time it gives follwoing error****//
                //*** The data couldn’t be read because it isn’t in the correct format.****//
                //****Fails at following JSONSerialization function and go to catch block****//
                let resultDict: Any = try JSONSerialization.jsonObject(with: responseData, options: [])
                guard let dict: [String : Any] = resultDict as? [String : Any] else{
                    return  (title: nil, list: nil)
                }
                
                print("\(dict)")
                
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .useDefaultKeys
                let  parseObject : MetaDataModel  = try jsonDecoder.decode(MetaDataModel.self, from: responseData)
                if let _title: String =  parseObject.title, let result: [ItemModel] = parseObject.rows{
                    return  (title: _title, list: result)
                }else{
                    return  (title: nil, list: nil)
                }
            }else {
                return (title: nil, list: nil)
            }
        }catch let error{
            print("\(error.localizedDescription)")
            return (title: nil, list: nil)
        }
    }
    
}
