//
//  APIRequestDelegate.swift
//  Cosapp
//
//  Created by APPLE on 3/22/17.
//  Copyright © 2017 APPLE. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol  APIRequestDelegate {
    
    func requestWillBegin() -> Void
    func requestDidCompleteWithResponse(_ response: JSON)
    func requestDidTerminateWithError(_ error: NSError?)
}
