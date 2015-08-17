//
//  MyViewController.h
//  蜗居生活
//
//  Created by amber on 15/4/22.
//  Copyright (c) 2015年 wojushenghuo. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface BaseNavigationController : UINavigationController<UIGestureRecognizerDelegate>

@property (nonatomic,assign)BOOL isBack;  //NO表示不允许使用手势

@end
