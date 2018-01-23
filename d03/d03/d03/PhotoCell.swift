//
//  PhotoCell.swift
//  d03
//
//  Created by Aymeric TOULOUSE on 1/12/18.
//  Copyright © 2018 Aymeric TOULOUSE. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    var photoCell : UIImage? {
        didSet{
            self.imageView?.image = self.photoCell
        }
    }
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

}
