//
//  ViewController.swift
//  d03
//
//  Created by Aymeric TOULOUSE on 1/11/18.
//  Copyright © 2018 Aymeric TOULOUSE. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    var imageView : UIImageView?
    var image : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView = UIImageView(image: image)
        scrollView.addSubview(imageView!)
        scrollView.maximumZoomScale = 100
    }
    
    override func viewDidLayoutSubviews() {
        scrollView?.minimumZoomScale = scrollView.bounds.width / (self.imageView?.bounds.width)!
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

