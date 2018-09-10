//
//  HomeViewController.swift
//  Medio
//
//  Created by StrateCore - iMac1 on 02/04/18.
//  Copyright © 2018 StrateCore - iMac1. All rights reserved.
//

import UIKit
import MessageUI

class HomeViewController: UIViewController,UITextFieldDelegate ,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate, UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate{

    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var lblTitle1: UILabel!
    @IBOutlet weak var lblTitle2: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var viewChat: UIView!
    @IBOutlet weak var txtMessage: UITextField!
    @IBOutlet weak var btnHelp: UIButton!
 
    var tempImage = UIImage()
    var cameraController = UIImagePickerController()
    var arrChat = [NSMutableDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(UserDefaults.standard.object(forKey: USER_DETAILS)!)
    
        var dicUserDetails = NSMutableDictionary()
        dicUserDetails = (UserDefaults.standard.object(forKey: USER_DETAILS) as! NSMutableDictionary).mutableCopy() as! NSMutableDictionary
        
        print(dicUserDetails)
        //SET DETAILS
        let firstName = dicUserDetails.value(forKey: "first_name") as! String
        let lastName = dicUserDetails.value(forKey: "last_name") as! String
        lblTitle1.text = "Welcome Back" + "\(firstName)" + " " + "\(lastName)"
        lblTitle2.text = dicUserDetails.value(forKey: "title") as? String

        
        
        //TABLE VIEW DELEGATE
        tblView.dataSource = self
        tblView.delegate = self
        tblView.estimatedRowHeight = 10.0
        tblView.rowHeight = UITableViewAutomaticDimension
        tblView.reloadData()
        
        //SET TEXT FIELD
        setTheTextField(txtMessage)
    }
    
    
    override func viewDidLayoutSubviews() {
        setTheView()
    }
    
    
    func setTheView() {
        
        //SET VIEW
        viewChat.layer.masksToBounds = true
        viewChat.layer.cornerRadius = viewChat.frame.size.height / 2
        imgProfilePic.layer.masksToBounds = true
        imgProfilePic.layer.cornerRadius = imgProfilePic.frame.size.height / 2
        
        //SET FONT
        lblTitle1.font=appDelegate!.setTheFontSize(lblTitle1.font, valueFontSizeFor6: 16.0)
        lblTitle2.font=appDelegate!.setTheFontSize(lblTitle2.font, valueFontSizeFor6: 14.0)
        txtMessage.font=appDelegate!.setTheFontSize(txtMessage.font!, valueFontSizeFor6: 16.0)
        btnHelp.titleLabel!.font=appDelegate!.setTheFontSize(btnHelp.titleLabel!.font!, valueFontSizeFor6: 16.0)
        
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
        textFieldValue?.setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")
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
            
        }
        
    }
    
    
    //....................................  Table view data source ......................................................//
    
    // MARK: - Table view data source
    //-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //    return 1;
    //}
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrChat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let simpleTableIdentifier = "ChatCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier) as? ChatCell
        var arr = Bundle.main.loadNibNamed("ChatCell", owner: self, options: nil)
        cell = arr?[0] as? ChatCell
        cell?.selectionStyle = .none

        var dicData = NSMutableDictionary()
        dicData = arrChat[indexPath.row]
        let UserType = dicData.object(forKey: "type") as! String
        print(dicData)
        
        if UserType == "user" {
            //GET TEXT
            let strDetails = dicData .object(forKey: "text") as! String
            
            let expectedSize = strDetails.boundingRect(with: CGSize(width: tableView.frame.size.width - 100, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: appDelegate!.setTheFontForAllScreen(FONT_MEDIUM, valueFontSizeFor6: 16.0)!], context: nil).size
            
            
            
            //SET VIEW
            let viewUser = UIView(frame: CGRect(x: 8, y: 8, width: tblView.frame.size.width - 16, height: (expectedSize.height) + 50))
            
            //SET IMAGE
            
            let img = UIImageView(frame: CGRect(x: viewUser.frame.size.width - 45, y: ((expectedSize.height + 30)/2) - 17.5  , width: 35, height: 35))
            img.layer.masksToBounds=true
            img.layer.cornerRadius=img.frame.size.height/2
            img.backgroundColor=appDelegate!.hexStringToUIColor(hex: "457A8D")
            
            
            //SET MESSAGE
            let viewMessage: UIView? = UILabel(frame: CGRect(x: viewUser.frame.size.width - (expectedSize.width) - img.frame.size.width - 35, y: (viewUser.frame.size.height/2) - (((expectedSize.height) + 40)/2), width: (expectedSize.width) + 16, height: (expectedSize.height) + 20))
            viewMessage?.backgroundColor = appDelegate!.hexStringToUIColor(hex: "FF6E6E")
            viewMessage?.layer.masksToBounds = true
            viewMessage?.layer.cornerRadius=10
            
            //SET MESSAGE TEXT
            let lblMessage = UILabel(frame: CGRect(x: 8, y: 8, width: (expectedSize.width), height: (expectedSize.height)))
            lblMessage.text = strDetails
            lblMessage.numberOfLines = 100
            lblMessage.font = appDelegate!.setTheFontForAllScreen(FONT_MEDIUM, valueFontSizeFor6: 16.0)
            lblMessage.textColor = UIColor.white
            lblMessage.textAlignment = .left
            viewMessage?.addSubview(lblMessage)
//
//            //SET TIME TEXT
//            let lblTime = UILabel(frame: CGRect(x: 8, y: lblMessage.frame.origin.x + lblMessage.frame.size.height + 5, width: 100, height: 15))
//            lblTime.text = "1 minute ago"
//            lblTime.numberOfLines = 1
//            lblTime.font = appDelegate!.setTheFontForAllScreen(FONT_LIGHT, valueFontSizeFor6: 14.0)
//            lblTime.textColor = UIColor.white
//            lblTime.textAlignment = .left
//            viewMessage?.addSubview(lblTime)
            
            
            
            
            //ADD LABLE
            cell?.addSubview(viewMessage!)
            cell?.addSubview(img)

        }
        
        else{
            //GET TEXT
            let strDetails = dicData .object(forKey: "text") as! String
            
            let expectedSize = strDetails.boundingRect(with: CGSize(width: tableView.frame.size.width - 100, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: appDelegate!.setTheFontForAllScreen(FONT_MEDIUM, valueFontSizeFor6: 16.0)!], context: nil).size
            
            
            
            //SET VIEW
            let viewUser = UIView(frame: CGRect(x: 8, y: 8, width: tblView.frame.size.width - 16, height: (expectedSize.height)))
            
//            //SET IMAGE
//
//            let img = UIImageView(frame: CGRect(x: viewUser.frame.size.width - 45, y: ((expectedSize.height + 50)/2) - 17.5  , width: 35, height: 35))
//            img.layer.masksToBounds=true
//            img.layer.cornerRadius=img.frame.size.height/2
//            img.backgroundColor=appDelegate!.hexStringToUIColor(hex: "457A8D")
//
            
            //SET MESSAGE
            let viewMessage: UIView? = UILabel(frame: CGRect(x:20, y: (viewUser.frame.size.height/2) - (((expectedSize.height) + 40)/2), width: (expectedSize.width) + 16, height: (expectedSize.height) + 15))
            viewMessage?.backgroundColor = UIColor.white
            viewMessage?.layer.masksToBounds = true
            viewMessage?.layer.cornerRadius=10
            
            //SET MESSAGE TEXT
            let lblMessage = UILabel(frame: CGRect(x: 8, y: 8, width: (expectedSize.width), height: (expectedSize.height)))
            lblMessage.text = strDetails
            lblMessage.numberOfLines = 100
            lblMessage.font = appDelegate!.setTheFontForAllScreen(FONT_MEDIUM, valueFontSizeFor6: 14.0)
            lblMessage.textColor = appDelegate!.hexStringToUIColor(hex: "6ED5FF")
            lblMessage.textAlignment = .left
            viewMessage?.addSubview(lblMessage)
            
//            //SET TIME TEXT
//            let lblTime = UILabel(frame: CGRect(x: 8, y: lblMessage.frame.origin.x + lblMessage.frame.size.height + 5, width: 100, height: 15))
//            lblTime.text = "1 minute ago"
//            lblTime.numberOfLines = 1
//            lblTime.font = appDelegate!.setTheFontForAllScreen(FONT_LIGHT, valueFontSizeFor6: 14.0)
//            lblTime.textColor = UIColor.white
//            lblTime.textAlignment = .left
//            viewMessage?.addSubview(lblTime)
            
            
            
            
            //ADD LABLE
            cell?.addSubview(viewMessage!)
//            cell?.addSubview(img)
        }

        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var dicData = NSMutableDictionary()
        dicData = arrChat[indexPath.row]
        let strDetails = dicData.object(forKey: "text") as! String

        let expectedSize = strDetails.boundingRect(with: CGSize(width: tableView.frame.size.width - 100, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: appDelegate!.setTheFontForAllScreen(FONT_MEDIUM, valueFontSizeFor6: 16.0)!], context: nil).size
        return expectedSize.height + 50
    }

    
    //....................................... UITEXTFIELD METHOD .........................................................//
    
    
    @IBAction func btnMenuClcicked(_ sender: Any) {
        
    }
    
    @IBAction func btnHelpClicked(_ sender: Any) {
        
        
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            return
        }
        sendEmail()
    }
    
    @IBAction func btnCameraClicked(_ sender: Any) {
    }
    @IBAction func btnSendClicked(_ sender: Any) {
        
        let strMessage = txtMessage.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (strMessage!.characters.count==0){
        }else
        {
            // HIDE THE KEYBOARD
            view.endEditing(true)
            
            txtMessage.text = ""
            var time = Double()
            time = Date().timeIntervalSince1970
            
            //SET USER TEXT
            let dicData = NSMutableDictionary()
            dicData.setValue(strMessage, forKey: "text")
            dicData.setValue("user", forKey: "type")
            dicData.setValue("\(time)", forKey: "timestamp")
            arrChat.append(dicData)


            //IBM RESPONS
            let username = "7e8328de-fe51-41ba-95c5-fe69f1e7b648"
            let password = "QAvYTq2vUyRw"
            let version = "2018-05-11" // use today's date for the most recent version
            let assistant = Assistant(username: username, password: password, version: version)
            
            let workspaceID = "72488efd-d2bb-41a8-8282-38c487dd1239"
            
            
            let input = InputData(text: strMessage!)
            var context: Context?
            let request = MessageRequest(input: input, context: context)
            let failure = { (error: Error) in print(error) }
            assistant.message(workspaceID: workspaceID, request: request, failure: failure) {
                response in
                print(response.output.text)
                context = response.context
                
                //SET USER TEXT
                let strRespons = response.output.text as Array
                let dicData = NSMutableDictionary()
                dicData.setValue(strRespons[0], forKey: "text")
                dicData.setValue("ibm", forKey: "type")
                dicData.setValue("\(time)", forKey: "timestamp")
                self.arrChat.append(dicData)
                DispatchQueue.main.async {
                    self.tblView.reloadData()
                }
            }
            DispatchQueue.main.async {
                let index = IndexPath(row: self.arrChat.count-1, section: 0) // use your index number or Indexpath
                print(index.row)
                self.tblView.scrollToRow(at: index,at: .middle, animated: false) //here .middle is the scroll position can change it as per your need
            }

            tblView.reloadData()
        }
    }

    
    @IBAction func btnLogOutClicked(_ sender: Any) {
        
        //LOGOUT
        
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
        _ = navigationController?.popToRootViewController(animated: true)
    
    }
    
    
    //MARK: Email Compose
    func sendEmail() {
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        // Configure the fields of the interface.
        composeVC.setToRecipients(["ben@dignisoft.com"])
        composeVC.setSubject("Hello!")
        composeVC.setMessageBody("Hello this is my message body!", isHTML: false)
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
    }
    
    @nonobjc func mailComposeController(controller: MFMailComposeViewController,
                               didFinishWithResult result: MFMailComposeResult, error: Error?) {
        // Check the result or perform other tasks.
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
