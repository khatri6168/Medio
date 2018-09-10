//
//  AFNetworkClient.h
//  compass
//
//  Created by Manoj on 16/09/14.
//  Copyright (c) 2014 Manoj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"


@interface AFNetworkClient : AFHTTPRequestOperationManager
+ (instancetype)sharedClient;

@end
