//
//  CKHttpCommunicate.h
//  GoddessClock
//
//  Created by Andy on 14-9-9.
//  Copyright (c) 2014年 iMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
#import "HttpCommunicateDefine.h"


@interface CKHttpCommunicate : NSObject

@property (nonatomic,copy) NSData *cooikeSuffer;

+ (id)sharedInstance;


/*一般http请求*/
+ (void)createRequest:(HTTP_COMMAND_LIST)taskID WithParam:(NSDictionary *)param withMethod:(NSString*)method success:(void(^)(id result))success failure:(void(^)(NSError *erro))failure;

@end

