//
//  ViewController.swift
//  d00
//
//  Created by Aymeric TOULOUSE on 1/8/18.
//  Copyright © 2018 Aymeric TOULOUSE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelScore: UILabel!
    var str1 : String? = ""
    var str2 : String? = ""
    var ope : String? = ""
    var comma = false
    
    @IBAction func buttonAC(_ sender: UIButton) {
        print("Button \(sender.currentTitle!)")

        labelScore.text = "0"
        reset()
    }
    
    @IBAction func buttonPlusLess(_ sender: UIButton) {
        print("Button \(sender.currentTitle!)")

        let number = Double(labelScore.text!)
        if (str1 != "") {
            str1 = String(number! * -1)
        }
        
        if (number != 0) {
            labelScore.text = String(number! * -1)
        }
    }
    
    @IBAction func buttonOpe(_ sender: UIButton) {
        print("Button \(sender.currentTitle!)")
        
        if (str1 != "" && ope != "") {
            str2 = labelScore.text!
            calculator()
        }
        ope = sender.currentTitle!
        comma = false
    }
    
    @IBAction func buttonEqual(_ sender: UIButton) {
        print("Button \(sender.currentTitle!)")
        
        if (str1 != "" && str2 != "" && ope != "") {
            calculator()
        }
    }
    
    @IBAction func buttonComma(_ sender: UIButton) {
        print("Button \(sender.currentTitle!)")
        
        if (comma == false) {
            if (ope != "") {
                str2 = str2! + "."
                comma = true
                refresh(str2!)
            } else {
                str1 = str1! + "."
                comma = true
                refresh(str1!)
            }
        }
    }
    
    @IBAction func buttonNumber(_ sender: UIButton) {
        print("Button \(sender.currentTitle!)")
        
        if (ope != "") {
            setStr2(sender.currentTitle!)
        } else {
            setStr1(sender.currentTitle!)
        }
    }
    
    func log() {
        print("str1==", str1!)
        print("str2==", str2!)
        print("ope==", ope!)
    }
    
    func setStr1(_ str: String) -> Void {
        print("setStr1")
        
        str1 = str1! + str
        refresh(str1!)
    }
    
    func setStr2(_ str: String) -> Void {
        print("setStr2")
        
        str2! += str
        refresh(str2!)
    }
    
    func refresh(_ str: String) -> Void {
        labelScore.text = str
    }
    
    func calculator() -> Void {
        if (String(labelScore.text!) == "Erreur") {
            print("here")
            labelScore.text = "0"
            reset()
            return
        }
        
        if (str1 != "" && str2 != "") {
            print("print1==", str1!, str2!)

            let nb1 = Double(str1!)
            let nb2 = Double(str2!)
            str1 = str2!
            
            switch ope {
            case "+"?:
                labelScore.text = String(nb1! + nb2!)
            case "-"?:
                labelScore.text = String(nb1! - nb2!)
            case "*"?:
                labelScore.text = String(nb1! * nb2!)
            case "/"?:
                if (nb2 != 0) { labelScore.text = String(nb1! / nb2!) }
                else {
                    labelScore.text = "Erreur"
                    reset()
                }
            default :
                labelScore.text = "0"
            }
            
            if (labelScore.text! != "Erreur") {
                str1 = labelScore.text!
            }
            str2 = ""
            ope = ""
        }
    }
    
    func reset() -> Void {
        str1 = ""
        str2 = ""
        ope = ""
        comma = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
