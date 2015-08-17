//
//  RunningViewController.m
//  Running
//
//  Created by shlity on 15/8/17.
//  Copyright (c) 2015年 shlity. All rights reserved.
//

#import "RunningViewController.h"
#import <MAMapKit/MAMapKit.h>

@interface RunningViewController ()<MAMapViewDelegate>
{
    MAMapView  *_mapView;
}

@end

@implementation RunningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"运动";
    [self createMapView];
}

#pragma mark -- MapView
- (void)createMapView
{
    [MAMapServices sharedServices].apiKey = API_MAP_KEY;
    _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES; //开启定位
    [_mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES]; //地图跟着位置移动
    _mapView.compassOrigin = CGPointMake(_mapView.compassOrigin.x, 22);
    _mapView.scaleOrigin = CGPointMake(_mapView.scaleOrigin.x, 22);
    _mapView.zoomLevel = 17.2;
    
    [self.view addSubview:_mapView];
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
