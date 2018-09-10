//
//  SignUpSecondViewController.swift
//  Medio
//
//  Created by StrateCore - iMac1 on 31/03/18.
//  Copyright © 2018 StrateCore - iMac1. All rights reserved.
//

import UIKit

class SignUpSecondViewController: UIViewController,UITextFieldDelegate, ServerCallDelegate {

    //******************* ASSIGN VARIABLE *********************//
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTitle2: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var lblDetails: UILabel!
    
    @IBOutlet weak var txtFacilityName: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtZip: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnSelectTeams: UIButton!
    @IBOutlet weak var btnGetStartrd: UIButton!
    var dicData = NSMutableDictionary()
    var userImage = UIImage()
    
    //***********************************************************//

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //SET TEXT FIELD
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
        
        //SET LABLE
        lblDetails.text="May we contact you with relevent \n future promotions from our sponsors?"
        
        //SET VIEW
        viewMain.layer.masksToBounds = true
        viewMain.layer.cornerRadius = viewMain.frame.size.height / 2
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
        
        //SET BUTTON
        btnGetStartrd.layer.masksToBounds = true
        btnGetStartrd.layer.cornerRadius = btnGetStartrd.frame.size.height / 2
       
        btnSelectTeams.layer.borderWidth=1.0
        btnSelectTeams.layer.borderColor=UIColor.white.cgColor
        btnSelectTeams.layer.masksToBounds = true
        btnSelectTeams.layer.cornerRadius = btnSelectTeams.frame.size.height / 2
        
        
        //SET FONT
        lblTitle.font=appDelegate!.setTheFontSize(lblTitle.font, valueFontSizeFor6: 20.0)
        lblTitle2.font=appDelegate!.setTheFontSize(lblTitle2.font, valueFontSizeFor6: 16.0)
        lblInfo.font=appDelegate!.setTheFontSize(lblInfo.font, valueFontSizeFor6: 14.0)
        lblDetails.font=appDelegate!.setTheFontSize(lblDetails.font, valueFontSizeFor6: 14.0)
        txtFacilityName.font=appDelegate!.setTheFontSize(txtFacilityName.font!, valueFontSizeFor6: 16.0)
        txtAddress.font=appDelegate!.setTheFontSize(txtAddress.font!, valueFontSizeFor6: 16.0)
        txtCity.font=appDelegate!.setTheFontSize(txtCity.font!, valueFontSizeFor6: 16.0)
        txtState.font=appDelegate!.setTheFontSize(txtState.font!, valueFontSizeFor6: 16.0)
        txtZip.font=appDelegate!.setTheFontSize(txtZip.font!, valueFontSizeFor6: 16.0)
        txtPhoneNumber.font=appDelegate!.setTheFontSize(txtPhoneNumber.font!, valueFontSizeFor6: 16.0)
        btnGetStartrd.titleLabel!.font=appDelegate!.setTheFontSize(btnGetStartrd.titleLabel!.font!, valueFontSizeFor6: 18.0)
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
        textFieldValue?.setValue(appDelegate?.hexStringToUIColor(hex: "DC4D4D"), forKeyPath: "_placeholderLabel.textColor")
    }
    
    

    
    //....................................... UITEXTFIELD METHOD .........................................................//
    
    // MARK: - ACTION BUTTO
    
    @IBAction func btnBackClicked(_ sender: Any) {
        //BACK SCREEN
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnGetStartrdClicked(_ sender: Any) {
        
        // HIDE THE KEYBOARD
        self.view!.endEditing(true)
        
        //CHECK VALIDATION
        let strFacilityName = txtFacilityName.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        let strAddress = txtAddress.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        let strCity = txtCity.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        let strState = txtState.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        let strZip = txtZip.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        let strPhoneNumber = txtPhoneNumber.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if (strFacilityName?.characters.count==0){
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
            methodSignIn(strFacilityName: strFacilityName!, strAddress: strAddress!, strCity: strCity!, strState: strState!, strZip: strZip!, strPhoneNumber: strPhoneNumber!)
        }
        

    }
    
    @IBAction func btnSelectTeams(_ sender: Any){
        
    }
    
    
    
    
    
    
    ///................................................... METHOD SIGN IN .............................................................///
    
    //MARK: -METHOD SIGN IN
    func methodSignIn(strFacilityName: String, strAddress: String, strCity: String, strState: String, strZip: String, strPhoneNumber: String) {
        
        // CHECK THE INTERNET CONNECTION
        if AppSingleton.connectedToNetwork() {
            // START LOADING
            appDelegate?.startLoadingview()
            
            //GET URL
            let strUrl = KEYFORAPIURL + "signup"

//            let data = UIImageJPEGRepresentation(userImage, 1.0)
//            let base64String = data?.base64EncodedString(options: .lineLength64Characters)
            
            //SET PARAMETER
            let params = ["first_name" : dicData.value(forKey: "first_name")!,
                          "last_name" : dicData.value(forKey: "last_name")!,
                          "title" : dicData.value(forKey: "title")!,
                          "email" : dicData.value(forKey: "email")!,
                          "password" : dicData.value(forKey: "password")!,
                          "photo" : "",
                          "facility_name" : strFacilityName,
                          "address" : strAddress,
                          "city" : strCity,
                          "state" : strState,
                          "zip" : strZip,
                          "phone_number" : strPhoneNumber] as [String : Any]
                    
                
            //CALL API
            ServerCall.sharedInstance.requestWithUrlAndParameterInData(.POST, urlString: strUrl, parameters: params as [String : AnyObject], delegate: self as ServerCallDelegate, name: .serverCallNameRegister)
            


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
