//
//  AnimatedAnnotation.m
//  Category_demo2D
//
//  Created by 刘博 on 13-11-8.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "AnnotationLocation.h"

@implementation AnnotationLocation

@synthesize coordinate = _coordinate;
@synthesize imageName = _imageName;

#pragma mark - life cycle

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    if (self = [super init])
    {
        self.coordinate = coordinate;
    }
    return self;
}

@end
