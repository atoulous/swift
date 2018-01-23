//
//  Article+CoreDataProperties.swift
//  atoulous2018
//
//  Created by Aymeric TOULOUSE on 1/18/18.
//
//

import CoreData

extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var lang: String?
    @NSManaged public var image: NSData?
    @NSManaged public var creationDate: NSDate?
    @NSManaged public var modificationDate: NSDate?

}
