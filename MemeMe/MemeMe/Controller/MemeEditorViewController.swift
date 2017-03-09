//
//  ViewController.swift
//  MemeMe
//
//  Created by Daeyun Ethan Kim on 14/01/2017.
//  Copyright © 2017 Daeyun Ethan Kim. All rights reserved.
//

import UIKit
import Photos

class MemeEditorViewController: UIViewController, ImageSenderDelegate {
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    let memeTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -3.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setTextFieldIntoDidLoad()
        self.shareButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        self.subscribeToKeyboardNotifications()
        self.setTextFieldAttribute()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        self.unsubscribeFromKeyboardNotifications()
    }
    
    @IBAction func shareMeme(_ sender: Any) {
        let image = self.save()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "MemeEditSizeViewController") as! MemeEditSizeViewController
        
        if shareButton.isEnabled == false {
            shareButton.isEnabled = true
        }
        controller.sendImageDelegate = self
        controller.isPhoto = false
        
        self.present(controller, animated: true)
    }
    
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "MemeEditSizeViewController") as! MemeEditSizeViewController
        
        if shareButton.isEnabled == false {
            shareButton.isEnabled = true
        }
        controller.sendImageDelegate = self
        controller.isPhoto = true
        
        self.present(controller, animated: true)
    }
}

