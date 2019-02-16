//
//  ImageDetailViewController.swift
//  MemeMe
//
//  Created by Norah Say on 2/13/19.
//  Copyright © 2019 Norah Say. All rights reserved.
//

import UIKit


class ImageDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var memedImage : UIImage!
    var originalImage : UIImage!
    var topText : String!
    var bottomText : String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = memedImage
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(edit))
        
    }
    
    @objc func edit() {
        if let myController  = self.navigationController?.viewControllers[0] as? ViewController {
            myController.currentImage = originalImage
            myController.topText = topText
            myController.bottomText = bottomText
            
            navigationController?.popToViewController(myController, animated: true)
        }
    }

    
    
    
    

}
