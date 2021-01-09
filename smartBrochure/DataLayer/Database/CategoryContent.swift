//
//  CategoryContent.swift
//  smartBrochure
//
//  Created by taha abdelrahman on 4/29/18.
//  Copyright © 2018 taha abdelrahman. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension CategoryContent{
    
    class func add(categoryContentParserList:[AllCategoryContentParser],language:String)->[CategoryContent]?{
        var categoryContentList = [CategoryContent]()
        categoryContentParserList.forEach{(categoryContentParser) in
            let updateItem:CategoryContent? = Update(categoryContent:categoryContentParser,language:language)
            if  updateItem == nil{
                if let entity = NSEntityDescription.entity(forEntityName: "CategoryContent", in: managedContext){
                    let categoryContentObject = CategoryContent(entity: entity, insertInto: managedContext)
                    categoryContentObject.body = categoryContentParser.body
                    categoryContentObject.canComment = categoryContentParser.canComment ?? false
                    categoryContentObject.date = categoryContentParser.date
                    categoryContentObject.id = Int32(categoryContentParser.id ?? 0)
                    categoryContentObject.isfromUser = categoryContentParser.isfromUser ?? false
                   categoryContentObject.lang = language
                    do{
                        if let url = URL(string: url.baseURL.rawValue + "/" + (categoryContentParser.photo ?? "")){
                            let imagedata = try Data(contentsOf: url)
                            categoryContentObject.photo = UIImage(data:imagedata,scale:1.0)
                            
                        }
                        categoryContentObject.title = categoryContentParser.title
                        try managedContext.save()
                    }catch{
                    }
                    categoryContentList.append(categoryContentObject)
                    
                }
            }else{
              categoryContentList.append(updateItem!)  
            }
        }
        return categoryContentList
    }
    
    private class func Update(categoryContent:AllCategoryContentParser?,language:String) -> CategoryContent?{
        if let categoryContent = categoryContent{
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CategoryContent")
            fetch.predicate = NSPredicate(format:" id = %@",NSNumber(value: categoryContent.id ?? 0))
            var object:CategoryContent?
            do{
                if let list =  try managedContext.fetch(fetch) as? [CategoryContent]{
                    object = list.last
                    object?.body = categoryContent.body
                    object?.canComment = categoryContent.canComment ?? false
                    object?.date = categoryContent.date
                    object?.lang = language
                    object?.isfromUser = categoryContent.isfromUser ?? false
                    do{
                        if let url = URL(string: url.baseURL.rawValue + "/" + (categoryContent.photo ?? "")){
                            let imagedata = try Data(contentsOf: url)
                            object?.photo = UIImage(data:imagedata,scale:1.0)
                            
                        }
                        object?.title = categoryContent.title
                        try managedContext.save()
                    }
                }
            }catch{
            }
            return object
        }
       return nil
    }
    
    
}



