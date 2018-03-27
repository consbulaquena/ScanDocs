//
//  ViewController.swift
//  ScanDocs
//
//  Created by Cons Bulaqueña on 26/03/2018.
//  Copyright © 2018 consios. All rights reserved.
//

import UIKit

@IBDesignable extension UITextView{
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}


class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet var textView: UITextView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func takePhotoBtnPressed(_ sender: Any) {
        view.endEditing(true)
        presentOption()
    }
    
    //choose photo or camera
    func presentOption() {
        
        let imageAction = UIAlertController(title: "Take Photo", message: nil, preferredStyle: .actionSheet)

    //image picker
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let cameraAction = UIAlertAction(title: "Take Photo", style: .default) { (action) in
            print("camera selected")
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
            
            
        }
        let libraryAction = UIAlertAction(title: "Choose existing", style: .default) { (action) in
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
        print("library")
    }
        
        imageAction.addAction(cameraAction)
        imageAction.addAction(libraryAction)
        imageAction.addAction(cancelAction)
        
        present(imageAction, animated: true, completion: nil)
        
        
        
    }
    
    
}
}
