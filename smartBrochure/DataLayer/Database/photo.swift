//
//  photo.swift
//  smartBrochure
//
//  Created by taha abdelrahman on 4/29/18.
//  Copyright © 2018 taha abdelrahman. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension Photo{
    
    class  func add(photoItems:[PhotoParser])->[Photo]{
        var photoList = [Photo]()
        photoItems.forEach{(photo) in
            let updatedItem = Update(photo: photo)
            if updatedItem == nil{
                if let entity = NSEntityDescription.entity(forEntityName: "Photo", in: managedContext){
                    let photoObject = Photo(entity: entity, insertInto: managedContext)
                    photoObject.id = Int32(photo.Id ?? 0)
                    do{
                        if let url = URL(string:url.baseURL.rawValue + "/" +  (photo.Path ?? "")){
                            let imagedata = try Data(contentsOf: url)
                            photoObject.path = UIImage(data:imagedata,scale:1.0)
                        }
                        photoObject.description_ = photo.Description
                        
                        try managedContext.save()
                    }catch{
                    }
                    photoList.append(photoObject)
                }
            }else{
                photoList.append(updatedItem!)
            }
        }
        
        return photoList
    }
    
    private class func Update(photo:PhotoParser?) -> Photo?{
        if let photo = photo{
         
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
            fetch.predicate = NSPredicate(format:" id = %@",NSNumber(value:  photo.Id ?? 0))
            var object:Photo?
            do{
                if let list =  try managedContext.fetch(fetch) as? [Photo]{
                    object = list.last
                    if let url = URL(string: url.baseURL.rawValue + "/" + (photo.Path ?? "")){
                        let imagedata = try Data(contentsOf: url)
                        object?.path = UIImage(data:imagedata,scale:1.0)
                    }
                    object?.description_ = photo.Description
                    try managedContext.save()
                }
            }catch{
            }
            return object
        }
        return nil
    }
}



