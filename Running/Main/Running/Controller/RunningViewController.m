//
//  RunningViewController.m
//  Running
//
//  Created by shlity on 15/8/17.
//  Copyright (c) 2015年 shlity. All rights reserved.
//

#import "RunningViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "StartRunningButton.h"
#import "StartRunningViewController.h"
#import "SFCountdownView.h"

@interface RunningViewController ()<MAMapViewDelegate,SFCountdownViewDelegate>
{
    MAMapView       *_mapView;
    SFCountdownView *sfCountdownView;
    UIView          *singleMapView;
}


@end

@implementation RunningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"运动";
    [self createMapView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    _mapView.showsUserLocation = YES; //开启定位
}

#pragma mark -- MapView
- (void)createMapView
{
    [MAMapServices sharedServices].apiKey = API_MAP_KEY;
    _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    _mapView.delegate = self;
    [_mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES]; //地图跟着位置移动
    _mapView.compassOrigin = CGPointMake(_mapView.compassOrigin.x, 22);
    _mapView.scaleOrigin = CGPointMake(_mapView.scaleOrigin.x, 22);
    _mapView.zoomLevel = 17.2;
    [self.view addSubview:_mapView];
    
    StartRunningButton *startRunBtn = [[StartRunningButton alloc]initWithFrame:CGRectMake(ScreenWidth/2-45, ScreenHeight-180, 90, 90)];
    [startRunBtn addTarget:self action:@selector(startRunningAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startRunBtn];
}

#pragma mark -- MAMapViewDelegate
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
}

- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MAAnnotationView *view = views[0];
    
    // 放到该方法中用以保证userlocation的annotationView已经添加到地图上了。
    if ([view.annotation isKindOfClass:[MAUserLocation class]])
    {
        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
        pre.fillColor = [UIColor colorWithRed:0.9 green:0.1 blue:0.1 alpha:0];
        pre.strokeColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.9 alpha:0];
        //pre.lineWidth = 3;
        //pre.lineDashPattern = @[@6, @3];
        pre.image = [UIImage imageNamed:@"location_image"];
        
        [_mapView updateUserLocationRepresentation:pre];
        
        view.calloutOffset = CGPointMake(0, 0);
    }
}

#pragma mark -- action
- (void)startRunningAction
{
    StartRunningViewController *startRunningVC = [[StartRunningViewController alloc]init];
    startRunningVC.hidesBottomBarWhenPushed = YES;
    
    singleMapView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    singleMapView.backgroundColor = [UIColor colorWithHexString:@"#7bbc3e"];
    [self.view.window addSubview:singleMapView];
    singleMapView.transform = CGAffineTransformMakeScale(0.05, 0.05);
    [UIView animateWithDuration:0.5
                     animations:^{
                         singleMapView.transform = CGAffineTransformMakeScale(1.5, 1.5);
                     }completion:^(BOOL finish){
                         [self.navigationController pushViewController:startRunningVC animated:NO];
                         sfCountdownView = [[SFCountdownView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
                         sfCountdownView.delegate = self;
                         sfCountdownView.backgroundAlpha = 1.0;
                         sfCountdownView.countdownColor = [UIColor whiteColor];
                         sfCountdownView.countdownFrom = 3;
                         sfCountdownView.finishText = @"Do it";
                         [sfCountdownView updateAppearance];
                         [singleMapView addSubview:sfCountdownView];
                         
                         [sfCountdownView start];
                     }];
}

#pragma mark -- SFConutdownViewDelegate
- (void) countdownFinished:(SFCountdownView *)view
{
    [sfCountdownView removeFromSuperview];
    [singleMapView removeFromSuperview];
    [self.view setNeedsDisplay];
}

#pragma mark -- other
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    _mapView.showsUserLocation = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
