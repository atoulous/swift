//
//  ViewController.swift
//  atoulous2018
//
//  Created by atoulous on 01/18/2018.
//  Copyright (c) 2018 atoulous. All rights reserved.
//

import atoulous2018

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        let articleManager = ArticleManager()
        
        let article1 = articleManager.newArticle()
        article1.title = "Titre article1"
        article1.content = "First article"
        article1.creationDate = NSDate()
        article1.modificationDate = NSDate()
        article1.lang = "fr"
        
        let article2 = articleManager.newArticle()
        article2.title = "Titre article2"
        article2.content = "Second article"
        article2.creationDate = NSDate()
        article2.modificationDate = NSDate()
        article2.lang = "eng"
        
        articleManager.save()
        
        print(articleManager.getAllArticles(), "\n")
        
        print(articleManager.getAllArticles(withLang: "fr"), "\n")
        
        print(articleManager.getAllArticles(containString: "article1"))

    }
}

