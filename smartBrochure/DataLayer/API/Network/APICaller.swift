//
//  APICaller.swift
//  smartBrochure
//
//  Created by taha abdelrahman on 4/29/18.
//  Copyright © 2018 taha abdelrahman. All rights reserved.
//
import Foundation
import SwiftyJSON
import Alamofire
class APICaller<ClassType:APIProtocol>{
    
    class func call(url:String,completion:@escaping([ClassType]?,Error?)->Void){
        Alamofire.request(url).validate().responseJSON(completionHandler: { response in
            var listResulte = [ClassType]()
            
            switch response.result{
            case .success:
                if let resulteValue = response.result.value{
                    if let jsonArray = JSON(resulteValue).array {
                        for jsonItem in jsonArray{
                            let classParser = ClassType(json:jsonItem)
                            listResulte.append(classParser)
                        }
                    }
                }
                completion(listResulte,nil)
                break
            case .failure(let error):
                
                completion(nil,error)
                break
            }
        })
    }
}
enum url:String{
    case
    baseURL = "http://lite.zagel-app.com",
    GetLanguages = "/api/HomePageapi/GetLanguages",
    getCorporation = "/api/HomePageapi/getCorporation/1?Lang=",
    getCategory = "/api/HomePageApi/getCategory",
    getAllAlbum = "/api/HomePageapi/GetAlbums",
    getSliderImage = "/api/HomePageApi/getPhotos?Lang=",
    getContentForSpecifcCategory = "/api/ContentCategoryApi/getCategoryContent?catID=",
    getAllCategoryWithContent = "/api/HomePageapi/GetCategoriesData?Lang="
    
}
