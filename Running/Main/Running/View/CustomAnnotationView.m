//
//  AnimatedAnnotationView.m
//  Category_demo2D
//
//  Created by 刘博 on 13-11-8.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "CustomAnnotationView.h"
#import "AnnotationLocation.h"

#define kWidth          25.f
#define kHeight         30.f

@implementation CustomAnnotationView

@synthesize imageView = _imageView;

#pragma mark - Life Cycle


- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        [self setBounds:CGRectMake(0.f, 0.f, kWidth, kHeight)];
        [self setBackgroundColor:[UIColor clearColor]];
        
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.imageView];
    }
    return self;
}

#pragma mark - Utility

- (void)updateImageView
{
    AnnotationLocation *animatedAnnotation = (AnnotationLocation *)self.annotation;
    self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",animatedAnnotation.imageName]];
}

#pragma mark - Override

- (void)setAnnotation:(id<MAAnnotation>)annotation
{
    [super setAnnotation:annotation];
    [self updateImageView];
}

@end
