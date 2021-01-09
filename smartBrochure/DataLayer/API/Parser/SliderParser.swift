//
//  SliderParser.swift
//  smartBrochure
//
//  Created by taha abdelrahman on 4/28/18.
//  Copyright © 2018 taha abdelrahman. All rights reserved.
//

import Foundation
import SwiftyJSON

class SliderParser:APIProtocol{

    enum key:String {case Id = "Id" , Description = "Description" ,Order = "Order" , Pic = "Pic"}
    
    var Id:Int?
    var Description:String?
    var Order:Int?
    var Pic:String?
    
    required init(json:JSON){
        self.Id = json[key.Id.rawValue].int
        self.Description = json[key.Description.rawValue].string
        self.Order = json [key.Order.rawValue].int
        self.Pic = json[key.Pic.rawValue].string 
    }
}

extension SliderParser{
    class func listSlider(BaseLanguage language:String,completion:@escaping([SliderParser]?,Error?)->Void){
        APICaller<SliderParser>.call(url: url.baseURL.rawValue + url.getSliderImage.rawValue + language, completion: {list ,error in
            completion(list,error)
        })
    }
}
