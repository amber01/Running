//
//  MyViewController.h
//  蜗居生活
//
//  Created by amber on 15/4/22.
//  Copyright (c) 2015年 wojushenghuo. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
{
    UILabel  *titleLabel;
}

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.isBackgroundColor  = YES;
        self.isHiddenNavigation = NO;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
    
    if (self.isBackgroundColor) {
        self.navigationView.backgroundColor = [UIColor colorWithHexString:@"#7bbc3e"];
    }else{
        self.navigationView.backgroundColor = self.navBackgroundColor;
    }
    
    titleLabel.text = self.navTitle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isHiddenNavigation == NO) {
        [self customNavigationView];
    }
    [self customNavigationTitle];
    
    if (self.navigationController.viewControllers.count > 1) {
        [self customBackView];
    }
}

#pragma mark -- UI
- (void)customNavigationView
{
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 63.5, [UIScreen mainScreen].bounds.size.width, 0.5)];
    lineView.backgroundColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:209/255.0 alpha:1];
    self.navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [self.navigationView addSubview:lineView];
    [self.view addSubview:self.navigationView];
}

- (void)customNavigationTitle
{
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 64/2, self.view.frame.size.width, 20)];
    titleLabel.textAlignment =  NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"Thonburi" size:19];
    titleLabel.textColor = [UIColor whiteColor];
    [self.navigationView addSubview:titleLabel];
}

- (void)customBackView
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 64/2-5, 110, 30);
    [button setImage:[UIImage imageNamed:@"navbar_back"] forState:UIControlStateNormal];
    button.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
    [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationView addSubview:button];
}

//MBProgress
- (void)initMBProgress:(NSString *)title
{
    progress = [[MBProgressHUD alloc]initWithWindow:[UIApplication sharedApplication].keyWindow];
    progress.labelText = title;
    [self.view.window addSubview:progress];
    [progress setMode:MBProgressHUDModeIndeterminate];   //圆盘的扇形进度显示
    progress.taskInProgress = YES;
    [progress show:YES];   //显示
}

- (void)setMBProgreeShowTime:(int)time
{
    [progress showAnimated:YES whileExecutingBlock:^{
        //对话框显示时需要执行的操作
        sleep(time); // 睡眠3秒
    } completionBlock:^{
        //操作执行完后取消对话框
        [progress removeFromSuperview];
        progress = nil;
    }
     ];
}

- (void)setMBProgreeHiden:(BOOL)isHiden
{
    [progress hide:isHiden];
}

#pragma mark -- action
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark other
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
}

+ (AppDelegate *)appDelegate
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return appDelegate;
}

@end