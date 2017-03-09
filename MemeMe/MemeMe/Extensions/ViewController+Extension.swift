//
//  ViewController+Extension.swift
//  MemeMe
//
//  Created by Daeyun Ethan Kim on 25/01/2017.
//  Copyright © 2017 Daeyun Ethan Kim. All rights reserved.
//

import UIKit

extension ViewController: UITextFieldDelegate {
    
    func setTextFieldIntoDidLoad() {
        topTextField.delegate = self
        bottomTextField.delegate = self
        
        topTextField.attributedPlaceholder = NSAttributedString(string: "TOP", attributes: memeTextAttributes)
        bottomTextField.attributedPlaceholder = NSAttributedString(string: "BOTTOM", attributes: memeTextAttributes)
        
        // 탭 동작 인식기
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.view.addGestureRecognizer(gestureRecognizer)
    }
    
    func setTextFieldAttribute() {
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = NSTextAlignment(rawValue: 1)!
        bottomTextField.textAlignment = NSTextAlignment(rawValue: 1)!
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            
            if shareButton.isEnabled == false {
                shareButton.isEnabled = true
            }
        }else {
            print("something went wrong")
        }
        
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func save() -> UIImage {
        let memedImage = generateMemedImage()
        
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageView.image!, memedImage: memedImage)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)
        
        return memedImage
    }
    
    func generateMemedImage() -> UIImage {
        
        // TODO: Hide toolbar and navbar
        self.topToolbar.isHidden = true
        self.bottomToolbar.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // TODO: Show toolbar and navbar
        self.topToolbar.isHidden = false
        self.bottomToolbar.isHidden = false
        
        return memedImage
    }
    
    
    // 뷰 구조에서 최초 응답 객체 찾기
    func findFirstResponder() -> UIResponder? {
        for v in self.view.subviews {
            if v.isFirstResponder {
                return (v as UIResponder)
            }
        }
        return nil
    }
    
    func handleTap(_ gesture: UITapGestureRecognizer) {
        // 최초 응답 객체 찾기
        if let firstRespond = self.findFirstResponder() {
            firstRespond.resignFirstResponder()
        }
    }
    
    func keyboardWillShow(_ notification: Notification) {
        
        if let rectObj = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRect = rectObj.cgRectValue
            
            // 최초 응답 객체 찾기
            let textField = findFirstResponder() as! UITextField
            
            // 키보드에 가리는지 체크
            if keyboardRect.contains(textField.frame.origin) {
                let dy = keyboardRect.origin.y - textField.frame.origin.y - textField.frame.size.height - 10
                self.view.transform = CGAffineTransform.init(translationX: 0, y: dy)
            } else {
            }
        }
    }
    
    func keyboardWillHide(_ notification: NSNotification) {
        self.view.transform = CGAffineTransform.identity
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.placeholder != "" {
            textField.placeholder = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
}
