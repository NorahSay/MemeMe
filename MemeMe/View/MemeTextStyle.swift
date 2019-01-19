//
//  MemeTextStyle.swift
//  MemeMe
//
//  Created by Norah Say on 1/17/19.
//  Copyright © 2019 Norah Say. All rights reserved.
//

import Foundation
import UIKit

extension ViewController {
    
    static var memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth:  -3.0
    ]
    
}
