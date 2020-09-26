//
//  String+Utility.swift
//  DemoLoad
//
//  Created by Subhra Roy on 26/09/20.
//

import Foundation

extension String{
    
    func  lastPathComponent() -> String{
        
        let lastPath : String = URL(fileURLWithPath: self).lastPathComponent
        return lastPath
        
    }
}
