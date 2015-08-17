//
//  HistoryViewController.h
//  Running
//
//  Created by shlity on 15/8/17.
//  Copyright (c) 2015年 shlity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavigationController.h"
#import "HistoryViewController.h"
#import "RunningViewController.h"
#import "MineViewController.h"

@interface MainViewController : UITabBarController
{
    HistoryViewController     *historyVC;
    RunningViewController     *runningVC;
    MineViewController        *mineVC;
}

@property (nonatomic, strong) UIButton *centerButton;

@end

