//
//  AlbumParser.swift
//  smartBrochure
//
//  Created by taha abdelrahman on 4/28/18.
//  Copyright © 2018 taha abdelrahman. All rights reserved.
//

import Foundation
import SwiftyJSON
class AlbumParser:APIProtocol{
    
    enum key:String {case Id = "Id" , Name = "Name" , Photos = "Photos"}
    
    var Id :Int?
    var Name:String?
    var photos:[PhotoParser]? = [PhotoParser]()
    
    required init (json:JSON){
        self.Id = json[key.Id.rawValue].int
        self.Name = json[key.Name.rawValue].string
        if let photoList = json[key.Photos.rawValue].array{
            for photoItem in photoList{
                let photo = PhotoParser(json: photoItem)
                photos?.append(photo)
            }
        }
    }
}

extension AlbumParser{
    class func listAllAlbum(completion:@escaping([AlbumParser]?,Error?)->Void){
        APICaller<AlbumParser>.call(url: url.baseURL.rawValue + url.getAllAlbum.rawValue, completion: {list ,error in
            completion(list,error)
        })
    }
}
