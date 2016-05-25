//
//  EditMemeViewController.swift
//  mem1.0
//
//  Created by Shu-Mei Cheng on 3/3/16.
//  Copyright © 2016 Shu-Mei Cheng. All rights reserved.
//

import UIKit

class EditMemeViewController: UIViewController,UIImagePickerControllerDelegate ,UINavigationControllerDelegate, UITextFieldDelegate{
  
    @IBOutlet weak var topBar: UINavigationBar!
    
    @IBOutlet weak var bottomBar: UIToolbar!

  
    @IBOutlet weak var shareButton: UIBarButtonItem!

    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    
    var tableView: UITableView!
    var memecollectionView : UICollectionView!
    var imagePicker :UIImagePickerController!
    var firstTop = true
    var firstBottom = true
    
    var aMeme:Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let memeTextAttributes = [
            NSStrokeColorAttributeName: UIColor.blackColor(),
            NSForegroundColorAttributeName:UIColor.whiteColor(),
            NSFontAttributeName:UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName: -10
        ]
        bottomText.delegate = self
        topText.delegate = self

        bottomText.defaultTextAttributes = memeTextAttributes
        topText.defaultTextAttributes = memeTextAttributes
        
        shareButton.enabled = false
        
    }
    
    override func viewWillAppear(animated: Bool) {
        subscribeToKeyboardNotifications()
        super.viewWillAppear(animated)
        imagePickerView.contentMode = .ScaleAspectFit
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        topText.textAlignment = .Center
        bottomText.textAlignment = .Center
        firstTop = true
        firstBottom = true
        if( aMeme != nil){
            firstTop = false
            firstBottom = false
            shareButton.enabled = true
            bottomText.text = aMeme.bottomText
            topText.text = aMeme.topText
            
            imagePickerView.image?.drawInRect(CGRect(x: 0,y: 0,width: view.frame.size.width,height: view.frame.size.height))
           imagePickerView.image = aMeme.originalImage
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        unsubscribeFromKeyboardNotifications()
        super.viewWillDisappear(animated)
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if(textField == topText && firstTop){
            textField.text = ""
            firstTop = false
        }
        if(textField == bottomText && firstBottom){
            firstBottom = false
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
         //
        textField.resignFirstResponder()
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        
        return true
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
  
      
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
        
            imagePickerView.image = image
            imagePickerView.hidden = false
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
        imagePicker = nil
    }
    
    @IBAction func cancelEdit(sender: AnyObject) {
        
        if(imagePicker != nil){
          imagePickerControllerDidCancel(imagePicker)
        }else {
          
          dismissViewControllerAnimated(true, completion: nil)
        }
        
       
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        imagePickerView.hidden = true
        shareButton.enabled = false
        topText.text = "TOP"
        bottomText.text = "BOTTOM"
    }
    
    func pickOneImage(sourceType: UIImagePickerControllerSourceType){
        shareButton.enabled = true
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
    
        presentViewController(imagePicker,animated: true, completion:nil)
 
    }
    
    @IBAction func pickaImage(sender: AnyObject) {
        pickOneImage(UIImagePickerControllerSourceType.PhotoLibrary)
    }
    
    @IBAction func pickaImageFromCamera(sender: AnyObject) {
        pickOneImage(UIImagePickerControllerSourceType.Camera)
    }
    
    func hideBar(toHide:Bool){
        topBar.hidden = toHide
        bottomBar.hidden = toHide
    }
    
    func generateMemedImage() -> UIImage
    {
        
        // Render view to an image
        hideBar(true)
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        hideBar(false)
        
        return memedImage
    }
    func saveToArray(meme: Meme){
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
        tableView?.reloadData()
        memecollectionView?.reloadData()
    }
    
    @IBAction func sharePhota(sender: AnyObject) {
        let memeimage = generateMemedImage()
        
        let sharedItem = [memeimage]
        
        let ac = UIActivityViewController(activityItems: sharedItem, applicationActivities: nil)
        
        ac.completionWithItemsHandler = { (activity, ok, items,error) in
            if(ok == true) {
                // save a memeObject
                let ameme = Meme( topText: self.topText.text!, bottomText: self.bottomText.text!, originalImage: self.imagePickerView.image!, afterImage: memeimage)
                self.saveToArray(ameme)
                //dismissView
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
       presentViewController(ac, animated: true, completion: nil)
        
        
    }
    
    func enableText(){
        bottomText.enabled = true
        topText.enabled = true
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if( bottomText.isFirstResponder() == true){
          view.frame.origin.y = getKeyboardHeight(notification) * -1
        }
    }
    
    func keyboardWillHide(notification: NSNotification){
        if( bottomText.isFirstResponder() == true){
          view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector:#selector(EditMemeViewController.keyboardWillHide(_:)),
            name:UIKeyboardWillHideNotification,
            object:nil)

        NSNotificationCenter.defaultCenter().addObserver(self, selector:( #selector(EditMemeViewController.keyboardWillShow(_:)) )   , name: UIKeyboardWillShowNotification, object: nil)
        
     }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }

  
    
}

