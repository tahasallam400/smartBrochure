//
//  slider.swift
//  smartBrochure
//
//  Created by taha abdelrahman on 4/29/18.
//  Copyright © 2018 taha abdelrahman. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension Slider{
    class func add(sliderParserList:[SliderParser],language:String){
        sliderParserList.forEach{(sliderParser) in
            if Update(slider:sliderParser, language: language) == nil{
                if let entity = NSEntityDescription.entity(forEntityName: "Slider", in: managedContext){
                    let slider = Slider(entity: entity, insertInto: managedContext)
                    slider.description_ = sliderParser.Description
                    slider.id = Int32(sliderParser.Id ?? 0)
                    slider.lang = language
                    slider.order = Int32(sliderParser.Order ?? 0)
                    do{
                        if let url = URL(string:url.baseURL.rawValue + "/" + (sliderParser.Pic ?? "")){
                            let imagedata = try Data(contentsOf: url)
                            slider.pic = UIImage(data:imagedata,scale:1.0)
                        }
                        try managedContext.save()
                        
                    }catch{
                    }
                }
            }
        }
    }
    
    private class func Update(slider:SliderParser?,language:String) -> Slider?{
        if let slider = slider{
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Slider")
            fetch.predicate = NSPredicate(format:" id = %@",NSNumber(value: slider.Id ?? 0) )
            var object:Slider?
            do{
                if let list =  try managedContext.fetch(fetch) as? [Slider]{
                    object = list.last
                    object?.description_ = slider.Description
                    object?.lang = language
                    object?.order = Int32(slider.Order ?? 0)
                    if let url = URL(string: url.baseURL.rawValue + "/" + (slider.Pic ?? "")){
                        let imagedata = try Data(contentsOf: url)
                        object?.pic = UIImage(data:imagedata,scale:1.0)
                    }
                    try managedContext.save()
                }
            }catch{
            }
            return object
        }
        return nil
    }
    
    class func list(language:String) -> [Slider]?{
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Slider")
         fetch.predicate = NSPredicate(format: "lang = %@", NSString(string: language) )
        let sort = NSSortDescriptor(key: #keyPath(Slider.order), ascending: true)
        fetch.sortDescriptors = [sort]
        do{
            if let list =  try managedContext.fetch(fetch) as? [Slider]{
                return list
            }
        }catch{
        }
        return nil
    }
}
