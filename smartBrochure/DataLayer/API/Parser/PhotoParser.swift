//
//  PhotoParser.swift
//  smartBrochure
//
//  Created by taha abdelrahman on 4/28/18.
//  Copyright © 2018 taha abdelrahman. All rights reserved.
//

import Foundation
import SwiftyJSON
class PhotoParser:APIProtocol{
    
    enum key:String{case Id = "Id" , Description = "Description" , Path = "Path"}
    
    var Id:Int?
    var Description:String?
    var Path:String?
    
    required init (json:JSON){
        self.Id = json[key.Id.rawValue].int
        self.Description = json[key.Description.rawValue].string
        self.Path = json[key.Path.rawValue].string
    }
}

