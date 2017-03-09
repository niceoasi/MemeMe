//
//  MemeEditSizeViewController.swift
//  MemeMe
//
//  Created by Daeyun Ethan Kim on 27/01/2017.
//  Copyright © 2017 Daeyun Ethan Kim. All rights reserved.
//

import UIKit

class MemeEditSizeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewTwo: UIImageView!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var notiLabel: UILabel!
    
    var isPhoto: Bool?
    var sendImageDelegate: ImageSenderDelegate? = nil
    var option: Int?
    var count: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if option == 2, imageViewTwo.image == nil, self.count < 3 {
            checkIsPhoto()
        }
        self.count += 1
    }
    
    @IBAction func option(_ sender: Any) {
        notiLabel.text = ""
        if count > 1 {
            self.count = 1
            imageView.image = nil
            imageViewTwo.image = nil
        }
        let alert = UIAlertController(title: "Option", message: "Select the Number of Photo", preferredStyle: UIAlertControllerStyle.actionSheet)
        let heightConstraint = NSLayoutConstraint(item: self.imageView, attribute: NSLayoutAttribute.topMargin, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.topMargin, multiplier: 1, constant: 30)
        let verticalConstraint = NSLayoutConstraint(item: self.imageView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        alert.addAction(UIAlertAction(title: "1", style: UIAlertActionStyle.default, handler: { action in

            self.view.removeConstraint(heightConstraint)
            self.view.addConstraints([verticalConstraint])
            self.option = 1
            self.checkIsPhoto()
        }))
        alert.addAction(UIAlertAction(title: "2", style: UIAlertActionStyle.default, handler: { action in
            
            self.view.removeConstraint(verticalConstraint)
            self.view.addConstraints([heightConstraint])
            self.option = 2
            self.checkIsPhoto()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func okayButtonPressed(_ sender: Any) {
        // 델리게이트로 넘기기
        var image: UIImage!
        if imageViewTwo.image == nil {
            image = imageView.image
        } else {
            image = generateMemedImage()
        }
        
        sendImageDelegate?.sendImage(image)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */    }
