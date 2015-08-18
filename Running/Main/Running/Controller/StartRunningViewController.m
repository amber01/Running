//
//  StartRunningViewController.m
//  Running
//
//  Created by shlity on 15/8/18.
//  Copyright (c) 2015年 shlity. All rights reserved.
//

#import "StartRunningViewController.h"
#import "RunningInfoView.h"

@interface StartRunningViewController ()

@end

@implementation StartRunningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"跑步记录中";
    self.view.backgroundColor = [UIColor whiteColor];
    
    RunningInfoView *runningInfoView = [[RunningInfoView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 268)];
    [self.view addSubview:runningInfoView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
