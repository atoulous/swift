//
//  ArticleManager.swift
//  atoulous2018
//
//  Created by Aymeric TOULOUSE on 1/18/18.
//

import CoreData

public class ArticleManager {
    
    public var managedObjectContext: NSManagedObjectContext
    
    public init() {
        
        //This resource is the same name as your xcdatamodeld contained in your project
        var modelURL: URL!
        if let bundleURL = Bundle(for: Article.self).url(forResource: "atoulous2018", withExtension: "bundle") {
            guard let frameworkBundle = Bundle(url: bundleURL) else {
                fatalError("Error loading bundle")
            }
            modelURL = frameworkBundle.url(forResource: "articleModel", withExtension: "momd")
        } else {
            modelURL = Bundle(for: Article.self).url(forResource: "articleModel", withExtension: "momd")
        }
        
        // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        
        managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = psc

        guard let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            fatalError("Unable to resolve document directory")
        }
        let storeURL = docURL.appendingPathComponent("atoulous2018.sqlite")
        do {
            try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)

        } catch {
            fatalError("Error migrating store: \(error)")
        }
    }
    
    public func newArticle() -> Article {
        
        let newArticle = NSEntityDescription.insertNewObject(forEntityName: "Article", into: managedObjectContext) as! Article
        
        return newArticle
        
    }
    
    public func getAllArticles() -> [Article] {
        
        let articlesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        
        do {
            return try managedObjectContext.fetch(articlesFetch) as! [Article]
        } catch {
            fatalError("Failed to fetch articles: \(error)")
        }
    }
    
    public func getAllArticles(withLang lang : String) -> [Article] {
        
        let articlesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        articlesFetch.predicate = NSPredicate(format: "lang == %@", lang)

        do {
            return try managedObjectContext.fetch(articlesFetch) as! [Article]
        } catch {
            fatalError("Failed to fetch articles: \(error)")
        }
    }
    
    public func getAllArticles(containString str : String) -> [Article] {
        
        let articlesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        articlesFetch.predicate = NSPredicate(format: "title CONTAINS %@ || content CONTAINS %@", str, str)

        do {
            return try managedObjectContext.fetch(articlesFetch) as! [Article]
        } catch {
            fatalError("Failed to fetch articles: \(error)")
        }
    }
    
    public func save() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
        }
    }
    
    public func removeArticle(article : Article) {
        managedObjectContext.delete(article)
    }
}
