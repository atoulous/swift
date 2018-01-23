//
//  CollectionViewController.swift
//  d03
//
//  Created by Aymeric TOULOUSE on 1/11/18.
//  Copyright © 2018 Aymeric TOULOUSE. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    var count : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.reloadData()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Model.photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCell
        let qos = DispatchQoS.background.qosClass
        let queue = DispatchQueue.global(qos: qos)

        queue.async {
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                cell?.activityIndicator.startAnimating()
            }
            self.count += 1
                if let url = URL(string: Model.photos[indexPath.row]!) {
                    if let data = try? Data(contentsOf: url) {
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            cell?.imageView.image = image
                            cell?.activityIndicator.stopAnimating()
                        }
                    } else {
                        self._alert(msg: "error/invalid data : \(Model.photos[indexPath.row] ?? "missing value")")
                    }
                } else {
                    self._alert(msg: "error/invalid url : \(Model.photos[indexPath.row] ?? "missing value")")
                }
                self.count -= 1
                if (self.count == 0) {
                    DispatchQueue.main.async {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    }
                }
        }

        return cell!
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segue", sender: collectionView.cellForItem(at: indexPath) as? PhotoCell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            let dest = segue.destination as? ScrollViewController
            let cell = sender as? PhotoCell
            if let SVC = dest {
                SVC.image = cell?.imageView.image
            }
        }
    }
    
    func _alert(msg : String) {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default))
        self.present(alert, animated: true, completion: nil)
        print("alert")
    }

}
