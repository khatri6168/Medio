//
//  ChangePasswordViewController.swift
//  Medio
//
//  Created by StrateCore - iMac1 on 21/05/18.
//  Copyright © 2018 StrateCore - iMac1. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController ,UITextFieldDelegate,ServerCallDelegate{

    @IBOutlet weak var lblHrader: UILabel!
    @IBOutlet weak var txtOldPass: UITextField!
    @IBOutlet weak var txtNewPass: UITextField!
    @IBOutlet weak var txtConfirmPass: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
        //SET STATUS BAR
        self.navigationController!.isNavigationBarHidden = true
        
        //SET TEXT FIELD
        setTheTextField(txtOldPass)
        setTheTextField(txtNewPass)
        setTheTextField(txtConfirmPass)
        
    }
    
    override func viewDidLayoutSubviews() {
        setTheView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        txtOldPass.text=""
        txtNewPass.text=""
        txtConfirmPass.text=""
    }
    
    
    func setTheView() {
        
        //SET VIEW
        txtOldPass.layer.masksToBounds = true
        txtOldPass.layer.cornerRadius = txtOldPass.frame.size.height / 2
        txtNewPass.layer.masksToBounds = true
        txtNewPass.layer.cornerRadius = txtNewPass.frame.size.height / 2
        txtConfirmPass.layer.masksToBounds = true
        txtConfirmPass.layer.cornerRadius = txtConfirmPass.frame.size.height / 2
        
        //SET BUTTON
        btnSubmit.layer.masksToBounds = true
        btnSubmit.layer.cornerRadius = btnSubmit.frame.size.height / 2
        
        
        //SET FONT
        lblHrader.font=appDelegate!.setTheFontSize(lblHrader.font, valueFontSizeFor6: 18.0)
        txtOldPass.font=appDelegate!.setTheFontSize(txtOldPass.font!, valueFontSizeFor6: 16.0)
        txtNewPass.font=appDelegate!.setTheFontSize(txtNewPass.font!, valueFontSizeFor6: 16.0)
        txtConfirmPass.font=appDelegate!.setTheFontSize(txtConfirmPass.font!, valueFontSizeFor6: 16.0)
        btnSubmit.titleLabel!.font=appDelegate!.setTheFontSize(btnSubmit.titleLabel!.font!, valueFontSizeFor6: 18.0)
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
        textFieldValue?.setValue(appDelegate?.hexStringToUIColor(hex: "499FC2"), forKeyPath: "_placeholderLabel.textColor")
    }
    
    
    
    
    //....................................... ACTION BUTTO .........................................................//
    
    // MARK: - ACTION BUTTO
    
    @IBAction func btnBackClicked(_ sender: Any) {
        //BACK SCREEN
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSubmitClicked(_ sender: Any) {
        // HIDE THE KEYBOARD
        self.view!.endEditing(true)
        
        //CHECK VALIDATION
        let strOldPassword:String = txtOldPass.text!
        let strNewPassword:String = txtNewPass.text!
        let strConfirmPassword:String = txtConfirmPass.text!
        
        if strOldPassword.characters.count==0 {
            appDelegate?.showAlertMessage(strMessage: "Please enter old password.")
        }
        else if strNewPassword.characters.count==0 {
            appDelegate?.showAlertMessage(strMessage: "Please enter new password.")
        }
        else if strConfirmPassword.characters.count==0{
            appDelegate?.showAlertMessage(strMessage: "Please enter confirm password.")
        }
        else if strNewPassword != strConfirmPassword {
            appDelegate?.showAlertMessage(strMessage: "New password and confrim password is not match.");

        }
        else{
            //CALL METHOD LOGIN
            methodChangePassword(strOldPass: strOldPassword, strNewPass: strNewPassword)
        }
    }
    

    
    ///................................................... METHOD LOGI IN .............................................................///
    
    //MARK: -METHOD SIGN IN
    func methodChangePassword(strOldPass: String, strNewPass: String) {
        
        // CHECK THE INTERNET CONNECTION
        //  if AppSingleton.connectedToNetwork() {
        // START LOADING
        appDelegate?.startLoadingview()

        //GET URL
        let strUrl = KEYFORAPIURL + "changepassword"
        
        ///GET USER ID
        var dicUserDetails = NSMutableDictionary()
        dicUserDetails = (UserDefaults.standard.object(forKey: USER_DETAILS) as! NSMutableDictionary).mutableCopy() as! NSMutableDictionary

        let userID = dicUserDetails.value(forKey: "user_id") as! NSNumber

        //SET PARAMETER
        let params = ["user_id" : userID.stringValue,
                      "new_password" : strNewPass,
                      "old_password" :strOldPass
            
            ]
        print(params)
        
        //CALL API
        ServerCall.sharedInstance.requestWithUrlAndParameterInData(.POST, urlString: strUrl, parameters: params as [String : AnyObject], delegate: self as ServerCallDelegate, name: .serverCallNameLogin)
        
        //        }
        //        else {
        //            appDelegate?.showAlertMessage(strMessage: "Please check your internet connection.")
        //        }
        
    }
    
    // MARK: - Server Call Delegate
    func ServerCallSuccess(_ resposeObject: AnyObject, name: ServerCallName) {
        
        //STOP LOADING
        appDelegate?.stopLoadingView()
        
        if name == ServerCallName.serverCallNameLogin {
            
            let dicData = resposeObject as! [AnyHashable : Any]
            let status = dicData["status"] as! NSString
                        
            if status .isEqual(to: "1") {
                
                //SUCCESS
                appDelegate!.showAlertMessage(strMessage: dicData["success_message"] as! String )

            }
            else{
                appDelegate!.showAlertMessage(strMessage: dicData["error_message"] as! String )
                
            }
        }
        
    }
    
    func ServerCallFailed(_ errorObject: String, name: ServerCallName) {
        print(errorObject)
        //STO`P LOADING
        appDelegate?.stopLoadingView()
        
        if errorObject.isEqual("The Internet connection appears to be offline.") {
            appDelegate?.showAlertMessage(strMessage: "Please check your internet connection.")
            
        }
        else{
            appDelegate!.showAlertMessage(strMessage: errorObject )
            
        }
    }
    


}
