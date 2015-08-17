//
//  CKHttpCommunicate.m
//  GoddessClock
//
//  Created by Andy on 14-9-9.
//  Copyright (c) 2014年 iMac. All rights reserved.
//

#import "CKHttpCommunicate.h"
#import "NSString+MyCategory.h"
#import <CommonCrypto/CommonDigest.h>
#import "SBJsonWriter.h"

#define TIME_NETOUT     2.0f
#define  kNotificationToLogin               @"loginNotification"

@implementation CKHttpCommunicate
{
    AFHTTPRequestOperationManager  * _HTTPManager;
    NSOperationQueue               * _downloadQueue;
    //    NSMutableArray                 * _uploadQueue;
}
+ (id)sharedInstance
{
    static CKHttpCommunicate * HTTPCommunicate;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        HTTPCommunicate = [[CKHttpCommunicate alloc] init];
    });
    return HTTPCommunicate;
}
- (id)init
{
    if (self = [super init])
    {
        _HTTPManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:URL_BASE]];
        
        _HTTPManager.requestSerializer = [AFJSONRequestSerializer serializer];//这个好像也可以注释掉 Jason
        _HTTPManager.requestSerializer.HTTPShouldHandleCookies = YES;
        _HTTPManager.responseSerializer = [AFHTTPResponseSerializer serializer];//这个好像也可以注释掉 Jason
        
        _downloadQueue = [[NSOperationQueue alloc] init];
        _downloadQueue.maxConcurrentOperationCount = 10;
        //        _uploadQueue = [@[] mutableCopy];
    }
    return self;
}

+ (void)createRequest:(HTTP_COMMAND_LIST)requestID WithParam:(NSDictionary *)param withMethod:(NSString*)method success:(void(^)(id result))success failure:(void(^)(NSError *erro))failure
{
    if (requestID < HTTP_METHOD_RESERVE)
    {
        [[CKHttpCommunicate sharedInstance] createUnloginedRequest:requestID WithParam:param withMethod:method success:success failure:failure];
    }else{
        [CKHttpCommunicate createLoginedRequest:requestID WithParam:param success:success failure:failure];
    }
}

//

- (void)createUnloginedRequest:(HTTP_COMMAND_LIST)taskID WithParam:(NSDictionary *)param withMethod:(NSString*)method success:(void(^)(id result))success failure:(void(^)(NSError *erro))failure
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    
    //这个应该是后台参数中的Method 参数和Http请求参数不是一回事 Jason
    
    NSString * URLString = [NSString stringWithUTF8String:cHttpMethod[taskID]];
    
    NSLog(@"URLStr:%@",URLString);
    
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    //移除不需要进行签名的参数
    NSArray *deleteKey = [NSArray arrayWithObjects:@"portrait1",@"img1",@"img2",@"img3", nil];
    NSMutableDictionary *theParam = [NSMutableDictionary dictionaryWithDictionary:param];
    for (int i=0; i<[deleteKey count]; i++) {
        if ([theParam objectForKey:[deleteKey objectAtIndex:i]]) {
            [theParam removeObjectForKey:[deleteKey objectAtIndex:i]];
        }
    }
    
    //这里不写为nil 因为Md5的时候会用
    NSString *paramsJson = @"";
    if (theParam) {
        paramsJson = [[[SBJsonWriter alloc] init] stringWithObject:theParam];
    }else{
        //确保签名和参数统一
        paramsJson = @"{}";
    }
    
    NSLog(@"the jason is %@",paramsJson);
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:URLString forKey:@"method"];
    //按上面没有参数的处理 肯定执行if 不会执行else  就这样了 不会出错
    if (paramsJson && paramsJson.length > 0) {
        [dic setObject:paramsJson forKey:@"params"];
        
    }else{
        //无参数
        [dic setObject:paramsJson forKey:@"params"];
    }
    
    [dic setObject:[UIUtils md5return:URLString params:paramsJson date:timeSp] forKey:@"sign"];
    [dic setObject:timeSp forKey:@"time"];
    NSLog(@"the pa is %@",dic);
    
    NSMutableURLRequest *request = [_HTTPManager.requestSerializer multipartFormRequestWithMethod:method URLString:URL_BASE parameters:dic constructingBodyWithBlock:^(id formData){
        
        if ([param objectForKey:@"portrait1"]) {
            [formData appendPartWithFileData:[param objectForKey:@"portrait1"] name:@"portrait" fileName:@"image4.png" mimeType:@"image/jpeg"];
        }
        
        if ([param objectForKey:@"img1"]) {
            [formData appendPartWithFileData:[param objectForKey:@"img1"] name:@"image1" fileName:@"image1.png" mimeType:@"image/jpeg"];
        }
        if([param objectForKey:@"img2"]){
            [formData appendPartWithFileData:[param objectForKey:@"img2"] name:@"image2" fileName:@"image2.png" mimeType:@"image/jpeg"];
        }
        if([param objectForKey:@"img3"]){
            [formData appendPartWithFileData:[param objectForKey:@"img3"] name:@"image3" fileName:@"image3.png" mimeType:@"image/jpeg"];
        }
        
    } error:nil];
    
    
    NSData *cookiesData = [[NSUserDefaults standardUserDefaults] objectForKey:@"Cookie"];
    if(cookiesData) {
        
        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesData];
        
        for (NSHTTPCookie *cookie in cookies) {
            if ([cookie.name isEqualToString:@"ECM_ID"]) {
                NSString *cooikeString = [NSString stringWithFormat:@"%@=%@",cookie.name,cookie.value];
                NSLog(@"%@....",cookie.value);
                [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
                [request setValue:cooikeString forHTTPHeaderField:@"Cookie"];
            }
        }
    }
    [request setTimeoutInterval:TIME_NETOUT];
    
    NSString *userAgent = [[[UIWebView alloc] init] stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    NSLog(@"UserAgent = %@", userAgent);
    [request setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    NSLog(@"%@xxxxx",[request allHTTPHeaderFields]);
    AFHTTPRequestOperation *operation = [_HTTPManager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"the data is %@",operation);
        NSDictionary *headerDic = operation.response.allHeaderFields;
        
        //if ([headerDic objectForKey:@"Set-Cookie"]) {
            
            NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
            
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cookies];
            
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"Cookie"];
            
        //}
        id result = [operation.responseString JSONValue];
        if (success != nil)
        {
            //网络加载完成的时候
            success(result);
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            
            //NSLog(@"....result....:%@",result);
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
                                         {
                                             
                                             UIWindow *window = [[UIApplication sharedApplication] keyWindow];
                                             [MBProgressHUD hideHUDForView:window animated:YES];
                                             
                                             UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请求超时，请确定网络是否正常" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                             [alertView show];
                                             
                                             if (operation.response.statusCode == 401) { //没有权限，提示登录
                                                 //权限失效或者没权限，通知登录
                                                 [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationToLogin object:nil];
                                                 [MBProgressHUD showError:@"登录过期" toView:window];
                                             }
                                             else if (operation.response.statusCode == 426)//客户端app版本过低，提示升级
                                             {
                                                 [MBProgressHUD showError:@"版本过低" toView:window];
                                             }
                                             NSLog(@"%@",error.description);
                                             if (failure != nil)
                                             {
                                                 failure(error);
                                             }
                                         }];
    
    
    [_HTTPManager.operationQueue addOperation:operation];
    
}


+ (void)createLoginedRequest:(HTTP_COMMAND_LIST)taskID WithParam:(NSDictionary *)param success:(void(^)(id result))success failure:(void(^)(NSError *erro))failure
{
    
}


-(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}
@end

