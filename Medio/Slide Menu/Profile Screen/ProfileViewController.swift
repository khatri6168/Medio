//
//  ProfileViewController.swift
//  Medio
//
//  Created by StrateCore - iMac1 on 21/05/18.
//  Copyright © 2018 StrateCore - iMac1. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController,UITextFieldDelegate {

    //******************* ASSIGN VARIABLE *********************//
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTitle2: UILabel!

    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLasetName: UITextField!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtFacilityName: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtZip: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet var btnUpdate: UIButton!
    @IBOutlet weak var btnMenu: UIButton!
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
        setTheTextField(txtFacilityName)
        setTheTextField(txtAddress)
        setTheTextField(txtCity)
        setTheTextField(txtState)
        setTheTextField(txtZip)
        setTheTextField(txtPhoneNumber)


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
        txtFacilityName.layer.masksToBounds = true
        txtFacilityName.layer.sublayerTransform=CATransform3DMakeTranslation(10, 0, 0)
        txtFacilityName.layer.cornerRadius = txtFacilityName.frame.size.height / 2
        txtAddress.layer.masksToBounds = true
        txtAddress.layer.sublayerTransform=CATransform3DMakeTranslation(10, 0, 0)
        txtAddress.layer.cornerRadius = txtAddress.frame.size.height / 2
        txtCity.layer.masksToBounds = true
        txtCity.layer.cornerRadius = txtCity.frame.size.height / 2
        txtState.layer.masksToBounds = true
        txtState.layer.cornerRadius = txtState.frame.size.height / 2
        txtZip.layer.masksToBounds = true
        txtZip.layer.cornerRadius = txtZip.frame.size.height / 2
        txtPhoneNumber.layer.masksToBounds = true
        txtPhoneNumber.layer.cornerRadius = txtPhoneNumber.frame.size.height / 2
        
       
        
        //SET FONT
        lblTitle.font=appDelegate!.setTheFontSize(lblTitle.font, valueFontSizeFor6: 16.0)
        lblTitle2.font=appDelegate!.setTheFontSize(lblTitle2.font, valueFontSizeFor6: 16.0)
        txtFirstName.font=appDelegate!.setTheFontSize(txtFirstName.font!, valueFontSizeFor6: 16.0)
        txtLasetName.font=appDelegate!.setTheFontSize(txtLasetName.font!, valueFontSizeFor6: 16.0)
        txtTitle.font=appDelegate!.setTheFontSize(txtTitle.font!, valueFontSizeFor6: 16.0)
        txtEmail.font=appDelegate!.setTheFontSize(txtEmail.font!, valueFontSizeFor6: 16.0)
        txtFacilityName.font=appDelegate!.setTheFontSize(txtFacilityName.font!, valueFontSizeFor6: 16.0)
        txtAddress.font=appDelegate!.setTheFontSize(txtAddress.font!, valueFontSizeFor6: 16.0)
        txtCity.font=appDelegate!.setTheFontSize(txtCity.font!, valueFontSizeFor6: 16.0)
        txtState.font=appDelegate!.setTheFontSize(txtState.font!, valueFontSizeFor6: 16.0)
        txtZip.font=appDelegate!.setTheFontSize(txtZip.font!, valueFontSizeFor6: 16.0)
        txtPhoneNumber.font=appDelegate!.setTheFontSize(txtPhoneNumber.font!, valueFontSizeFor6: 16.0)
        
        // if isProfile {
        print(UserDefaults.standard.object(forKey: USER_DETAILS)!)
        
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
    
    
    
    //MARK :- ACTION BUTTON
    
    @IBAction func btnMenuClicked(_ sender: Any) {
    }
    

    @IBAction func btnUpdateClicked(_ sender: Any) {
        
        // HIDE THE KEYBOARD
        self.view!.endEditing(true)
        
        //CHECK VALIDATION
        let strFirst = txtFirstName.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let strLast = txtLasetName.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let strTitle = txtTitle.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let strEmail = txtEmail.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let strFacilityName = txtFacilityName.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        let strAddress = txtAddress.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        let strCity = txtCity.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        let strState = txtState.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        let strZip = txtZip.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        let strPhoneNumber = txtPhoneNumber.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        

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
        else if (strFacilityName?.characters.count==0){
            appDelegate?.showAlertMessage(strMessage: "Please enter Facility name.")
        }
        else if (strAddress?.characters.count==0){
            appDelegate?.showAlertMessage(strMessage: "Please enter address.")
        }
        else if (strCity?.characters.count==0){
            appDelegate?.showAlertMessage(strMessage: "Please enter city.")
        }
            
        else if (strState?.characters.count==0){
            appDelegate?.showAlertMessage(strMessage: "Please enter state.")
        }
        else if (strZip?.characters.count==0){
            appDelegate?.showAlertMessage(strMessage: "Please enter state.")
        }
        else if (strPhoneNumber?.characters.count==0 ){
            appDelegate?.showAlertMessage(strMessage: "Please enter phone number.")
        }
        else{
            
            //CALL METHOD
            methodSignIn(strFirst: strFirst!, strLast: strLast!, strTitle: strTitle!, strFacilityName: strFacilityName!, strAddress: strAddress!, strCity: strCity!, strState: strState!, strZip: strZip!, strPhoneNumber: strPhoneNumber!)
        }
        
    }
    
    
    ///................................................... METHOD SIGN IN .............................................................///
    
    //MARK: -METHOD SIGN IN
    func methodSignIn(strFirst: String,strLast: String,strTitle: String,strFacilityName: String, strAddress: String, strCity: String, strState: String, strZip: String, strPhoneNumber: String) {
        
        // CHECK THE INTERNET CONNECTION
        if AppSingleton.connectedToNetwork() {
            // START LOADING
            appDelegate?.startLoadingview()
            
            //GET URL
            let strUrl = KEYFORAPIURL + "admin/updateprofile"
            
            //            let data = UIImageJPEGRepresentation(userImage, 1.0)
            //            let base64String = data?.base64EncodedString(options: .lineLength64Characters)
            
            ///GET USER ID
            var dicUserDetails = NSMutableDictionary()
            dicUserDetails = (UserDefaults.standard.object(forKey: USER_DETAILS) as! NSMutableDictionary).mutableCopy() as! NSMutableDictionary
            
            let userID = dicUserDetails.value(forKey: "user_id") as! NSNumber
            //first_name,last_name,title,facility_name,phone_number,address,city,state,zip,
            //SET PARAMETER
            let params = [
                          "user_id" : userID.stringValue,
                          "first_name" : strFirst,
                          "last_name" : strLast,
                          "title" : strTitle,
                          "facility_name" : strFacilityName,
                          "address" : strAddress,
                          "city" : strCity,
                          "state" : strState,
                          "zip" : strZip,
                          "phone_number" : strPhoneNumber] as [String : Any]
            

            //CALL API
            ServerCall.sharedInstance.requestWithUrlAndParameterInData(.POST, urlString: strUrl, parameters: params as [String : AnyObject], delegate: self as! ServerCallDelegate, name: .serverCallNameRegister)
            
            
            
        }
        else {
            appDelegate?.showAlertMessage(strMessage: "Please check your internet connection.")
        }
        
    }
    
    // MARK: - Server Call Delegate
    func ServerCallSuccess(_ resposeObject: AnyObject, name: ServerCallName) {
        
        //STOP LOADING
        appDelegate?.stopLoadingView()
        
        if name == ServerCallName.serverCallNameRegister {
            let dicData = resposeObject as! [AnyHashable : Any]
            let status = dicData["status"] as! NSString
            
            if status .isEqual(to: "1") {
                
                //SHOW MESSAGE
                appDelegate!.showAlertMessage(strMessage: dicData["success_message"] as! String )
                
                for vc: UIViewController in (navigationController?.viewControllers)! {
                    if (vc is LoginViewController) {
                        _ = navigationController?.popToViewController(vc, animated: true)
                    }
                }
            }
            else{
                //ERRO MESSAGE
                appDelegate!.showAlertMessage(strMessage: dicData["error_message"] as! String )
            }
            
            
            //MOVE TO HOME
        }
        
    }
    
    func ServerCallFailed(_ errorObject: String, name: ServerCallName) {
        //STOP LOADING
        appDelegate?.stopLoadingView()
        
        appDelegate!.showAlertMessage(strMessage: errorObject )
    }

}
