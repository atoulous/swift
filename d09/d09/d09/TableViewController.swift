//
//  TableViewController.swift
//  d09
//
//  Created by Aymeric TOULOUSE on 1/19/18.
//  Copyright © 2018 Aymeric TOULOUSE. All rights reserved.
//

import UIKit
import atoulous2018

class TableViewController: UITableViewController {

    let articleManager = ArticleManager()
    var allArticles : [Article] = []
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.allArticles = articleManager.getAllArticles(withLang: NSLocale.current.languageCode!)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allArticles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleCell

        cell.labelTitle.text = allArticles[indexPath.row].title
        cell.labelContent.text = allArticles[indexPath.row].content
        cell.labelCreationDate.text = "Created: " + formatDate(allArticles[indexPath.row].creationDate!)
       
        if let image = allArticles[indexPath.row].image {
            cell.viewImage.image = UIImage(data: image as Data)
        }

        if let modifDate = allArticles[indexPath.row].creationDate {
            cell.labelModificationDate.text = "Updated: " + formatDate(modifDate)
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let cell = tableView.cellForRow(at: indexPath) as! ArticleCell
            let article = articleManager.getAllArticles(containString: (cell.labelContent.text)!)
            articleManager.removeArticle(article: article[0])
            articleManager.save()
            allArticles.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: "segueAdd", sender: indexPath.row)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueAdd" {
            let indexPath = sender as? Int

            if let AVC = segue.destination as? AddViewController {
                AVC.articleManager = self.articleManager
                if indexPath != nil {
                    let article = allArticles[indexPath!]
                    AVC.currentArticle = article
                    AVC.currentPath = indexPath
                }
            }
        }
    }
    
    private func formatDate(_ date: NSDate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd yyyy HH:mm"
        return dateFormatter.string(from: date as Date)
    }
}
