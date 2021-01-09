//
//  Corporation.swift
//  smartBrochure
//
//  Created by taha abdelrahman on 4/29/18.
//  Copyright © 2018 taha abdelrahman. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension Corporation{
    class func add(corporationList:[CorporationParser],language:String){
        corporationList.forEach{(corporation) in
            if Update(corporation: corporation, language: language) == nil{
                if let entityDescription = NSEntityDescription.entity(forEntityName: "Corporation", in: managedContext){
                    let corporationObjct = Corporation(entity: entityDescription, insertInto: managedContext)
                    corporationObjct.id = Int32(corporation.Id ?? 0)
                    corporationObjct.name = corporation.Name
                    corporationObjct.lang = language
            
                    do{
                        if let url = URL(string:url.baseURL.rawValue + "/" + (corporation.pic ?? "")){
                            let imagedata = try Data(contentsOf: url)
                            corporationObjct.pic = UIImage(data:imagedata)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
                        }
                        try managedContext.save()
                    }catch{
                    }
                }
            }
        }
    }

    private class func Update(corporation:CorporationParser?,language:String) -> Corporation?{
        if let corporation = corporation{
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Corporation")
            fetch.predicate = NSPredicate(format:" id = %@",NSNumber(value:corporation.Id ?? 0))
            var object:Corporation?
            do{
                if let list =  try managedContext.fetch(fetch) as? [Corporation]{
                    object = list.last
                    object?.name = corporation.Name
                    object?.lang = language
                    if let url = URL(string:url.baseURL.rawValue + "/" + (corporation.pic ?? "")) {
                        let imagedata = try Data(contentsOf: url)
                        object?.pic = UIImage(data:imagedata)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
                    }
                    try managedContext.save()
                }
            }catch let error{
            print(error.localizedDescription)
            }
            
            return object
        }
        return nil
    }
    
    class func list(language:String) -> [Corporation]?{
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Corporation")
        fetch.predicate = NSPredicate(format:  "lang = %@", NSString(string: language))
        do{
            if let list =  try managedContext.fetch(fetch) as? [Corporation]{
                return list
            }
        }catch{
        }
        return nil
    }
}
