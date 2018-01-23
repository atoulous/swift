//: A UIKit based Playground for presenting user interface
//
//  Request.swift
//  d04
//
//  Created by Aymeric TOULOUSE on 1/12/18.
//  Copyright © 2018 Aymeric TOULOUSE. All rights reserved.
//

import Foundation
import UIKit
//import XCPlaygroundPage

    let CUSTOMER_KEY = "A6Bwcyto78pbvRtAWpRcuOnVH"
    let CUSTOMER_SECRET = "EBjcOOuCQnQDqedWKNTm16AqF55LOdynd0moww5DeNWaYCMV25"
    let BEARER = ((CUSTOMER_KEY + ":" + CUSTOMER_SECRET).data(using: String.Encoding.utf8))!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    
    let url = NSURL(string: "https://api.twitter.com/oauth2/token")
    let request = NSMutableURLRequest(url: url! as URL)
    request.httpMethod = "POST"
    request.setValue("Basic " + BEARER, forHTTPHeaderField: "Authorization")
    request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
    let task = URLSession.shared.dataTask(with: request as URLRequest) {
        (data, response, error) in
        print(response!)
        if let err = error {
            print(err)
        }
        else if let d = data {
            do {
                if let dic : NSDictionary = try JSONSerialization.jsonObject(with: d) as? NSDictionary {
                    print(dic)
                }
            } catch (let err) {
                print(err)
            }
        }
    }
    task.resume()


//XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

