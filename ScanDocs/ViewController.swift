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
    }
    

    
    
}

