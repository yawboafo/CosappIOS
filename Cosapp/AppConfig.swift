//
//  AppConfig.swift
//  Cosapp
//
//  Created by APPLE on 3/22/17.
//  Copyright © 2017 APPLE. All rights reserved.
//

import Foundation
import SwiftyJSON

class AppConfig {


    
    static let company_categories = "company_categories"
    static let company_registered = "company_registered"
    
    static let selected_category_id = "selected_category_id"
    static let selected_category_Name = "selected_category_Name"
    static let selected_company_name = "selected_company_name"
    static let selected_company_id = "selected_company_id"
    
    static func setcompany_categories(_ response : JSON){
        
        let defaults = UserDefaults.standard
        defaults.setValue(response.rawString()!, forKeyPath: AppConfig.company_categories)
        
        
    }
    static func getcompany_categories() -> JSON {
        
        
        
        if let nsdd = UserDefaults.standard.value(forKey: AppConfig.company_categories) as? String{
            
            
            
            return JSON.parse(nsdd as! String)
        }else{
            
            
            return nil
            
            
        }
        
        
        
        
        
        
        
        
    }
    
    
    static func setcompany_registered(_ response : JSON){
        
        let defaults = UserDefaults.standard
        defaults.setValue(response.rawString()!, forKeyPath: AppConfig.company_registered)
        
        
    }
    static func getcompany_registered() -> JSON {
        
        
        
        if let nsdd = UserDefaults.standard.value(forKey: AppConfig.company_registered) as? String{
            
            
            
            return JSON.parse(nsdd as! String)
        }else{
            
            
            return nil
            
            
        }
        
        
        
        
        
        
        
        
    }
    
    static func setselected_company_id( id : String){
        
        let defaults = UserDefaults.standard
        defaults.setValue(id, forKeyPath: AppConfig.selected_company_id)
    }
    static func getselected_company_id() -> String{
        
        
        if let nsdd = UserDefaults.standard.value(forKey: AppConfig.selected_company_id) as? String{
            
            
            
            return nsdd.description
        }else{
            
            
            return ""
            
            
        }
        
        
        
    }
    
    
    static func setselected_category_id( id : String){
    
        let defaults = UserDefaults.standard
        defaults.setValue(id, forKeyPath: AppConfig.selected_category_id)
    }
    static func getselected_category_id() -> String{
    
        
        if let nsdd = UserDefaults.standard.value(forKey: AppConfig.selected_category_id) as? String{
            
            
            
            return nsdd.description
        }else{
            
            
            return ""
            
            
        }
        

    
    }
    
    
    static func setselected_company_name( id : String){
        
        let defaults = UserDefaults.standard
        defaults.setValue(id, forKeyPath: AppConfig.selected_company_name)
    }
    static func getselected_company_name() -> String{
        
        
        if let nsdd = UserDefaults.standard.value(forKey: AppConfig.selected_company_name) as? String{
            
            
            
            return nsdd.description
        }else{
            
            
            return ""
            
            
        }
        
        
        
    }
    
    
    static func setselected_category_Name( id : String){
        
        let defaults = UserDefaults.standard
        defaults.setValue(id, forKeyPath: AppConfig.selected_category_Name)
    }
    static func getselected_category_Name() -> String{
        
        
        if let nsdd = UserDefaults.standard.value(forKey: AppConfig.selected_category_Name) as? String{
            
            
            
            return nsdd.description
        }else{
            
            
            return ""
            
            
        }
        
        
        
    }
}
