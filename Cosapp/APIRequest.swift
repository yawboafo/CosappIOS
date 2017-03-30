//
//  APIRequest.swift
//  Cosapp
//
//  Created by APPLE on 3/21/17.
//  Copyright © 2017 APPLE. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class APIRequest {
    
    static let BASE_URL = "http://api.ecoachlabs.com/v1/cosapp/api.php"
    

    
    
    static func makeRequestWithUrl(_ urlString: String, usingHttpMethod httpMethod: Alamofire.HTTPMethod, withParameters parameters: [String:Any]?,  andRegisterRequestDelegate delegate: APIRequestDelegate!) -> Void{
        
        
        
        
        
        
        var headers = [String:String]()
        headers["Content-Type"] = "application/x-www-form-urlencoded"
        headers["auth_key"] = "" 
        
        // Invokes delegate's requestWillBegin to execute custom logic if delegate is registered for callbacks
        if delegate != nil{
            delegate.requestWillBegin()
            print("REQUEST URL : \(urlString)")
            print("REQUEST METHOD : \(httpMethod)")
            print("REQUEST PAYLOAD : \(parameters)")
            print("REQUEST HEADERS : \(headers)")
        }
        
        
        
        
        // Makes HTTP request with Alamofire
        Alamofire.request(urlString, method: httpMethod, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                switch response.result{
                case .success:
                    if delegate != nil{
                        // Invokes delegates requestDidComplete callback function if registered and passes resqponse as argument
                        delegate.requestDidCompleteWithResponse(JSON(response.result.value!))
                    }
                case .failure(let error):
                    if delegate != nil{
                        // Invokes delegate's requestDidTerminate callback function if registered and passes error as argument
                        delegate.requestDidTerminateWithError(error as NSError?)
                    }
                }
        }
        
    }
    
    
    
    
    static func getCompanyCategories(withParameters parameters: [String:AnyObject], andRegisterRequestDelegate delegate: APIRequestDelegate){
        
        
        
        print(parameters)
        
        APIRequest.makeRequestWithUrl(APIRequest.BASE_URL, usingHttpMethod: .post, withParameters: parameters, andRegisterRequestDelegate: delegate)
        
    }
    
}

