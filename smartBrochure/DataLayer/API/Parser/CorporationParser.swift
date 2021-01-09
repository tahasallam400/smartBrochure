//
//  CorporationParser.swift
//  smartBrochure
//
//  Created by taha abdelrahman on 4/28/18.
//  Copyright © 2018 taha abdelrahman. All rights reserved.
//
import Foundation
import SwiftyJSON
class CorporationParser:APIProtocol{
    
    enum key:String{
    case Id = "Id", Name = "Name" , Pic = "Pic"
    }
    
    var Id:Int?
    var Name:String?
    var pic:String?
    
    required init(json:JSON){
        self.Id = json[key.Id.rawValue].int
        self.Name = json[key.Name.rawValue].string
        self.pic = json[key.Pic.rawValue].string
    }
}

extension CorporationParser{
    class func ListAllCorporation(language:String,completion:@escaping([CorporationParser]?,Error?)->Void){
        APICaller<CorporationParser>.call(url: url.baseURL.rawValue + url.getCorporation.rawValue + language, completion: {list ,error in
            completion(list,error)
        })
    }
}

