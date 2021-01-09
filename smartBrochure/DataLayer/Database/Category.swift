//
//  Category.swift
//  smartBrochure
//
//  Created by taha abdelrahman on 4/29/18.
//  Copyright © 2018 taha abdelrahman. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension Category{
    class func add(categoryList:[AllCategoryParser],language:String){
        categoryList.forEach{(category) in
            if Update(category:category,language:language) == nil{
                if let entity = NSEntityDescription.entity(forEntityName: "Category", in: managedContext){
                    let categoryObject = Category(entity: entity, insertInto: managedContext)
                    categoryObject.id = Int32(category.CategoryId ?? 0)
                    categoryObject.name = category.Name ?? ""
                    do{
                        if let url = URL(string: url.baseURL.rawValue + "/" + (category.Pic ?? "")){
                            let imagedata = try Data(contentsOf: url)
                            categoryObject.pic = UIImage(data:imagedata,scale:1.0)
                        }
                        categoryObject.lang = language
                        categoryObject.type = category.Type_ ?? ""
                        if let categoryContentList = category.contentList{
                            if let categoryContentList = CategoryContent.add(categoryContentParserList: categoryContentList, language: language){
                                categoryObject.category = NSSet(array: categoryContentList)
                            }
                        }
                        try managedContext.save()
                    }catch{
                    }
                }
            }
        }
    }
    
    private class func Update(category:AllCategoryParser?,language:String) -> Category?{
        if let category = category{
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
            fetch.predicate = NSPredicate(format:" id = %@", NSNumber(value: category.CategoryId ?? 0) )
            var object:Category?
            do{
                if let list =  try managedContext.fetch(fetch) as? [Category]{
                    object = list.last
                    object?.name = category.Name
                    object?.lang = language
                    if let url = URL(string: url.baseURL.rawValue + "/" + (category.Pic ?? "")){
                        let imagedata = try Data(contentsOf: url)
                        object?.pic = UIImage(data:imagedata,scale:1.0)
                    }
                    object?.type = category.Type_ ?? ""
                    if let categoryContentList = category.contentList{
                        if let categoryContentList = CategoryContent.add(categoryContentParserList: categoryContentList, language: language){
                            object?.category = NSSet(array: categoryContentList)
                        }
                    }
                    try managedContext.save()
                }
            }catch{
            }
            return object
        }
       return nil
    }
    
    class func list(language:String) -> [Category]?{
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        fetch.predicate = NSPredicate(format: "lang = %@",NSString(string: language) )
        do{
            if let list =  try managedContext.fetch(fetch) as? [Category]{
                return list
            }
        }catch{
        }
        return nil
    }
}
