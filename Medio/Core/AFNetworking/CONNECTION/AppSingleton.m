//
//  AppSingleton.m
//  Compass
//
//  Created by Manoj on 18/09/14.
//  Copyright (c) 2014 Manoj. All rights reserved.
//

#import "AppSingleton.h"
#include <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>
@implementation AppSingleton

+(instancetype)sharedSingleton {
    static AppSingleton *singleton = nil;
    @synchronized(self) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            singleton = [[AppSingleton alloc] init];
        });
    }
    return singleton;
}


#pragma mark - ================= Internet Connection =================
+ (BOOL)connectedToNetwork
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        printf("Error. Could not recover network reachability flags\n");
        return 0;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    BOOL isconnected = (isReachable && !needsConnection) ? YES : NO;
    return isconnected;
}



@end
