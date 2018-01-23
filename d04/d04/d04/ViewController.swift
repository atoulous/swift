//
//  ViewController.swift
//  d04
//
//  Created by Aymeric TOULOUSE on 1/12/18.
//  Copyright © 2018 Aymeric TOULOUSE. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, APITwitterDelegate {

    let consumerKey = "A6Bwcyto78pbvRtAWpRcuOnVH"
    let consumerSecret = "EBjcOOuCQnQDqedWKNTm16AqF55LOdynd0moww5DeNWaYCMV25"
    var token = ""
    var tweets : [Tweet] = []
    
    @IBOutlet weak var tableView: UITableView!

    @IBAction func handleSearch(_ sender: UITextField) {
        print("HERE", sender.text!)
        let apiController = APIController(delegate: self, token: self.token)
        self.tweets = apiController.getTweets(search: sender.text!, nbr: 100)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getToken()
    }
    
    func getToken() {
        let bearer_credentials = ((consumerKey + ":" + consumerSecret).data(using: String.Encoding.utf8))?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        let url = URL(string: "https://api.twott")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("Basic " + bearer_credentials!, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)
                self._alert(msg: "error/catch: \(error!)")
                return
            }
            do {
                if let dic: NSDictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    self.token = (dic["access_token"] as? String)!
                    print("1 \(token)")
                    let apiController = APIController(delegate: self, token: self.token)
                    self.tweets = apiController.getTweets(search: "ecole 42", nbr: 100)
                }
            }
            catch (let err) {
                print("err==", err)
                self._alert(msg: "error/catch: \(err)")
            }
        }
        task.resume()
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCell
        
        cell.nameLabel.text = tweets[indexPath.row].name
        cell.dataLabel.text = tweets[indexPath.row].text
        cell.dateLabel.text = tweets[indexPath.row].date
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Here, we use NSFetchedResultsController
        // And we simply use the section name as title
//        let currSection = fetchedResultsController.sections?[section]
//        let title = currSection!.name
        
        // Dequeue with the reuse identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: "inputCell")
 
        
        return cell
    }
    
    func handleTweets(tweets: [Tweet]) {
        DispatchQueue.main.async {
            self.tweets = tweets
            self.tableView.reloadData()
        }
    }
    
    func handleError(error: NSError) {
        print("handleError : \(error)")
    }
    
    func _alert(msg : String) {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default))
        self.present(alert, animated: true, completion: nil)
        print("alert")
    }

}

