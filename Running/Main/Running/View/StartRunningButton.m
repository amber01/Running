//
//  StartRunningButton.m
//  Running
//
//  Created by shlity on 15/8/18.
//  Copyright (c) 2015年 shlity. All rights reserved.
//

#import "StartRunningButton.h"

@implementation StartRunningButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor  colorWithHexString:@"#7bbc3e"]] forState:UIControlStateNormal];
        [self setTitle:@"开始\n跑步" forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.titleLabel.numberOfLines = 0;
        self.layer.cornerRadius = 45;
        self.clipsToBounds = YES;
        self.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
        self.titleLabel.textColor = [UIColor whiteColor];
        [self setTitleShadowColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    return self;
}

@end
