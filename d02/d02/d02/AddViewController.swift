//
//  AddViewController.swift
//  d02
//
//  Created by Aymeric TOULOUSE on 1/11/18.
//  Copyright © 2018 Aymeric TOULOUSE. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var howText: UITextView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue" {
            print("AVC/prepare/segue==", segue.identifier!)
            if let vc = segue.destination as? ViewController {
                if (nameText.text != "" && compareDate(datePicker.date)) {
                    vc.notes.append((nameText.text!, datePicker.date, howText.text!))
                }
            }
        }
    }
    
    func compareDate(_ date: Date) -> Bool {
        let now = Date().addingTimeInterval(-100)
        
        if (date < now) {
            return false
        }
        return true
    }
    
    @IBAction func doneButton(_ sender: Any) {
        print("AVC/doneButton")
        performSegue(withIdentifier: "doneSegue", sender: "Foo")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentDate = Date()
        datePicker.minimumDate = currentDate
        datePicker.date = currentDate
    }
}
