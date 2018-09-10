//
//  SignUpViewController.swift
//  Medio
//
//  Created by StrateCore - iMac1 on 30/03/18.
//  Copyright © 2018 StrateCore - iMac1. All rights reserved.
//

import UIKit
import MobileCoreServices

class SignUpViewController: UIViewController,UITextFieldDelegate ,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate{

//******************* ASSIGN VARIABLE *********************//

    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTitle2: UILabel!
    @IBOutlet weak var lblPhoto: UILabel!
    @IBOutlet weak var lblInfo: UILabel!

    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLasetName: UITextField!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirm: UITextField!
    
    @IBOutlet weak var btnSelectPhoto: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var imgPhoto: UIImageView!
    @IBOutlet weak var btnBack: UIButton!
    var tempImage = UIImage()
    var isProfile = Bool()

    
    var cameraController = UIImagePickerController()

//***********************************************************//

    override func viewDidLoad() {
        super.viewDidLoad()

        //SET TEXT FIELD
        setTheTextField(txtFirstName)
        setTheTextField(txtLasetName)
        setTheTextField(txtTitle)
        setTheTextField(txtEmail)
        setTheTextField(txtPassword)
        setTheTextField(txtConfirm)
        
    }
    

    override func viewDidLayoutSubviews() {
        setTheView()
    }
 
    
    func setTheView() {
        
        //SET VIEW
        viewMain.layer.masksToBounds = true
        viewMain.layer.cornerRadius = viewMain.frame.size.height / 2
        txtFirstName.layer.masksToBounds = true
        txtFirstName.layer.sublayerTransform=CATransform3DMakeTranslation(10, 0, 0)
        txtFirstName.layer.cornerRadius = txtFirstName.frame.size.height / 2
        txtLasetName.layer.masksToBounds = true
        txtLasetName.layer.sublayerTransform=CATransform3DMakeTranslation(10, 0, 0)
        txtLasetName.layer.cornerRadius = txtLasetName.frame.size.height / 2
        txtTitle.layer.masksToBounds = true
        txtTitle.layer.cornerRadius = txtTitle.frame.size.height / 2
        txtEmail.layer.masksToBounds = true
        txtEmail.layer.cornerRadius = txtEmail.frame.size.height / 2
        txtPassword.layer.masksToBounds = true
        txtPassword.layer.cornerRadius = txtPassword.frame.size.height / 2
        txtConfirm.layer.masksToBounds = true
        txtConfirm.layer.cornerRadius = txtConfirm.frame.size.height / 2
        
        //SET BUTTON
        btnSelectPhoto.layer.masksToBounds = true
        btnSelectPhoto.layer.cornerRadius = btnSelectPhoto.frame.size.height / 2
        btnNext.layer.masksToBounds = true
        btnNext.layer.cornerRadius = btnNext.frame.size.height / 2
        
        
        //SET FONT
        lblTitle.font=appDelegate!.setTheFontSize(lblTitle.font, valueFontSizeFor6: 20.0)
        lblTitle2.font=appDelegate!.setTheFontSize(lblTitle2.font, valueFontSizeFor6: 16.0)
        lblInfo.font=appDelegate!.setTheFontSize(lblInfo.font, valueFontSizeFor6: 14.0)
        lblPhoto.font=appDelegate!.setTheFontSize(lblPhoto.font, valueFontSizeFor6: 16.0)
        txtFirstName.font=appDelegate!.setTheFontSize(txtFirstName.font!, valueFontSizeFor6: 16.0)
        txtLasetName.font=appDelegate!.setTheFontSize(txtLasetName.font!, valueFontSizeFor6: 16.0)
        txtTitle.font=appDelegate!.setTheFontSize(txtTitle.font!, valueFontSizeFor6: 16.0)
        txtEmail.font=appDelegate!.setTheFontSize(txtEmail.font!, valueFontSizeFor6: 16.0)
        txtPassword.font=appDelegate!.setTheFontSize(txtPassword.font!, valueFontSizeFor6: 16.0)
        txtConfirm.font=appDelegate!.setTheFontSize(txtConfirm.font!, valueFontSizeFor6: 16.0)
        btnNext.titleLabel!.font=appDelegate!.setTheFontSize(btnNext.titleLabel!.font!, valueFontSizeFor6: 18.0)
        btnBack.titleLabel!.font=appDelegate!.setTheFontSize(btnBack.titleLabel!.font!, valueFontSizeFor6: 18.0)
        
       // if isProfile {
            print(UserDefaults.standard.object(forKey: USER_DETAILS)!)
            btnBack.setTitle("Menu",for: .normal)

        //GET DATA
        var dicUserDetails = NSMutableDictionary()
        dicUserDetails = (UserDefaults.standard.object(forKey: USER_DETAILS) as! NSMutableDictionary).mutableCopy() as! NSMutableDictionary
        
        
        //SET DETAILS
        txtFirstName.text=dicUserDetails.value(forKey: "first_name") as? String
        txtLasetName.text=dicUserDetails.value(forKey: "last_name") as? String
        txtTitle.text=dicUserDetails.value(forKey: "title") as? String
        txtEmail.text=dicUserDetails.value(forKey: "last_name") as? String
        txtLasetName.text=dicUserDetails.value(forKey: "last_name") as? String
        txtLasetName.text=dicUserDetails.value(forKey: "last_name") as? String
        txtLasetName.text=dicUserDetails.value(forKey: "last_name") as? String
        txtLasetName.text=dicUserDetails.value(forKey: "last_name") as? String

       // }

    }
    
    //....................................... UITEXTFIELD METHOD .........................................................//
    
    // MARK: - UITEXTFIELD METHOD
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.delegate = self
        textField.resignFirstResponder()
        return true
    }
    
    func setTheTextField(_ textFieldValue: UITextField?) {
        textFieldValue?.delegate = self
        textFieldValue?.setValue(appDelegate?.hexStringToUIColor(hex: "DC4D4D"), forKeyPath: "_placeholderLabel.textColor")
    }
    
    
    
    func actionsheet() {
        let actionSheetPhoto = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let actionCamera = UIAlertAction(title: "Take Photo", style: .default) { (action : UIAlertAction) in
            
            _ = self.startCameraFromViewController(self, withDelegate: self, sourceType: .camera)
        }

        let actionPhotoLibrary = UIAlertAction(title: "Choose Existing", style: .default) { (action : UIAlertAction) in
            
            _ = self.startCameraFromViewController(self, withDelegate: self, sourceType: .photoLibrary)
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheetPhoto.addAction(actionCamera)
        actionSheetPhoto.addAction(actionPhotoLibrary)
        actionSheetPhoto.addAction(actionCancel)
        self.present(actionSheetPhoto, animated: true, completion: nil)
        
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    func startCameraFromViewController(_ viewController: UIViewController, withDelegate delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate, sourceType : UIImagePickerControllerSourceType) -> Bool {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) == false {
            return false
        }
        
        cameraController = UIImagePickerController()
        cameraController.sourceType = sourceType
        cameraController.mediaTypes = [kUTTypeImage as String]
        cameraController.allowsEditing = false
        cameraController.delegate = delegate
        
        present(cameraController, animated: true, completion: nil)
        return true
    }

    func video(_ videoPath: NSString, didFinishSavingWithError error: NSError?, contextInfo info: AnyObject) {
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        dismiss(animated: true, completion: nil)
        
        if mediaType == kUTTypeImage ,
            let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            tempImage = pickedImage

            //SET BUTTON
            btnSelectPhoto.backgroundColor=UIColor.clear
            imgPhoto.layer.masksToBounds=true;
            imgPhoto.layer.cornerRadius=imgPhoto.frame.size.height / 2
            imgPhoto.image=pickedImage
        }
        
    }
    
    //....................................... ACTION BUTTO .........................................................//
    
    // MARK: - ACTION BUTTO

    @IBAction func btnBackclicked(_ sender: Any) {
        //BACK VIEW
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSelectPhotoClicked(_ sender: Any) {
        
        if !IS_IPAD {
            actionsheet()
        }
    }
    
    @IBAction func btnNextClicked(_ sender: Any) {
        
        
//        // CHECK THE INTERNET CONNECTION
//        if AppSingleton.connectedToNetwork() {
//            // START LOADING
//            appDelegate?.startLoadingview()
//            
//            //GET URL
//            let url: String = String(format:KEYFORAPIURL, "user/login.php")
//            //SET PARAMETER
//            let params = ["user_email_id" : strEmail,
//                          "user_fullname" : strPassword,
//                          "user_social_id" : "304739256704683"
//                
//            ]
//            
//            
//            //CALL API
//            ServerCall.sharedInstance.requestWithUrlAndParameters(.POST, urlString: url, parameters: params as [String : AnyObject], delegate: self as ServerCallDelegate, name: .serverCallNameLogin)
//            
//            
//        }
//        else {
//            appDelegate?.showAlertMessage(strMessage: "Please check your internet connection.")
//        }
//        
//
        // HIDE THE KEYBOARD
        self.view!.endEditing(true)
        
        //CHECK VALIDATION
        let strFirst = txtFirstName.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let strLast = txtLasetName.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let strTitle = txtTitle.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let strEmail = txtEmail.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let strPassword:String = txtPassword.text!
        let strConfirmPass:String = txtConfirm.text!

        if (strFirst?.characters.count==0){
            appDelegate?.showAlertMessage(strMessage: "Please enter first name.")
        }
        else if (strLast?.characters.count==0){
            appDelegate?.showAlertMessage(strMessage: "Please enter last name.")
        }
        else if (strTitle?.characters.count==0){
            appDelegate?.showAlertMessage(strMessage: "Please enter title.")
        }
        
        else if (strEmail?.characters.count==0){
            appDelegate?.showAlertMessage(strMessage: "Please enter email.")
        }
        else if (!appDelegate!.validateEmailAddress(testStr: strEmail!)){
            appDelegate?.showAlertMessage(strMessage: "Please enter validate email.")
        }
        else if (strPassword.characters.count==0 ){
            appDelegate?.showAlertMessage(strMessage: "Please enter password.")
        }
        else if (strConfirmPass.characters.count==0 ){
            appDelegate?.showAlertMessage(strMessage: "Please enter confirm password.")
        }
        else if (strPassword != strConfirmPass){
            appDelegate?.showAlertMessage(strMessage: "Password is not match.")

        }
        else{
            //SET PARAMETER
            var params = NSMutableDictionary()
            
            params = ["first_name" : strFirst!,
                          "last_name" : strLast!,
                          "title" : strTitle!,
                          "email" : strEmail!,
                          "password" : strPassword,
            ]
            
            //CALL METHOD LOGIN
            let singupView = SignUpSecondViewController(nibName: "SignUpSecondViewController", bundle: nil)
            singupView.dicData = params
            singupView.userImage = tempImage
            navigationController?.pushViewController(singupView as UIViewController , animated: true)
        }
        
      
        

    }

    
}
