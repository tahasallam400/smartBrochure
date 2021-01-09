//
//  Album.swift
//  smartBrochure
//
//  Created by taha abdelrahman on 4/29/18.
//  Copyright © 2018 taha abdelrahman. All rights reserved.
//

import Foundation
import CoreData

extension Album{
    
   class func add(albumParserList:[AlbumParser]){
        albumParserList.forEach{(albumParser) in
            if Update(album:albumParser) == nil{
                if let entity = NSEntityDescription.entity(forEntityName: "Album", in: managedContext){
                    let albumObject = Album(entity: entity, insertInto: managedContext)
                    albumObject.id = Int32(albumParser.Id ?? 0)
                    albumObject.name = albumParser.Name
                    if let albumPhotoList = albumParser.photos{
                        let photoContentList = Photo.add(photoItems: albumPhotoList)
                        albumObject.photo = NSSet(array: photoContentList)
                        
                    }
                    do{
                        try managedContext.save()
                    }catch{
                    }
                }
            }
            
        }
    }
    
    private class func Update(album:AlbumParser?) -> Album?{
        if let album = album{
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Album")
            fetch.predicate = NSPredicate(format:" id = %@",NSNumber(value: album.Id ?? 0) )
            var object:Album?
            do{
                if let list =  try managedContext.fetch(fetch) as? [Album]{
                    object = list.last
                    
                    object?.name = album.Name
                    if let albumPhotoList = album.photos{
                        let photoContentList = Photo.add(photoItems: albumPhotoList)
                        object?.photo = NSSet(array: photoContentList)
                        
                    }
                    try managedContext.save()
                }
            }catch{
            }
            return object
        }
      return nil
    }
    
    class func list() -> [Album]?{
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Album")
        do{
            if let list =  try managedContext.fetch(fetch) as? [Album]{
                return list
            }
        }catch{
        }
        return nil
    }
    
}

