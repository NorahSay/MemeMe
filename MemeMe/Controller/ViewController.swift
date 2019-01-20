//
//  ViewController.swift
//  MemeMe
//
//  Created by Norah Say on 1/15/19.
//  Copyright © 2019 Norah Say. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // MARK: Outlets
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    
    // MARK: Meme text style
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth:  -3.0
    ]
    
    func textStyle(textField : UITextField) {
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        
        //set delegate
        self.topTextField.delegate = self
        self.bottomTextField.delegate = self
    }
    
    // MARK: Functions on launch
    override func viewDidLoad() {
        super.viewDidLoad()
        shareButton.isEnabled = false
        
        //Apply text style
        textStyle(textField: topTextField)
        textStyle(textField: bottomTextField)
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    // MARK: Toggle status bar on tap
    
    override var prefersStatusBarHidden: Bool {
        return navigationController?.isNavigationBarHidden == true
    }

    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }
    
    
    
    // MARK: Choose photos
    
    func presentImagePickerWith(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    //From photo album
    @IBAction func pickPhotoFromAlbum(_ sender: UIBarButtonItem) {
        presentImagePickerWith(sourceType: .photoLibrary)
        
    }
    
    //From camera
    @IBAction func pickPhotoFromCamera(_ sender: UIBarButtonItem) {
        presentImagePickerWith(sourceType: .camera)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
            shareButton.isEnabled = true
            dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    // MARK: Share image
    
    @IBAction func shareImage(_ sender: UIBarButtonItem) {
        let memedImage = generateMemedImage()
        let activityVC = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        activityVC.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if completed {
                self.save(memedImage: memedImage)
            }
        }
        self.present(activityVC, animated: true, completion: nil)
    }
    
    //Generate memed Image
    func generateMemedImage() -> UIImage {
        //hide toolbar and navbar
        configureBars(false)
        
        //render view to image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        //Show toolbar and navbar
        configureBars(true)
        return memedImage
    }
    
    func configureBars(_ isHidden : Bool) {
        navigationController?.isNavigationBarHidden = !isHidden
        navigationController?.isToolbarHidden = !isHidden
    }
    
    
    // Save image
    func save(memedImage : UIImage){
        let meme = MemeData(topTextField: topTextField.text ?? "", bottomTextField: bottomTextField.text ?? "", originalImage: imageView.image!, memedImage: memedImage)
    }
    
    
    // MARK: Textfield functions
    var edited1 =  false
    var edited2 = false
    
    //clear default text when user start editing but keep user input
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if !edited1 && textField.tag == 0 {
            textField.text = ""
            edited1 = true
        } else if !edited2 && textField.tag == 1 {
            textField.text = ""
            edited2 = true
        }
        
        //dimiss keyboard when user tap screen
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dimissKeyboard(_:)))
        self.view.addGestureRecognizer(tap)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        return true
    }
    
    @objc func dimissKeyboard(_ sender: UIGestureRecognizer) {
        topTextField.resignFirstResponder()
        bottomTextField.resignFirstResponder()
        
    }
    
    
    
    
    
    
    
    


}

