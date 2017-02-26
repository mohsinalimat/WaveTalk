//
//  Extensions.swift
//  WaveTalk
//
//  Created by Anton Makarov on 28.01.17.
//  Copyright © 2017 Anton Makarov. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

//////////////////////////////////////////////
// Text Field

extension UITextField {
    func setBorderBottom() {
        let borderBottom = CALayer()
        let borderWidth = CGFloat(2.0)
        borderBottom.borderColor = UIColor(red: 80/255.0, green: 114/255.0, blue: 153/255.0, alpha: 100.0/100.0).cgColor
        borderBottom.frame = CGRect(x: 0, y: self.frame.height - 1.0, width: self.frame.width , height: self.frame.height - 1.0)
        borderBottom.borderWidth = borderWidth
        self.borderStyle = UITextBorderStyle.none
        self.layer.addSublayer(borderBottom)
        self.layer.masksToBounds = true
    }
    
    func setRegistrationFieldStyleWith(title: String) {
        let lightGreyColor = UIColor(red: 197/255, green: 205/255, blue: 205/255, alpha: 1.0)
        let darkGreyColor = UIColor(red: 52/255, green: 42/255, blue: 61/255, alpha: 1.0)
        let overcastBlueColor = UIColor(red: 49/255, green: 137/255, blue: 182/255, alpha: 1.0)
        
        let textField = SkyFloatingLabelTextField(frame: CGRect(x: 0, y: 0, width: 215, height: 40))
        textField.placeholder = title
        textField.title = title
        
        textField.tintColor = overcastBlueColor // the color of the blinking cursor
        textField.textColor = darkGreyColor
        textField.lineColor = lightGreyColor
        textField.selectedTitleColor = overcastBlueColor
        textField.selectedLineColor = overcastBlueColor
        
        textField.lineHeight = 1.0 // bottom line height in points
        textField.selectedLineHeight = 1.0

        //textField.delegate = CreateAccountViewController()
        self.borderStyle = UITextBorderStyle.none
        self.addSubview(textField)
    }
}

//////////////////////////////////////////////
// View Controller

extension UIViewController {
    func hideKeyboard() {
        
        //FIXME: Fix hiding the keyboard by pressing the screen
        //Now this is done in part, because lost access to the cells of the table
        //Only by pressing "Return"
        
        //let tap: UITapGestureRecognizer = UITapGestureRecognizer( target:self, action: #selector(UIViewController.dismissKeyboard))
        
        
        //view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

//////////////////////////////////////////////
// Image View

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageUsingCacheWithUrlString(urlString : String) {
        
        self.image = nil
        
        // check cache for image
        
        if let cacheImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cacheImage
            return
        }
        
        // otherwise
        
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(url: url as! URL)
        
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    
                    self.image = downloadedImage
                }
            }
            
        }).resume()

    }
}
