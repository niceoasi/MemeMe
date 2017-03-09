//
//  MemeEditSizeViewController+Extension.swift
//  MemeMe
//
//  Created by Daeyun Ethan Kim on 28/01/2017.
//  Copyright © 2017 Daeyun Ethan Kim. All rights reserved.
//

import UIKit

extension MemeEditSizeViewController {
    
    func checkIsPhoto() {
        if isPhoto! {
            self.loadPhotoLibrary()
        } else {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.loadCamera()
            }
        }
    }
    
    func loadPhotoLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func loadCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            if imageView.image == nil {
                imageView.image = image
            } else {
                imageViewTwo.image = image
            }
            
        }else {
            print("something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func generateMemedImage() -> UIImage {
        
        // TODO: Hide toolbar and navbar
        self.toolbar.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // TODO: Show toolbar and navbar
        self.toolbar.isHidden = true
        
        return memedImage
    }
}
