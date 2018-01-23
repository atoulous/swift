//
//  NoteTableViewCell.swift
//  d02
//
//  Created by Aymeric TOULOUSE on 1/11/18.
//  Copyright © 2018 Aymeric TOULOUSE. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var howLabel: UILabel!
    
    var note : (String, Date, String)? {
        didSet {
            if let n = note {
                
                nameLabel?.text = n.0
                dateLabel?.text = formatDate(n.1)
                howLabel?.text = n.2
            }
        }
    }
    
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd yyyy HH:mm"
        return dateFormatter.string(from: date)
    }
}
