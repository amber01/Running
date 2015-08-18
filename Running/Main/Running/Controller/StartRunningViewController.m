//
//  StartRunningViewController.m
//  Running
//
//  Created by shlity on 15/8/18.
//  Copyright (c) 2015年 shlity. All rights reserved.
//

#import "StartRunningViewController.h"
#import "RunningInfoView.h"
#import <MAMapKit/MAMapKit.h>

@interface StartRunningViewController ()<MAMapViewDelegate>
{
    MAMapView       *_mapView;
}


@end

@implementation StartRunningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"跑步记录中";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createMapView];
    RunningInfoView *runningInfoView = [[RunningInfoView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 268)];
    [self.view addSubview:runningInfoView];
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
        pre.image = [UIImage imageNamed:@"location_image"];
        [_mapView updateUserLocationRepresentation:pre];
        
        view.calloutOffset = CGPointMake(0, 0);
    }
}


//- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
//{
//    if ([annotation isKindOfClass:[MAPointAnnotation class]])
//    {
//        static NSString *navigationCellIdentifier = @"navigationCellIdentifier";
//        
//        MAAnnotationView *poiAnnotationView = (MAAnnotationView*)[_mapView dequeueReusableAnnotationViewWithIdentifier:navigationCellIdentifier];
//        if (poiAnnotationView == nil)
//        {
//            poiAnnotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
//                                                             reuseIdentifier:navigationCellIdentifier];
//        }
//        
//        poiAnnotationView.canShowCallout = YES;
//        
//            /* 起点. */
//            if ([[annotation title] isEqualToString:@"起点"])
//            {
//                poiAnnotationView.image = [UIImage imageNamed:@"location_current"];
//            }
//            /* 终点. */
//            else if([[annotation title] isEqualToString:@"终点"])
//            {
//                poiAnnotationView.image = [UIImage imageNamed:@"endPoint"];
//            }
//        
//        
//        return poiAnnotationView;
//    }
//    
//    return nil;
//}


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
