//
//  AppSingleton.h
//  Compass
//
//  Created by Manoj on 18/09/14.
//  Copyright (c) 2014 Manoj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <netinet/in.h>
//#import "AppDelegate.h"

@interface AppSingleton : NSObject

+(instancetype)sharedSingleton;

+ (BOOL)connectedToNetwork;

@end
