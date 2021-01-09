//
//  AllCategoryContentParser.swift
//  smartBrochure
//
//  Created by taha abdelrahman on 4/28/18.
//  Copyright © 2018 taha abdelrahman. All rights reserved.
//

import Foundation
import SwiftyJSON

class AllCategoryContentParser:APIProtocol{
    
    enum key:String  {case Id = "Id",
        Title = "Title" , Body = "Body", Date = "Date", CanComment = "CanComment", UserId = "UserId", Photo = "Photo", CategoryName = "CategoryName", IsfromUser = "IsfromUser"}
    
    var id:Int?
    var title :String?
    var body:String?
    var date:String?
    var canComment:Bool?
    var userId:Int?
    var photo:String?
    var categoryName:String?
    var isfromUser:Bool?
    
    required init (json:JSON){
        self.id = json[key.Id.rawValue].int
        self.title = json[key.Title.rawValue].string
        self.body = json[key.Body.rawValue].string
        self.date = json[key.Date.rawValue].string
        self.canComment = json[key.CanComment.rawValue].bool
        self.userId = json[key.UserId.rawValue].int
        self.photo = json[key.Photo.rawValue].string
        self.categoryName = json[key.CategoryName.rawValue].string
        self.isfromUser = json[key.IsfromUser.rawValue].bool
        
    }
}



