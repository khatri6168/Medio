//
//  ForgotPasswordViewController.swift
//  Medio
//
//  Created by StrateCore - iMac1 on 21/05/18.
//  Copyright © 2018 StrateCore - iMac1. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController ,UITextFieldDelegate, ServerCallDelegate{

    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var viewMain: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //SET STATUS BAR
        self.navigationController!.isNavigationBarHidden = true
        
        //SET TEXT FIELD
        setTheTextField(txtEmail)
        
    }

    override func viewDidLayoutSubviews() {
        setTheView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        txtEmail.text=""
    }
    
    func sampleTapGestureTapped(recognizer: UITapGestureRecognizer) {
        print("Tapping working")
    }
    
    func setTheView() {
        
        //SET VIEW
        viewMain.layer.masksToBounds = true
        viewMain.layer.cornerRadius = viewMain.frame.size.height / 2
        txtEmail.layer.masksToBounds = true
        txtEmail.layer.cornerRadius = txtEmail.frame.size.height / 2
      
        //SET BUTTON
        btnSubmit.layer.masksToBounds = true
        btnSubmit.layer.cornerRadius = btnSubmit.frame.size.height / 2
        
        
        //SET FONT
        lblHeader.font=appDelegate!.setTheFontSize(lblHeader.font, valueFontSizeFor6: 18.0)
        txtEmail.font=appDelegate!.setTheFontSize(txtEmail.font!, valueFontSizeFor6: 16.0)
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
    
    
    
    
    //....................................... UITEXTFIELD METHOD .........................................................//
    
    // MARK: - ACTION BUTTO
    
    
    @IBAction func btnBackClicked(_ sender: Any) {
        //BACK SCREEN
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSubmitClicked(_ sender: Any) {
        
        
        // HIDE THE KEYBOARD
        self.view!.endEditing(true)
        
        //CHECK VALIDATION
        let strEmail = txtEmail.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if (strEmail!.characters.count==0){
            appDelegate?.showAlertMessage(strMessage: "Please enter email.")
        }
        else if (!appDelegate!.validateEmailAddress(testStr: strEmail!)){
            appDelegate?.showAlertMessage(strMessage: "Please enter validate email.")
        }
       
        else{
            //CALL METHOD LOGIN
            methodSignIn(strEmail: strEmail!)
        }
    }

    
    
    ///................................................... METHOD LOGI IN .............................................................///
    
    //MARK: -METHOD SIGN IN
    func methodSignIn(strEmail: String) {
        
        // CHECK THE INTERNET CONNECTION
        //  if AppSingleton.connectedToNetwork() {
        // START LOADING
        appDelegate?.startLoadingview()

        let strUrl = KEYFORAPIURL + "forgetpassword"
        //SET PARAMETER
        let params = ["email" : strEmail]
        
        
        //CALL API
        ServerCall.sharedInstance.requestWithUrlAndParameterInData(.POST, urlString: strUrl, parameters: params as [String : AnyObject], delegate: self as ServerCallDelegate, name: .serverCallNameLogin)
        
    }
    
    // MARK: - Server Call Delegate
    func ServerCallSuccess(_ resposeObject: AnyObject, name: ServerCallName) {
        
        //STOP LOADING
        appDelegate?.stopLoadingView()
        
        if name == ServerCallName.serverCallNameLogin {
            
            let dicData = resposeObject as! [AnyHashable : Any]
            let status = dicData["status"] as! NSString
            
            print(dicData)
            if status .isEqual(to: "1") {
                
                //SHOW MESSAGE
                appDelegate!.showAlertMessage(strMessage: dicData["success_message"] as! String )

                //BACK SCREEN
                _ = navigationController?.popViewController(animated: true)

                
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
