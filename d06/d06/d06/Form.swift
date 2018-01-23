//
//  Form.swift
//  d06
//
//  Created by Aymeric TOULOUSE on 1/16/18.
//  Copyright © 2018 Aymeric TOULOUSE. All rights reserved.
//

import UIKit

class Form: UIView {
    
    let allForms = ["square", "circle"]
    var view : UIView
    
    init(x: Double, y: Double, size: Double) {
        let frame = CGRect(x: x, y: y, width: size, height: size)
        self.view = UIView(frame: frame)
        super.init(frame: frame)

        if self.getRandomForm() == "circle" {
            view.layer.cornerRadius = CGFloat(size / 2)
        }
        
        self.view.backgroundColor = self.getRandomColor()
        self.view.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getRandomForm() -> String {
        let randomIndex = Int(arc4random_uniform(UInt32(allForms.count)))
        
        return allForms[randomIndex]
    }
    
    private func getRandomColor() -> UIColor {
        let randomRed: CGFloat = CGFloat(drand48())
        let randomGreen: CGFloat = CGFloat(drand48())
        let randomBlue: CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}
