//
//  CategoryContent.swift
//  smartBrochure
//
//  Created by taha abdelrahman on 4/28/18.
//  Copyright © 2018 taha abdelrahman. All rights reserved.
//

import Foundation
import SwiftyJSON
class CategoryContentParser:APIProtocol{
 
    enum key:String {case Id = "Id" ,Title = "Title",Body = "Body" ,Date = "Date", CanComment = "CanComment" ,Pic = "Pic"}
    
    var Id:Int?
    var Title :String?
    var Date:String?
    var CanComment:Bool?
    var Body:String?
    var Pic:String?
    
    required init (json:JSON){
        self.Id = json[key.Id.rawValue].int
        self.Title = json[key.Title.rawValue].string
        self.Date = json[key.Date.rawValue].string
        self.CanComment = json[key.CanComment.rawValue].bool
        self.Pic = json[key.Pic.rawValue].string
        self.Body = json[key.Body.rawValue].string
    }
}

extension CategoryContentParser{
    class func getCategoryContent(categoryID:Int ,completion:@escaping([CategoryContentParser]?,Error?)->Void){
        APICaller<CategoryContentParser>.call(url: url.baseURL.rawValue + url.getContentForSpecifcCategory.rawValue + String(categoryID), completion: {list ,error in
            completion(list,error)
        })
    }
}
