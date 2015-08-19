//
//  AnimatedAnnotation.h
//  Category_demo2D
//
//  Created by 刘博 on 13-11-8.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface AnnotationLocation : NSObject<MAAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@property (nonatomic, strong) NSString *imageName;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;

@end
