//
//  SentTableViewController.swift
//  MemeMe
//
//  Created by Norah Say on 2/8/19.
//  Copyright © 2019 Norah Say. All rights reserved.
//

import UIKit

class SentTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: Properties
    var memes : [Meme]!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Getting array of data from App Delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        
    }
    
    
    // MARK: Configure Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell") as! MemeTableViewCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        cell.memeLabel?.text = meme.topTextField! + "..." + meme.bottomTextField!
        cell.topText?.text = meme.topTextField
        cell.bottomText?.text = meme.bottomTextField
        cell.memeImage?.image = meme.originalImage
        
        //Top text and bottom text styling
        textStyling(label: cell.topText)
        textStyling(label: cell.bottomText)
        
        return cell 
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let imageDetailVC = self.storyboard!.instantiateViewController(withIdentifier: "ImageDetailViewController") as! ImageDetailViewController
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        //Passing data to ImageDetailViewController
        imageDetailVC.memedImage = meme.memedImage
        imageDetailVC.originalImage = meme.originalImage
        imageDetailVC.topText = meme.topTextField
        imageDetailVC.bottomText = meme.bottomTextField
        
        self.navigationController!.pushViewController(imageDetailVC, animated: true)
        
    }
    
    func textStyling(label: UILabel) {
        
        let memeTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 15)!,
            NSAttributedString.Key.strokeWidth:  -3.0
        ]
        
        label.attributedText = NSAttributedString(string: label.text!, attributes: memeTextAttributes)
    }

}


 
