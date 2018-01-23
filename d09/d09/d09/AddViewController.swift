//
//  AddViewController.swift
//  d09
//
//  Created by Aymeric TOULOUSE on 1/19/18.
//  Copyright © 2018 Aymeric TOULOUSE. All rights reserved.
//

import UIKit
import atoulous2018

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let pickerController = UIImagePickerController()

    var articleManager : ArticleManager? = nil
    var currentArticle : Article?
    var currentPath : Int?
    
    @IBOutlet weak var viewImage: UIImageView!
    @IBOutlet weak var inputTitle: UITextField!
    @IBOutlet weak var inputContent: UITextView!
    
    @IBAction func handleLibrary(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            pickerController.sourceType = .photoLibrary
            present(pickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func handleCamera(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            pickerController.sourceType = .camera
            present(pickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        if inputTitle.text != "" && inputContent.text != "" && viewImage.image != nil {

            if currentArticle != nil {
                print("update")
                currentArticle?.title = inputTitle.text!
                currentArticle?.content = inputContent.text!
                currentArticle?.modificationDate = NSDate()
                currentArticle?.lang = NSLocale.current.languageCode!
                currentArticle?.image = UIImagePNGRepresentation(viewImage.image!) as NSData?
                
                articleManager?.save()
                performSegue(withIdentifier: "backSegueUpdated", sender: currentArticle)
            } else {
                let newArticle = articleManager?.newArticle()
                
                newArticle?.title = inputTitle.text!
                newArticle?.content = inputContent.text!
                newArticle?.creationDate = NSDate()
                newArticle?.lang = NSLocale.current.languageCode!
                newArticle?.image = UIImagePNGRepresentation(viewImage.image!) as NSData?
                
                articleManager?.save()
                performSegue(withIdentifier: "backSegue", sender: newArticle)
            }

        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            viewImage.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerController.delegate = self
        if currentArticle != nil {
            viewImage.image = UIImage(data: (currentArticle?.image as Data?)!)
            inputTitle.text = currentArticle?.title
            inputContent.text = currentArticle?.content
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backSegue" {
            if let TVC = segue.destination as? TableViewController {
                TVC.allArticles.append(sender as! Article)
            }
        }
        if segue.identifier == "backSegueUpdated" {
            if let TVC = segue.destination as? TableViewController {
                TVC.allArticles[currentPath!] = sender as! Article
            }
        }
    }

}
