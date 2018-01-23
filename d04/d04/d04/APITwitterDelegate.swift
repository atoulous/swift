//
//  APITwitterDelegate.swift
//  d04
//
//  Created by Aymeric TOULOUSE on 1/13/18.
//  Copyright © 2018 Aymeric TOULOUSE. All rights reserved.
//

import Foundation

protocol APITwitterDelegate: class {
    func handleTweets(tweets: [Tweet])
    func handleError(error: NSError)
}
