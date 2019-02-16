//
//  TabBarViewController.swift
//  MemeMe
//
//  Created by Norah Say on 2/13/19.
//  Copyright © 2019 Norah Say. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setCustomBackButton()
    }
    
    func setCustomBackButton() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Sent Meme", style: .plain, target: nil, action: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(new))
    }
    
    @objc func new() {
        if let myController  = self.navigationController?.viewControllers[0] as? ViewController {
            myController.currentImage = nil
            myController.topText = "TOP"
            myController.bottomText = "BOTTOM"
            myController.shareButton.isEnabled = false
            
            navigationController?.popToViewController(myController, animated: true)
        }
    }
    
}


