//
//  DataHub.swift
//  smartBrochure
//
//  Created by taha abdelrahman on 4/29/18.
//  Copyright © 2018 taha abdelrahman. All rights reserved.
//

import Foundation
import Localize_Swift
class DataHub{
    
    private  static var error:Error?
    private class func ListAllLanguage(resulte:@escaping([Language]?,Error?)->Void){
        LanguageParser.ListAllLanguage(completion: {list ,error in
            if let list = list{
                Language.add(languageList: list)
            }
            DataHub.error = error
            let list = Language.list()
            resulte(list,DataHub.error)
        })
    }
    
    private class func ListAllCorporation(resulte:@escaping([Corporation]?,Error?)->Void){
        CorporationParser.ListAllCorporation(language:UserPeference.currentLanguage(), completion: {list ,error in
            if let list = list{
                Corporation.add(corporationList: list, language: UserPeference.currentLanguage())
            }
            DataHub.error = error
            let list = Corporation.list(language: UserPeference.currentLanguage())
            resulte(list,DataHub.error)
        })
    }
    
    private class func listAllAlbum(resulte:@escaping([Album]?,Error?)->Void){
        AlbumParser.listAllAlbum(completion: {list ,error in
            if let list = list{
                Album.add(albumParserList: list)
            }
            DataHub.error = error
            let list = Album.list()
            resulte(list,DataHub.error)
        })
    }
    
    private class func listSlider(resulte:@escaping([Slider]?,Error?)->Void){
        SliderParser.listSlider(BaseLanguage: UserPeference.currentLanguage(), completion: {list ,error in
            if let list = list{
                Slider.add(sliderParserList: list, language: UserPeference.currentLanguage())
            }
            DataHub.error = error
            let list = Slider.list(language: UserPeference.currentLanguage())
            resulte(list,DataHub.error)
        })
    }
    
    private class func allCategoryWithContent(activityIndicator:UIActivityIndicatorView? = nil,resulte:@escaping([Category]?,Error?)->Void){
        AllCategoryParser.allCategoryWithContent(language: UserPeference.currentLanguage(), completion: {list ,error in
            if let list = list{
                Category.add(categoryList: list, language: UserPeference.currentLanguage())
            }
            DataHub.error = error
            let list = Category.list(language: UserPeference.currentLanguage())
            resulte(list,DataHub.error)
            if let activityIndicator = activityIndicator{
                activityIndicator.removeFromSuperview()
            }
            
        })
    }
    
    class func loadData(activityIndicator:UIActivityIndicatorView? = nil){
       HomeController.activityIndicator.startAnimating()
        DispatchQueue.global(qos: .background).async {
            ListAllLanguage(resulte: {_ , _ in  print("load all language")})
            ListAllCorporation(resulte: {_ , _ in print("load corporation") })
            allCategoryWithContent(resulte: {_,_ in print("load all category")})
            listSlider(resulte: {_,_ in  print("load list silder")})
            listAllAlbum(resulte: {_,_ in print("list all album ++++");HomeController.activityIndicator.stopAnimating(); HomeController.updateCollectionView = true})
        }
    }
}


