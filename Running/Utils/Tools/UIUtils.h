//
//  UIUtils.h
//  SinaWeiBo
//
//  Created by amber on 14-8-19.
//  Copyright (c) 2014年 amber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpCommunicateDefine.h"

@interface UIUtils : NSObject

//获取documents下的文件路径
+ (NSString *)getDocumentsPath:(NSString *)fileName;
// date 格式化为 string
+ (NSString*) stringFromFomate:(NSDate*)date formate:(NSString*)formate;
// string 格式化为 date
+ (NSDate *) dateFromFomate:(NSString *)datestring formate:(NSString*)formate;

//获取当前时间
+ (NSString *)getCurrentDate:(NSString *)dateFormat;

//格式化这样的日期：Mon Sep 08 20:29:11 +0800 2014
+ (NSString *)fomateString:(NSString *)datestring;

//字符串链接等解析方法
+ (NSString *)parseLink:(NSString *)text;

//随机生成字符串
+ (NSString *)randomString:(int)length;

//比较两个时间的大小
+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;

//计算两个时间之差
+ (NSString *)intervalFromLastDate: (NSString *) dateString1  toTheDate:(NSString *) dateString2;

/**
 *  将字符串转为NSDate
 *
 *  @param uiDate 要转的字符串
 *
 *  @return NSDate
 */
+ (NSDate*) convertDateFromString:(NSString*)uiDate;


//MD5  Jason
+(NSString*)md5return:(NSString *)method
               params:(NSString*)params
                 date:(NSString*)date;

//获取本地document目录
+ (NSString *)getDocumentFile:(NSString *)fileName;

//判断输入的是否是数字
+ (BOOL)isPureInt:(NSString*)string;

/**
 *  图片等比缩放
 *
 *  @param scaleImage 想要缩放的图片
 *
 *  @param scale     想要缩放的倍数
 *
 *  @return scale    缩放后的图片
 */
+ (UIImage *)scaleImage:(UIImage *)image proportion:(float)scale;

//将RGB颜色值转为16进制
+ (UIColor *)colorWithHex:(int)hexValue alpha:(CGFloat)alpha;

@end
