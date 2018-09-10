//
//  Global.swift
//  AFNetworking_Demo Swift
//
//  Created by StrateCore - iMac1 on 23/06/16.
//  Copyright © 2016 StrateCore. All rights reserved.
//


import Foundation
import Alamofire


//////////// Import Header Files ////////////


//////////// Define the Global Variable ////////////

let appDelegate = (UIApplication.shared.delegate as? AppDelegate)


//////////// Define FONT NAME ////////////

let FONT_MEDIUM = "HelveticaNeue-Medium"
let FONT_LIGHT = "HelveticaNeue-Light"


//////////// Define The API URL ////////////

let KEYFORAPIURL = "http://37.139.10.75:8080/"


//////////// Define The KEY ////////////
let KEYFORGOOGLEMAP   = "AIzaSyB8BXqEJlvrhOXjOGYOfeXMjWp_KU49bDE"
let KEYFORPARSECLIENTKEY    = ""
let KEYFORFACEBOOK          = "1093241724052842"
//////////// Define String ////////////
let KEYFORAPPNAME = "Medio"
let KEYFORDATEFORMAT = "yyyy-MM-dd"

let USER_DETAILS = "user_details"

///////////////////////////// Define IPHONE SIZE ///////////////////////////////
let IS_IPAD             = UIDevice.current.userInterfaceIdiom == .pad
let IS_IPHONE           = UIDevice.current.userInterfaceIdiom == .phone
let IS_RETINA           = UIScreen.main.scale >= 2.0

let SCREEN_WIDTH        = Int(UIScreen.main.bounds.size.width)
let SCREEN_HEIGHT       = Int(UIScreen.main.bounds.size.height)
let SCREEN_MAX_LENGTH   = Int( max(SCREEN_WIDTH, SCREEN_HEIGHT) )
let SCREEN_MIN_LENGTH   = Int( min(SCREEN_WIDTH, SCREEN_HEIGHT) )

//SET IPHONE SCREEN
let IS_IPHONE_4_OR_LESS = IS_IPHONE && SCREEN_MAX_LENGTH  < 568
let IS_IPHONE_5         = IS_IPHONE && SCREEN_MAX_LENGTH == 568
let IS_IPHONE_6         = IS_IPHONE && SCREEN_MAX_LENGTH == 667
let IS_IPHONE_6P        = IS_IPHONE && SCREEN_MAX_LENGTH == 736
let IS_IPHONE_X         = IS_IPHONE && SCREEN_MAX_LENGTH == 812

//SET IPAD SCREEN
let IS_IPAD_PRO_12_9        = IS_IPHONE && SCREEN_MAX_LENGTH == 1366
let IS_IPAD_PRO_9_7         = IS_IPHONE && SCREEN_MAX_LENGTH == 1024
////////////////////////////////////////////////////////////////////////////////
