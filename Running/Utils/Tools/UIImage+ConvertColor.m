
//
//  UIImage+ConvertColor.m
//  Running
//
//  Created by shlity on 15/8/18.
//  Copyright (c) 2015年 shlity. All rights reserved.
//

#import "UIImage+ConvertColor.h"

@implementation UIImage (ConvertColor)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
