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
    }
    
}


