//
//  UserPeference.swift
//  smartBrochure
//
//  Created by TAHA SALLAM on 5/4/18.
//  Copyright © 2018 taha abdelrahman. All rights reserved.
//

import Foundation
class UserPeference{
    private struct Preferenceskeys {
        static let AppThemeNumberKey = "AppThemeNumber"
        static let launchedBeforeKey = "launchedBefore"
    }
    
   class var launchedBefore: Bool {
        get{
            let launchedBefore =  Bool(UserDefaults.standard.bool(forKey: Preferenceskeys.launchedBeforeKey))
            return launchedBefore
        }
        set{
            UserDefaults.standard.set(Bool(newValue), forKey: Preferenceskeys.launchedBeforeKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    class func currentLanguage() -> String{
        if let currentLanguage = UserDefaults.standard.string(forKey: "CurrentLanguage"){
            return currentLanguage
        }else{
            setCurrentLanguage(currentLanguage: "ar")
            return "ar"
        }
    }
    
    class func setCurrentLanguage(currentLanguage:String){
        UserDefaults.standard.set(currentLanguage, forKey:"CurrentLanguage" )
    }

}

