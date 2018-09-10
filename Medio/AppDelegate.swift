//
//  AppDelegate.swift
//  Medio
//
//  Created by StrateCore - iMac1 on 30/03/18.
//  Copyright © 2018 StrateCore - iMac1. All rights reserved.
//

import UIKit



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    //DECLARATION VARIABLE
    var viewShowLoad: UIView?
    var objSpinKit: RTSpinKitView?

    var window: UIWindow?
    var objMainNavigation: UINavigationController?

    //FONT NAME
    let FONT_BAUHAUS93 = "Bauhaus 93 Regular"
    
  
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
       /* for fontfamilyname: String in UIFont.familyNames {
            print("family:'\(fontfamilyname)'")
            for fontName: String in UIFont.fontNames(forFamilyName: fontfamilyname) {
                print("\tfont:'\(fontName)'")
            }
            print("-------------")
        }*/

        

        //IQKeyboardManager.shared.isEnabled = true
        
        // SET THE WINDOW
        window = UIWindow(frame: UIScreen.main.bounds)
        // SET WELCOME VIEW AND NAVIGATION CONTROLLER
        let loginnView = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
        objMainNavigation = UINavigationController(rootViewController: loginnView)
        objMainNavigation?.navigationBar.isHidden = true
//        if objMainNavigation?.responds(to: #selector(self.interactivePopGestureRecognizer)) {
//            objMainNavigation?.interactivePopGestureRecognizer?.isEnabled = false
//        }
        window?.rootViewController = objMainNavigation
        window?.makeKeyAndVisible()

        //SET STATUS BAR
        UIApplication.shared.isStatusBarHidden = true

        return true
    }
    
    
    
    //SET COLOR
    func colorFromRGB(valueRed: CGFloat, valueGreen: CGFloat, valueBlue: CGFloat) -> UIColor {
        return UIColor(red: valueRed / 255.0, green: valueGreen / 255.0, blue: valueBlue / 255.0, alpha: 1.0)
        
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        let aCString = cString.cString(using: String.Encoding.utf8)
        let length = strlen(aCString)// returns a UInt
        if (length != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    
    // MARK: - SET FONT
    func setTheFontSize(_ fontValue: UIFont, valueFontSizeFor6: CGFloat) -> UIFont {
        var fontReturn: UIFont?
        if IS_IPHONE {
            if IS_IPHONE_6P {
                fontReturn = fontValue.withSize(valueFontSizeFor6 + 2)
            }
            else if IS_IPHONE_6 {
                fontReturn = fontValue.withSize(valueFontSizeFor6)
            }
            else {
                fontReturn = fontValue.withSize(valueFontSizeFor6 - 2)
            }
        }
        else {
            if IS_IPAD_PRO_12_9 {
                fontReturn = fontValue.withSize(valueFontSizeFor6 + 10)
            }
            else {
                fontReturn = fontValue.withSize(valueFontSizeFor6 + 8)
            }
        }
        return fontReturn ?? UIFont()
    }

    
    
    // MARK: - SET FONT
    func setTheFontForAllScreen(_ strFontName: String?, valueFontSizeFor6: CGFloat) -> UIFont? {
       let fontReturn: UIFont?
        if IS_IPHONE {
            if IS_IPHONE_6P {
                fontReturn = UIFont(name: strFontName ?? "", size: valueFontSizeFor6 + 2)
            } else if IS_IPHONE_6 {
                fontReturn = UIFont(name: strFontName ?? "", size: valueFontSizeFor6)
            } else {
                fontReturn = UIFont(name: strFontName ?? "", size: valueFontSizeFor6 - 2)
            }
        } else {
            fontReturn = UIFont(name: strFontName ?? "", size: valueFontSizeFor6 + 8)
        }
        return fontReturn
    }
    
    
    //MARK: -CUSTOM LOADING METHODS
    
    func startLoadingview() {
        /*
         DISPLAY CUSTOM LOADING SCREEN WHEN THIS METHOD CALLS.
         */
        
        // CREATE CUSTOM VIEW
        viewShowLoad = UIView()
        let rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        viewShowLoad!.frame = rect
        viewShowLoad!.backgroundColor = UIColor.clear
        // SET THE VIEW INSIDE MAIN VIEW
        let viewUp: UIView = UIView(frame: viewShowLoad!.frame)
        viewUp.backgroundColor = UIColor.black
        viewUp.alpha = 0.5
        viewShowLoad!.addSubview(viewUp)
        // CUSTOM ACTIVITY INDICATOR
        objSpinKit = RTSpinKitView(style: RTSpinKitViewStyle(rawValue: 1)!, color: UIColor.white)
        //[self colorFromRGB:99 :174 :13]];
        
        objSpinKit!.center = CGPoint(x:viewShowLoad!.frame.midX, y:viewShowLoad!.frame.midY)
        objSpinKit!.startAnimating()
        viewShowLoad!.addSubview(objSpinKit!)
        self.window!.addSubview(viewShowLoad!)
    }
    
    func stopLoadingView() {
        /*
         REMOVE THE LOADING SCREEN WHEN THIS METHOD CALLS.
         */
        objSpinKit!.stopAnimating()
        viewShowLoad!.removeFromSuperview()
        
    }
    

    //MARK: -DEFAULT ALERT MESSAGE
    
    func showAlertMessage(strMessage: String) {
        /*
         DEFAULT ALERT MESSAGE FUNCTION
         */
        let alertView: UIAlertView = UIAlertView(title: KEYFORAPPNAME, message: strMessage, delegate: nil, cancelButtonTitle: "Okay")
        alertView.show()
    }
    //MARK: -VALIDATION
    
//    func validateMobileNumber(yourNumber: String) -> Bool {
//        //    NSString *phoneRegex = @"^[+(00)][0-let6,14}$";
//        let phoneRegex: String = "^[0-9]{6,14}$"
//        let phoneTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
//        let phoneValidates: Bool = phoneTest.evaluate(with: yourNumber)
//        return phoneValidates
//    }
//    

    func validateEmailAddress(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
   }

