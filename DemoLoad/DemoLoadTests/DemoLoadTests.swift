//
//  DemoLoadTests.swift
//  DemoLoadTests
//
//  Created by Subhra Roy on 16/10/20.
//

import XCTest
@testable import DemoLoad

class DemoLoadTests: XCTestCase {

    var viewModel: ViewModel!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let dataModel: DataModel = DataModel()
        self.viewModel = ViewModel(_dataModel: dataModel)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testValidateItems(){
       
        let bundle = Bundle(for: DemoLoadTests.self)
        do{
            let jsonStr: String = try String(contentsOf: URL(fileURLWithPath: bundle.path(forResource: "facts", ofType: "json")!), encoding: .ascii)
           
            guard let jsonData: Data = jsonStr.data(using: .utf8) else {
                XCTAssertFalse(false)
                return
            }
            let parseInfo = self.viewModel.dataModel!.parsedMetaDataWith(data: jsonData)
            
        
            guard let array = parseInfo.list else {
                XCTAssertFalse(false)
                return
            }
            self.viewModel.list = array.compactMap({ (model) -> TableCellViewModel in
                return TableCellViewModel(title: model.title, description: model.description, imageHref: model.imageHref, identifier: CommomUtility().uniqueTaskIdentifier())
            })
           
           // XCTAssertTrue(self.viewModel.list!.count == 0 , "No List")
            XCTAssertTrue(self.viewModel.list!.count > 0 , "List found")
        }catch{
           
        }
    }

}
