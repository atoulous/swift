//
//  ViewController.swift
//  d02
//
//  Created by Aymeric TOULOUSE on 1/10/18.
//  Copyright © 2018 Aymeric TOULOUSE. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var notes : [(String?, Date?, String?)] = Data.notes

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell") as! NoteTableViewCell
        if notes.count > 0 {
            cell.note = notes[indexPath.row] as? (String, Date, String)
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueIdentifier" {
            print("VC/prepare/segue==", segue.identifier!)
        }
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        print("VC/unwindSegue/segue==", segue.identifier!)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        tableView.rowHeight = UITableViewAutomaticDimension
    }

}

