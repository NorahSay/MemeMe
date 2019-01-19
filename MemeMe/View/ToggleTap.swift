//
//  ToggleTap.swift
//  MemeMe
//
//  Created by Norah Say on 1/16/19.
//  Copyright © 2019 Norah Say. All rights reserved.
//

import Foundation
import UIKit

extension ViewController {
    
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
    }
    
}
