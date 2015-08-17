//
//  HistoryViewController.h
//  Running
//
//  Created by shlity on 15/8/17.
//  Copyright (c) 2015年 shlity. All rights reserved.
//

#import "MainViewController.h"
#import "UIView+Toast.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createdTabBarView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
}

- (void)createdTabBarView
{
    historyVC  = [[HistoryViewController alloc]init];
    runningVC  = [[RunningViewController alloc]init];
    mineVC     = [[MineViewController alloc]init];
    
    //history
    UITabBarItem *historyItem =[[UITabBarItem alloc]initWithTitle:@"历史" image:nil tag:1];
    historyItem.image = [UIImage imageNamed:@"tabbar_home"];
    historyItem.selectedImage = [UIImage imageNamed:@"tabbar_home"];
    BaseNavigationController *historyNav = [[BaseNavigationController alloc]initWithRootViewController:historyVC];
    self.tabBar.tintColor = [UIColor colorWithHexString:@"#7bbc3e"];  //改变tabBar上的按钮文字颜色
    historyVC.tabBarItem = historyItem;
    
    //running
    UITabBarItem *runningItem =[[UITabBarItem alloc]initWithTitle:@"" image:nil tag:2];
    runningItem.image = [UIImage imageNamed:@""];
    runningItem.selectedImage = [UIImage imageNamed:@""];
    BaseNavigationController *runningNav = [[BaseNavigationController alloc]initWithRootViewController:runningVC];
    runningVC.tabBarItem = runningItem;
    
    //mine
    UITabBarItem *mineItem =[[UITabBarItem alloc]initWithTitle:@"我" image:nil tag:4];
    mineItem.image = [UIImage imageNamed:@"tabbar_mine"];
    mineItem.selectedImage = [UIImage imageNamed:@"tabbar_mine"];
    BaseNavigationController *mineNav = [[BaseNavigationController alloc]initWithRootViewController:mineVC];
    mineVC.tabBarItem = mineItem;
    
    NSArray *array = @[historyNav,runningNav,mineNav];
    [self addCenterButtonWithImage:[UIImage imageNamed:@"tabbar-more"]]; //tabbar-more
    [self setViewControllers:array animated:YES];
    self.selectedViewController = runningNav;
}

-(void)addCenterButtonWithImage:(UIImage *)buttonImage
{
    _centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGPoint origin = [self.view convertPoint:self.tabBar.center toView:self.tabBar];
    CGSize buttonSize = CGSizeMake(self.tabBar.frame.size.width / 5 - 6, self.tabBar.frame.size.height - 4);
    
    _centerButton.frame = CGRectMake(origin.x - buttonSize.height/2, origin.y - buttonSize.height/2, buttonSize.height, buttonSize.height);
    
    [_centerButton setCornerRadius:buttonSize.height/2];
    [_centerButton setBackgroundColor:[UIColor colorWithHexString:@"#7bbc3e"]];
    [_centerButton setImage:buttonImage forState:UIControlStateNormal];
    [_centerButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tabBar addSubview:_centerButton];
}

- (void)buttonPressed
{
    NSLog(@"start running");
}

#pragma mark -- other
- (void)startHideTabbar
{
    self.tabBar.hidden = YES;
}

- (void)startShowTabbar
{
    self.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
