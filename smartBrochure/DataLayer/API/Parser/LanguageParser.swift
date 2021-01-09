//
//  Language.swift
//  smartBrochure
//
//  Created by taha abdelrahman on 4/28/18.
//  Copyright © 2018 taha abdelrahman. All rights reserved.
//

import Foundation
import SwiftyJSON
class LanguageParser:APIProtocol{
    
    enum key:String {
       case Id = "Id" , Name = "Name",UniqueSeoCode = "UniqueSeoCode"
    }
    
    var Id:Int?
    var Name:String?
    var UniqueSeoCode:String?
    
   required init(json:JSON){
        self.Id = json[key.Id.rawValue].int
        self.Name = json[key.Name.rawValue].string
        self.UniqueSeoCode = json[key.UniqueSeoCode.rawValue].string
    }
}

extension LanguageParser{
    class func ListAllLanguage(completion:@escaping([LanguageParser]?,Error?)->Void){
        APICaller<LanguageParser>.call(url: url.baseURL.rawValue + url.GetLanguages.rawValue, completion: {list ,error in
            completion(list,error)
        })
    }
}
