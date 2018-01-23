//
//  Tweet.swift
//  d04
//
//  Created by Aymeric TOULOUSE on 1/13/18.
//  Copyright © 2018 Aymeric TOULOUSE. All rights reserved.
//

import Foundation

struct Tweet {
    let name : String
    let text : String
    let date : String
    
    var description: String {
        return "\(name): \(text)"
    }
}
