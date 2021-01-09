//
//  Language.swift
//  smartBrochure
//
//  Created by taha abdelrahman on 4/29/18.
//  Copyright © 2018 taha abdelrahman. All rights reserved.
//
import Foundation
import CoreData

extension Language{
    
    class func add(languageList:[LanguageParser]){
        languageList.forEach{(language) in
            if Update(language:language) == nil {
                if let entityDescription = NSEntityDescription.entity(forEntityName: "Language", in: managedContext){
                    let languageObject = Language(entity: entityDescription, insertInto: managedContext)
                    languageObject.id = Int32(language.Id ?? 0)
                    languageObject.name = language.Name ?? ""
                    languageObject.uniqueSeoCode = language.UniqueSeoCode ?? ""
                    do{
                        try managedContext.save()
                    }catch{
                    }
                }
            }
        }
    }
    
    private class func Update(language:LanguageParser?) -> Language?{
        if let language = language{
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Language")
            fetch.predicate = NSPredicate(format:" id = %@",NSNumber(value: language.Id ?? 0) )
            var object:Language?
            do{
                 let list =  try managedContext.fetch(fetch) as? [Language]
                if let list = list{
                    object = list.last
                    object?.name = language.Name
                    object?.uniqueSeoCode = language.UniqueSeoCode
                    try managedContext.save()
                }
                
            }catch{
            }
            return object
        }else{
            return nil
        }
    }
    
    class func list() -> [Language]?{
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Language")
        do{
            if let list =  try managedContext.fetch(fetch) as? [Language]{
               return list
            }
        }catch{
        }
        return nil
    }
}


