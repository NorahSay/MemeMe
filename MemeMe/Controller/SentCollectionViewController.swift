//
//  SentCollectionViewController.swift
//  MemeMe
//
//  Created by Norah Say on 2/8/19.
//  Copyright © 2019 Norah Say. All rights reserved.
//

import UIKit

class SentCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    //MARK: Properties
    var memes : [Meme]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Getting array of data from App Delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        
        gridSize(space: 3.0, gridNumInRow: 3.0)
    
    }
    
    
    // MARK: Configure Collection View
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        cell.memeImageView?.image = meme.memedImage
        cell.topText?.text = meme.topTextField
        cell.bottomText?.text = meme.bottomTextField
        
        //Text Styling
        textStyling(label: cell.topText)
        textStyling(label: cell.bottomText)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let imageDetailVC = self.storyboard!.instantiateViewController(withIdentifier: "ImageDetailViewController") as! ImageDetailViewController
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        //passing data to ImageDetailViewController
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
    
    
    func gridSize(space : CGFloat, gridNumInRow : CGFloat) {
        let space:CGFloat = space
        let dimension = (view.frame.size.width - (2 * space)) / gridNumInRow
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
}
