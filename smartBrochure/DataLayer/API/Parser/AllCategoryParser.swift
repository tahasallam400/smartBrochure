//
//  allCategory.swift
//  smartBrochure
//
//  Created by taha abdelrahman on 4/28/18.
//  Copyright © 2018 taha abdelrahman. All rights reserved.
//

import Foundation
import SwiftyJSON

class AllCategoryParser:APIProtocol{
    
    enum key:String  {case CategoryId = "CategoryId", Name = "Name", Type_ = "Type",Pic = "Pic",Contents = "Contents"}
    
    var CategoryId:Int?
    var Name:String?
    var Type_:String?
    var Pic:String?
    var contentList:[AllCategoryContentParser]? = [AllCategoryContentParser]()
    
    required init(json:JSON){
        self.CategoryId = json[key.CategoryId.rawValue].int
        self.Name = json[key.Name.rawValue].string
        self.Type_ = json[key.Type_.rawValue].string
        self.Pic = json[key.Pic.rawValue].string
        if let contentList_ = json[key.Contents.rawValue].array{
            for contentItem in contentList_{
                let contentCategory = AllCategoryContentParser(json:contentItem)
                contentList?.append(contentCategory)
            }
        }
    }
    
}


extension AllCategoryParser{
    class func allCategoryWithContent(language:String,completion:@escaping([AllCategoryParser]?,Error?)->Void){
        APICaller<AllCategoryParser>.call(url: url.baseURL.rawValue + url.getAllCategoryWithContent.rawValue + language , completion: {list ,error in
            completion(list,error)
        })
    }
}
