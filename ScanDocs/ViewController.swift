//
//  ViewController.swift
//  ScanDocs
//
//  Created by Cons Bulaqueña on 26/03/2018.
//  Copyright © 2018 consios. All rights reserved.
//

import UIKit
import TesseractOCR

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

        //imagePickerController(
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
                
                //640 dimension, code run after scaled image
                let scaledPhoto = selectedImage.scaleImage(640)
                activityIndicator.startAnimating()
                dismiss(animated: true, completion: {
                    
                    print("start recognizing image")
                    self.recognizeText(image: scaledPhoto!)
                })

                
        }
       
}
    //recognize image to text - function
    func recognizeText(image: UIImage) {
        if let tessaract = G8Tesseract(language: "eng") {
        tessaract.engineMode = .tesseractCubeCombined
        tessaract.pageSegmentationMode = .auto //for paragraphs
        tessaract.image = image.g8_blackAndWhite() //turns to B/w
        tessaract.recognize()
        textView.text = tessaract.recognizedText
            
        }
        activityIndicator.stopAnimating()
        }
}

extension UIImage {
    func scaleImage(_ maxDimension: CGFloat) -> UIImage? {
        var scaledSize = CGSize(width: maxDimension, height: maxDimension)
        if size.width > size.height {
            let scaleFactor = size.height / size.width
            scaledSize.height = scaledSize.width * scaleFactor
            
        } else { //For portrait
        let scaleFactor = size.width / size.width
            scaledSize.width = scaledSize.height * scaleFactor
        
    }   //draw in new image
        UIGraphicsBeginImageContext(scaledSize)
        draw(in: CGRect(origin: .zero, size: scaledSize))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
}
