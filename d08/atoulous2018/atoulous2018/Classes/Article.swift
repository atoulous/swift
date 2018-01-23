//
//  Article+CoreDataClass.swift
//  atoulous2018
//
//  Created by Aymeric TOULOUSE on 1/18/18.
//
//

import CoreData

@objc(Article)
public class Article: NSManagedObject {
    
    override public var description: String {
        return "Title : \(String(describing: title))\ncontent : \(String(describing: content))\nlang : \(String(describing: lang))\ncreationDate : \(String(describing: creationDate))"
    }
}
