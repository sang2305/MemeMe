//
//  MemeEditorViewController.swift
//  MemeMe_Final
//
//  Created by Praveen Ramanathan on 6/18/15.
//  Copyright (c) 2015 Sangeetha. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {
    
    let textFieldAttributes = [ NSStrokeColorAttributeName : UIColor.blackColor(),        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : 3.0]
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var topTextField: UITextField!
    
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var albumButton: UIBarButtonItem!
    

    @IBOutlet weak var shareButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
         shareButton.enabled = false
        
        imagePicker.delegate = self
        self.topTextField.delegate = self
        self.bottomTextField.delegate = self
        
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //To check if camera is available on the device
       
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }
    
    
    
    @IBAction func cancelMeme(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Subscribing to keyboard notifications
    
    func subscribeToKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    //Unsubscribing from keyboard notifications
    
    func unsubscribeFromKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    //view moves up to show keyboard when bottom text field is selected
    
    func keyboardWillShow(notification : NSNotification){
        if bottomTextField.isFirstResponder(){
            self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    //view moves down when keyboard hides after entering text in bottom text field
    
    func keyboardWillHide(notification : NSNotification){
        if bottomTextField.isFirstResponder(){
            self.view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    //To get the keyboard hide to shift the view up/down
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat{
        let userinfo = notification.userInfo
        let keyboardSize = userinfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }

    //To select an image from the gallery
    
    @IBAction func imagePicker(sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    //To display selected image
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imageView.image = pickedImage
            shareButton.enabled = true
        }
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //To take a photo using inbuilt camera
    
    @IBAction func camera(sender: AnyObject) {
        let takeaphoto = UIImagePickerController()
        takeaphoto.delegate = self
        takeaphoto.sourceType = .Camera
        
        self.presentViewController(takeaphoto, animated: true, completion: nil)
        shareButton.enabled = true       

    }
    
    //Assigning attributes to text fields
    
    func textFieldDidBeginEditing(textField: UITextField) {
        topTextField.defaultTextAttributes = textFieldAttributes
        bottomTextField.defaultTextAttributes = textFieldAttributes
        topTextField.clearsOnBeginEditing = false
        bottomTextField.clearsOnBeginEditing = false
        topTextField.textAlignment = .Center
        bottomTextField.textAlignment = .Center
        
        
    }
    
    //To move out of text editing when return is pressed
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        topTextField.resignFirstResponder()
        bottomTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func shareMeme(sender: AnyObject) {
        let image : UIImage = generateMemedImage()
        let nextController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.presentViewController(nextController, animated: true, completion: nil)
        nextController.completionWithItemsHandler = {(activityType,completed : Bool,[AnyObject]!,NSError) in
            if !completed{
                println("cancelled")
                return
            }else{
                self.save()
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }

    }
    


    //Create the meme
    
    func save(){
        var meme = Meme(toptext: topTextField.text, bottomtext: bottomTextField.text, image: imageView.image!, memedImage: generateMemedImage())
        
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    func generateMemedImage() -> UIImage{
        //To hide nav bar and toolbar
        self.navigationController?.navigationBarHidden = true
        self.navigationController?.toolbarHidden = true
        
        //Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //To show nav bar and toolbar
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.toolbarHidden = false
        
        return memedImage
        
       
    }

    
    
    
    
    
}

