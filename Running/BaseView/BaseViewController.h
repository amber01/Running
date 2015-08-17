//
//  MyViewController.h
//  蜗居生活
//
//  Created by amber on 15/4/22.
//  Copyright (c) 2015年 wojushenghuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MBProgressHUD.h"

@interface BaseViewController : UIViewController<UIGestureRecognizerDelegate,
UINavigationControllerDelegate>
{
    MBProgressHUD         * progress;
}

@property (nonatomic, assign) BOOL   isBackgroundColor;  //设置为NO的时候，子类就可以自定义导航栏的颜色
@property (nonatomic, assign) BOOL   isHiddenNavigation;  //设置为NO的时候，子类就可以自定义导航栏的颜色
@property (nonatomic,retain)UIColor  *navBackgroundColor;
@property (nonatomic,copy)NSString   *navTitle;
@property (nonatomic,retain)UIView   *navigationView;

- (void)initMBProgress:(NSString *)title;
- (void)setMBProgreeHiden:(BOOL)isHiden;
- (void)setMBProgreeShowTime:(int)time;


@end
