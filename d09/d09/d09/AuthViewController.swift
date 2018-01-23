//
//  AuthViewController.swift
//  d09
//
//  Created by Aymeric TOULOUSE on 1/19/18.
//  Copyright © 2018 Aymeric TOULOUSE. All rights reserved.
//

import UIKit
import LocalAuthentication

class AuthViewController: UIViewController {
    
    let context = LAContext()
    var errorMessage : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if errorMessage == "" {
            self.auth(str: "You need to be authenticate")
        }
    }
    
    func auth(str: String) {
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil) {
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: str) {
                (success, error) in
                DispatchQueue.main.async {
                    if success {
                        self.performSegue(withIdentifier: "segueAuthNext", sender: self)
                    } else {
                        switch error! {
                        case LAError.userFallback:
                            self.errorMessage = "userFallback"
                        case LAError.userCancel:
                            self.errorMessage = "userCancel"
                        default:
                            self.errorMessage = "default"
                        }
                        self.viewDidLoad()
                    }
                }
            }
        }
    }

}

