//
//  CategoryParser.swift
//  smartBrochure
//
//  Created by taha abdelrahman on 4/28/18.
//  Copyright © 2018 taha abdelrahman. All rights reserved.
//
import Foundation
import SwiftyJSON
class CategoryParser:APIProtocol{
    
    enum key:String{
        case Id = "Id" , Name = "Name" , Type_ = "Type" , Pic = "Pic"
    }
    
    var Id:Int?
    var Name:String?
    var Type_:String?
    var Pic:String?
    
    required init(json:JSON){
        self.Id = json[key.Id.rawValue].int
        self.Name = json[key.Name.rawValue].string
        self.Type_ = json[key.Type_.rawValue].string
        self.Pic = json[key.Pic.rawValue].string
    }
}

extension CategoryParser{
    
        class func ListAllCategory(completion:@escaping([CategoryParser]?,Error?)->Void){
            APICaller<CategoryParser>.call(url: url.baseURL.rawValue + url.getCategory.rawValue, completion: {list ,error in
                completion(list,error)
            })
        }
    
}
