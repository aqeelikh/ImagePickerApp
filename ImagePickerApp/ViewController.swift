//
//  ViewController.swift
//  ImagePickerApp
//
//  Created by Khalid Aqeeli on 27/05/2020.
//  Copyright © 2020 Khalid Aqeeli. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate, UITextFieldDelegate {

    //MARK: Setup Outlets
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    let topTextFieldDelegate = TBTextFieldDelegate()
    let bottomTextFieldDelegate = TBTextFieldDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: SetupDelegates
        
        self.topTextField.delegate = self.topTextFieldDelegate
        self.bottomTextField.delegate = self.bottomTextFieldDelegate
        
        configureUI(tf: topTextField, text: "Top")
        configureUI(tf: bottomTextField, text: "Bottom")
        
    }
    @IBAction func cancelButton(_ sender: Any) {
        imagePickerView.image = nil
        configureUI(tf: topTextField, text: "Top")
        configureUI(tf: bottomTextField, text: "Bottom")    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        //MARK: Sign up to be notified when the keyboard appears
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    override func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }

    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        chooseImageFromCameraOrPhoto(source: UIImagePickerController.SourceType.photoLibrary)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        chooseImageFromCameraOrPhoto(source: UIImagePickerController.SourceType.camera)
    }
    
    // MARK: Image Picker controller setup
    func chooseImageFromCameraOrPhoto(source: UIImagePickerController.SourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.sourceType = source
        present(pickerController, animated: true, completion: nil)
    }
    
    
    //MARK: Activity View Controller
    @IBAction func shareImage(_ sender: Any) {
        let items = generateMemedImage()
        let ac = UIActivityViewController(activityItems: [items], applicationActivities: nil)
        present(ac, animated: true)
        ac.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) -> Void in
            if completed == true {
                self.save()
            }
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickerView.image = image
            picker.dismiss(animated: true, completion: nil)
            self.shareButton.isEnabled = true
        }
    }
    
    //MARK: Keyboard Handling
    func subscribeToKeyboardNotifications() {

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }

    func unsubscribeFromKeyboardNotifications() {

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        
        if self.view.frame.origin.y == 0  && bottomTextField.isEditing {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
        
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        
         if self.view.frame.origin.y != 0 {
            view.frame.origin.y = CGFloat(0)
         }
       }

    func getKeyboardHeight(_ notification:Notification) -> CGFloat {

        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    
    //MARK: Create Meme Object
    
    func save() {
            // Create the meme
        _ = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())
    }
    
    func generateMemedImage() -> UIImage {

        //Hide NavigationController and tabBarController
        self.navBar.isHidden = true
        self.toolBar.isHidden  = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        // Show  NavigationController and tabBarController
        self.navBar.isHidden = false
        self.toolBar.isHidden  = false
        
        return memedImage
    }
    
    // MARK: - ConfigureUI ViewController Function
    func configureUI(tf: UITextField, text: String) {
        
        // MARK: configure Textfield Attributes
        tf.defaultTextAttributes = [
                 NSAttributedString.Key.strokeColor: UIColor.black,
                 NSAttributedString.Key.foregroundColor: UIColor.white ,
                 NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
                 NSAttributedString.Key.strokeWidth:  -3.5
             ]
        
             shareButton.isEnabled = false
             tf.text = text
             tf.textAlignment =  NSTextAlignment.center
    }
}

