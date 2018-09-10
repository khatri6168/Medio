//
//  AFNetworkClient.m
//  compass
//
//  Created by Manoj on 16/09/14.
//  Copyright (c) 2014 Manoj. All rights reserved.
//

#import "AFNetworkClient.h"
#import "AFHTTPRequestOperationManager.h"

//static NSString * const AFAppDotNetAPIBaseURLString = @"http://127.0.0.1/GTU/";
static NSString * const AFAppDotNetAPIBaseURLString = @"";

@implementation AFNetworkClient

+ (instancetype)sharedClient {
    static AFNetworkClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFNetworkClient alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        _sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
    });
    
    return _sharedClient;
}

@end
