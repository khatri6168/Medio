 //
//  LoginViewController.swift
//  Medio
//
//  Created by StrateCore - iMac1 on 30/03/18.
//  Copyright © 2018 StrateCore - iMac1. All rights reserved.
//

import UIKit
import Alamofire


class LoginViewController: UIViewController ,UITextFieldDelegate, ServerCallDelegate {

//******************* ASSIGN VARIABLE *********************//
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var btnEnter: UIButton!
    @IBOutlet weak var lblMainHeader: UILabel!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblOr: UILabel!
    
    @IBOutlet weak var lblTitle1: UILabel!
    @IBOutlet weak var lblTitle2: UILabel!
    @IBOutlet weak var lblTitle3: UILabel!
    @IBOutlet weak var btnSignUp: UIButton!

//***********************************************************//

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
//        let failure = { (error: Error) in print(error) }
//        var context: Context? // save context to continue conversation
//        assistant.message(workspaceID: workspaceID, failure: failure) {
//            response in
//            print(response.output.text)
//            context = response.context
//        }


        //SET STATUS BAR
        self.navigationController!.isNavigationBarHidden = true

        //SET TEXT FIELD
        setTheTextField(txtEmail)
        setTheTextField(textPassword)
        
        //CHECK USER IS LOGIN
        if (UserDefaults.standard.object(forKey: USER_DETAILS) != nil) {
            //GET USER DATA
            var dicUserDetails = NSMutableDictionary()
            dicUserDetails = (UserDefaults.standard.object(forKey: USER_DETAILS) as! NSMutableDictionary).mutableCopy() as! NSMutableDictionary
            print(dicUserDetails);
            //CHECK IS VERIFIED
            let isVerified = dicUserDetails.value(forKey: "is_verified_activation") as! NSNumber
            
            if isVerified==0 {
                //IS FALSE
            
                //MOVE TO ACTIVATION KEY
                let activeKeyView = ActivationViewController(nibName: "ActivationViewController", bundle: nil)
                activeKeyView.strUserId = dicUserDetails.value(forKey: "user_id") as! NSNumber
                navigationController?.pushViewController(activeKeyView as UIViewController , animated: true)
                
            }
            else{
                //IS TRUE
                
                //MOVE TO HOME SCREEN
                let activeKeyView = HomeViewController(nibName: "HomeViewController", bundle: nil)
                navigationController?.pushViewController(activeKeyView as UIViewController , animated: true)
                
              
                
            }
        }
    }

    //HIDE KEYBOARD TO TOUCH THE SCREEN
    func handleTap(_ tapRecognizer: UITapGestureRecognizer) {
        // HIDE THE KEYBOARD
        self.view!.endEditing(true)
    }
    
    override func viewDidLayoutSubviews() {
        setTheView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        txtEmail.text=""
        textPassword.text=""
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
        textPassword.layer.masksToBounds = true
        textPassword.layer.cornerRadius = textPassword.frame.size.height / 2
        
        //SET BUTTON
        btnEnter.layer.masksToBounds = true
        btnEnter.layer.cornerRadius = btnEnter.frame.size.height / 2
        
        
        //SET FONT
//        lblMainHeader.font = appDelegate!.setTheFontForAllScreen(appDelegate?.FONT_BAUHAUS93, valueFontSizeFor6: 40)
 //       lblHeader.font = appDelegate!.setTheFontForAllScreen(appDelegate?.FONT_BAUHAUS93, valueFontSizeFor6: 25)

        lblTitle1.font=appDelegate!.setTheFontSize(lblTitle1.font, valueFontSizeFor6: 8.0)
        lblTitle2.font=appDelegate!.setTheFontSize(lblTitle2.font, valueFontSizeFor6: 8.0)
        lblTitle3.font=appDelegate!.setTheFontSize(lblTitle3.font, valueFontSizeFor6: 8.0)
        lblOr.font=appDelegate!.setTheFontSize(lblOr.font, valueFontSizeFor6: 16.0)
        txtEmail.font=appDelegate!.setTheFontSize(txtEmail.font!, valueFontSizeFor6: 16.0)
        textPassword.font=appDelegate!.setTheFontSize(textPassword.font!, valueFontSizeFor6: 16.0)
        btnEnter.titleLabel!.font=appDelegate!.setTheFontSize(btnEnter.titleLabel!.font!, valueFontSizeFor6: 18.0)
        btnSignUp.titleLabel!.font=appDelegate!.setTheFontSize(btnSignUp.titleLabel!.font!, valueFontSizeFor6: 16.0)
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
    
    @IBAction func btnEnterClicked(_ sender: Any) {
      
        // HIDE THE KEYBOARD
        self.view!.endEditing(true)
        
        //CHECK VALIDATION
        let strEmail = txtEmail.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let strPassword:String = textPassword.text!

        if (strEmail?.characters.count==0){
            appDelegate?.showAlertMessage(strMessage: "Please enter email.")
        }
        else if (!appDelegate!.validateEmailAddress(testStr: strEmail!)){
            appDelegate?.showAlertMessage(strMessage: "Please enter validate email.")
        }
        else if (strPassword.characters.count==0 ){
            appDelegate?.showAlertMessage(strMessage: "Please enter password.")
        }
        else{
            //CALL METHOD LOGIN
            methodSignIn(strEmail: strEmail!, strPassword: strPassword)
        }
    }
    
    @IBAction func btnSignUpClicked(_ sender: Any) {
        
        //MOVE TO SING UP SCREEN
        let singupView = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
        navigationController?.pushViewController(singupView as UIViewController , animated: true)

    }
    
    @IBAction func btnForgotPasswordClicked(_ sender: Any) {
        //MOVE TO FORGOT PASSWORD SCREEN
        let forgotPassView = ForgotPasswordViewController(nibName: "ForgotPasswordViewController", bundle: nil)
        navigationController?.pushViewController(forgotPassView as UIViewController , animated: true)

    }
    
    
    ///................................................... METHOD LOGI IN .............................................................///
    
    //MARK: -METHOD SIGN IN
    func methodSignIn(strEmail: String, strPassword: String) {
       
        // CHECK THE INTERNET CONNECTION
      //  if AppSingleton.connectedToNetwork() {
            // START LOADING
            appDelegate?.startLoadingview()
            
            //GET URL
            let strUrl = KEYFORAPIURL + "login"
            //SET PARAMETER
            let params = ["email" : strEmail,
                          "password" : strPassword
                
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
            print(dicData);
            if status .isEqual(to: "1") {
                
                let dicUserData = dicData["user_details"]as! NSDictionary
                let isVerified = dicUserData.value(forKey: "is_verified_activation") as! NSNumber
                let userId = dicUserData.value(forKey: "user_id") as! NSNumber
                
                //SET DATA
                let myMutableDict: NSMutableDictionary = NSMutableDictionary(dictionary: dicUserData)
                UserDefaults.standard.set(myMutableDict, forKey: USER_DETAILS)
                UserDefaults.standard.synchronize()
                
                if isVerified==0 {
                    //MOVE TO ACTIVATION KEY
                    let activeKeyView = ActivationViewController(nibName: "ActivationViewController", bundle: nil)
                    activeKeyView.strUserId = userId
                    navigationController?.pushViewController(activeKeyView as UIViewController , animated: true)

                }
                else{
                    //MOVE TO HOME SCREEN
                    let activeKeyView = HomeViewController(nibName: "HomeViewController", bundle: nil)
                    navigationController?.pushViewController(activeKeyView as UIViewController , animated: true)

                }

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

    ///........................................................................................................................................///

}
