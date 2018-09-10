//
//  ActivationViewController.swift
//  Medio
//
//  Created by StrateCore - iMac1 on 02/04/18.
//  Copyright © 2018 StrateCore - iMac1. All rights reserved.
//

import UIKit

class ActivationViewController: UIViewController ,UITextFieldDelegate, ServerCallDelegate{

//******************* ASSIGN VARIABLE *********************//

    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lblTitle1: UILabel!
    @IBOutlet weak var lblTitle2: UILabel!
    @IBOutlet weak var lblTitle3: UILabel!
    @IBOutlet weak var lblTitle4: UILabel!
    @IBOutlet weak var lblor: UILabel!
    
    @IBOutlet weak var txt1: UITextField!
    @IBOutlet weak var txt2: UITextField!
    @IBOutlet weak var txt3: UITextField!
    @IBOutlet weak var btnEnter: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    var strUserId = NSNumber()

//***********************************************************//

    override func viewDidLoad() {
        super.viewDidLoad()

        //SET STATUS BAR
        self.navigationController!.isNavigationBarHidden = true
                
        //SET TEXT FIELD
        setTheTextField(txt1)
        setTheTextField(txt2)
        setTheTextField(txt3)
        
    }
    
    
    override func viewDidLayoutSubviews() {
        setTheView()
    }

    //HIDE KEYBOARD TO TOUCH THE SCREEN
    func handleTap(_ tapRecognizer: UITapGestureRecognizer) {
        // HIDE THE KEYBOARD
        self.view!.endEditing(true)
    }
    
    
    func sampleTapGestureTapped(recognizer: UITapGestureRecognizer) {
        print("Tapping working")
    }
    func setTheView() {
        
        //SET LABLE
        lblTitle4.text="D o n t  h a v e  a n  a c t i v a t i o n \n k e y? (C l i c k  H e r e)"
        
        //SET VIEW
        viewMain.layer.masksToBounds = true
        viewMain.layer.cornerRadius = viewMain.frame.size.height / 2
        txt1.layer.masksToBounds = true
        txt1.layer.sublayerTransform=CATransform3DMakeTranslation(10, 0, 0)
        txt1.layer.cornerRadius = txt1.frame.size.height / 2
        txt2.layer.masksToBounds = true
        txt2.layer.sublayerTransform=CATransform3DMakeTranslation(10, 0, 0)
        txt2.layer.cornerRadius = txt2.frame.size.height / 2
        txt3.layer.masksToBounds = true
        txt3.layer.sublayerTransform=CATransform3DMakeTranslation(10, 0, 0)
        txt3.layer.cornerRadius = txt3.frame.size.height / 2
        
        //SET BUTTON
        btnEnter.layer.masksToBounds = true
        btnEnter.layer.cornerRadius = btnEnter.frame.size.height / 2
        
        
        //SET FONT
        lblTitle1.font=appDelegate!.setTheFontSize(lblTitle1.font, valueFontSizeFor6: 20.0)
        lblTitle2.font=appDelegate!.setTheFontSize(lblTitle2.font, valueFontSizeFor6: 25.0)
        lblTitle3.font=appDelegate!.setTheFontSize(lblTitle3.font, valueFontSizeFor6: 16.0)
        lblTitle3.font=appDelegate!.setTheFontSize(lblTitle3.font, valueFontSizeFor6: 16.0)
        lblTitle3.font=appDelegate!.setTheFontSize(lblTitle3.font, valueFontSizeFor6: 12.0)
        lblTitle4.font=appDelegate!.setTheFontSize(lblTitle4.font, valueFontSizeFor6: 14.0)

        lblor.font=appDelegate!.setTheFontSize(lblor.font, valueFontSizeFor6: 16.0)
        txt1.font=appDelegate!.setTheFontSize(txt1.font!, valueFontSizeFor6: 16.0)
        txt2.font=appDelegate!.setTheFontSize(txt2.font!, valueFontSizeFor6: 16.0)
        txt3.font=appDelegate!.setTheFontSize(txt3.font!, valueFontSizeFor6: 16.0)
        txt1.layer.sublayerTransform=CATransform3DMakeTranslation(10, 0, 0)
        txt2.layer.sublayerTransform=CATransform3DMakeTranslation(10, 0, 0)
        txt3.layer.sublayerTransform=CATransform3DMakeTranslation(10, 0, 0)

        btnEnter.titleLabel!.font=appDelegate!.setTheFontSize(btnEnter.titleLabel!.font!, valueFontSizeFor6: 18.0)
        btnBack.titleLabel!.font=appDelegate!.setTheFontSize(btnBack.titleLabel!.font!, valueFontSizeFor6: 18.0)


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
    
    
    //SET TEXT VALIDATION
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
            if textField==txt1 {
                
                if (textField.text?.characters.count)!<4 {
                    return true
                }
                else{
                    txt2 .becomeFirstResponder()
                }
            }
            else if textField==txt2 {
                
                if (txt1.text?.characters.count)! == 4 {
                    if (textField.text?.characters.count)!<4 {
                        if (textField.text?.characters.count)! <= 1 && string.characters.count==0{
                            txt1 .becomeFirstResponder()
                            txt2.text=""
                        }
                        else{
                            return true
                            
                        }                    }
                    else{
                        txt3 .becomeFirstResponder()
                    }
                }
                else{
                    txt1 .becomeFirstResponder()
                }
            }
                
            else if textField==txt3 {
                if (txt2.text?.characters.count)! == 4 {
                    if (textField.text?.characters.count)!<10 {
                        
                        if (textField.text?.characters.count)! <= 1 && string.characters.count==0{
                            txt2 .becomeFirstResponder()
                            txt3.text=""
                        }
                        else{
                            return true

                        }
                    }
                    else{
                        
                        if string.characters.count==0 {
                            return true
                        }
                        else{
                            return false
                        }
                    }
                }
                else{
                    if (txt1.text?.characters.count)! != 4 {
                        txt1 .becomeFirstResponder()

                    }else{
                        txt2 .becomeFirstResponder()

                    }
                }
            }
        
    return true

    }
    
    
    // MARK: - ACTION BUTTO
    
    @IBAction func btnBackclicked(_ sender: Any) {
       
        let alertController = UIAlertController(title: KEYFORAPPNAME, message: "Are you sure you want to logout?", preferredStyle: UIAlertControllerStyle.alert)
        let DestructiveAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            print("Destructive")
        }
        
        // Replace UIAlertActionStyle.Default by UIAlertActionStyle.default
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
    
           //LOGOUT
            self.LogOut()
        }
        alertController.addAction(DestructiveAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func LogOut(){
        
        //REMOVE USER DATA
        UserDefaults.standard.removeObject(forKey: USER_DETAILS)
        
        //BACK VIEW
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func btnActivationClicked(_ sender: Any) {
        
    }
    @IBAction func btnEnterClicked(_ sender: Any) {

        // HIDE THE KEYBOARD
        self.view!.endEditing(true)
        
        //CHECK VALIDATION
        
        
        let strActiveKey = txt1.text! + txt2.text! + txt3.text!
        
        //CALL METHOD LOGIN
       methodActiveKey(strId: strUserId, strKey: strActiveKey)
       
    }
    
    @IBAction func btnSignUpClicked(_ sender: Any) {
        
        //MOVE TO SING UP SCREEN
        let singupView = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
        navigationController?.pushViewController(singupView as UIViewController , animated: true)
        
    }
    
    ///................................................... METHOD ACTIVE KEY .............................................................///
    
    //MARK: -METHOD SIGN IN
    func methodActiveKey(strId: NSNumber, strKey: String) {
        
        // CHECK THE INTERNET CONNECTION
        if AppSingleton.connectedToNetwork() {
            // START LOADING
            appDelegate?.startLoadingview()
            
            //GET URL
            let strUrl = KEYFORAPIURL + "verify"
            
            
            //SET PARAMETER
            let params = ["user_id" : strId,
                          "activation_key" : strKey
                
            ] as [String : Any]
            
            print(params)
            ServerCall.sharedInstance.requestWithUrlAndParameterInData(.POST, urlString: strUrl, parameters: params as [String : AnyObject], delegate: self as ServerCallDelegate, name: .serverCallNameLogin)

            
        }
        else {
            appDelegate?.showAlertMessage(strMessage: "Please check your internet connection.")
        }
        
    }
    
    
    
    // MARK: - Server Call Delegate
    func ServerCallSuccess(_ resposeObject: AnyObject, name: ServerCallName) {
        
        //STOP LOADING
        appDelegate?.stopLoadingView()

        if name == ServerCallName.serverCallNameLogin {
            
            let dicData = resposeObject as! [AnyHashable : Any]
            print(dicData)
            let status = dicData["status"] as! NSString
            
            if status .isEqual(to: "1") {
                
                //MOVE TO ACTIVATION KEY
                let activeKeyView = HomeViewController(nibName: "HomeViewController", bundle: nil)
                navigationController?.pushViewController(activeKeyView as UIViewController , animated: true)

            }
            else{
                appDelegate!.showAlertMessage(strMessage: dicData["error_message"] as! String )

            }
        }
    }
    
    func ServerCallFailed(_ errorObject: String, name: ServerCallName) {
        //STOP LOADING
        appDelegate?.stopLoadingView()
        
        appDelegate!.showAlertMessage(strMessage: errorObject )

        
    }
    
    
    
}
