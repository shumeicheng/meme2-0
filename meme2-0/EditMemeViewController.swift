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
            NSStrokeColorAttributeName: UIColor.black,
            NSForegroundColorAttributeName:UIColor.white,
            NSFontAttributeName:UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName: -10
        ] as [String : Any]
        bottomText.delegate = self
        topText.delegate = self

        bottomText.defaultTextAttributes = memeTextAttributes
        topText.defaultTextAttributes = memeTextAttributes
        
        shareButton.isEnabled = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        subscribeToKeyboardNotifications()
        super.viewWillAppear(animated)
        imagePickerView.contentMode = .scaleAspectFit
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        topText.textAlignment = .center
        bottomText.textAlignment = .center
        firstTop = true
        firstBottom = true
        if( aMeme != nil){
            firstTop = false
            firstBottom = false
            shareButton.isEnabled = true
            bottomText.text = aMeme.bottomText
            topText.text = aMeme.topText
            
            imagePickerView.image?.draw(in: CGRect(x: 0,y: 0,width: view.frame.size.width,height: view.frame.size.height))
           imagePickerView.image = aMeme.originalImage
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeFromKeyboardNotifications()
        super.viewWillDisappear(animated)
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField == topText && firstTop){
            textField.text = ""
            firstTop = false
        }
        if(textField == bottomText && firstBottom){
            firstBottom = false
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         //
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        return true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
  
      
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
        
            imagePickerView.image = image
            imagePickerView.isHidden = false
        }
        picker.dismiss(animated: true, completion: nil)
        imagePicker = nil
    }
    
    @IBAction func cancelEdit(_ sender: AnyObject) {
        
        if(imagePicker != nil){
          imagePickerControllerDidCancel(imagePicker)
        }else {
          
          dismiss(animated: true, completion: nil)
        }
        
       
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
        imagePickerView.isHidden = true
        shareButton.isEnabled = false
        topText.text = "TOP"
        bottomText.text = "BOTTOM"
    }
    
    func pickOneImage(_ sourceType: UIImagePickerControllerSourceType){
        shareButton.isEnabled = true
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
    
        present(imagePicker,animated: true, completion:nil)
 
    }
    
    @IBAction func pickaImage(_ sender: AnyObject) {
        pickOneImage(UIImagePickerControllerSourceType.photoLibrary)
    }
    
    @IBAction func pickaImageFromCamera(_ sender: AnyObject) {
        pickOneImage(UIImagePickerControllerSourceType.camera)
    }
    
    func hideBar(_ toHide:Bool){
        topBar.isHidden = toHide
        bottomBar.isHidden = toHide
    }
    
    func generateMemedImage() -> UIImage
    {
        
        // Render view to an image
        hideBar(true)
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawHierarchy(in: view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        hideBar(false)
        
        return memedImage
    }
    func saveToArray(_ meme: Meme){
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
        tableView?.reloadData()
        memecollectionView?.reloadData()
    }
    
    @IBAction func sharePhota(_ sender: AnyObject) {
        let memeimage = generateMemedImage()
        
        let sharedItem = [memeimage]
        
        let ac = UIActivityViewController(activityItems: sharedItem, applicationActivities: nil)
        
        ac.completionWithItemsHandler = { (activity, ok, items,error) in
            if(ok == true) {
                // save a memeObject
                let ameme = Meme( topText: self.topText.text!, bottomText: self.bottomText.text!, originalImage: self.imagePickerView.image!, afterImage: memeimage)
                self.saveToArray(ameme)
                //dismissView
                self.dismiss(animated: true, completion: nil)
            }
        }
       present(ac, animated: true, completion: nil)
        
        
    }
    
    func enableText(){
        bottomText.isEnabled = true
        topText.isEnabled = true
    }
    
    func keyboardWillShow(_ notification: Notification) {
        if( bottomText.isFirstResponder == true){
          view.frame.origin.y = getKeyboardHeight(notification) * -1
        }
    }
    
    func keyboardWillHide(_ notification: Notification){
        if( bottomText.isFirstResponder == true){
          view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
            selector:#selector(EditMemeViewController.keyboardWillHide(_:)),
            name:NSNotification.Name.UIKeyboardWillHide,
            object:nil)

        NotificationCenter.default.addObserver(self, selector:( #selector(EditMemeViewController.keyboardWillShow(_:)) )   , name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
     }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name:
            NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

  
    
}

