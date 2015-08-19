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
#import "AnnotationLocation.h"
#import "CustomAnnotationView.h"

@interface StartRunningViewController ()<MAMapViewDelegate>
{
    MAMapView       *_mapView;
    int             isUpdate;
}

@property (nonatomic, strong) AnnotationLocation *animatedCarAnnotation;
@property (nonatomic, retain) MAPolyline         *routeLine;
@end

@implementation StartRunningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"跑步记录中";
    isUpdate = 0;
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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)drawLineWithLocationArray:(NSMutableArray *)locationArray
{
    int pointCount = (int)[locationArray count];
    CLLocationCoordinate2D *coordinateArray = (CLLocationCoordinate2D *)malloc(pointCount * sizeof(CLLocationCoordinate2D));
    
    for (int i = 0; i < pointCount; ++i) {
        CLLocation *location = [locationArray objectAtIndex:i];
        coordinateArray[i] = [location coordinate];
    }
    
    NSLog(@"point:%f..%f",coordinateArray->latitude,coordinateArray->longitude);
    NSLog(@"counts:%d",pointCount);
    self.routeLine = [MAPolyline polylineWithCoordinates:coordinateArray count:pointCount];
    [_mapView setVisibleMapRect:[self.routeLine boundingMapRect]];
    [_mapView addOverlay:self.routeLine];

    free(coordinateArray);
    coordinateArray = NULL;
}


-(void)addStartRunningPoint:(CLLocationCoordinate2D)coordinate
{
    self.animatedCarAnnotation = [[AnnotationLocation alloc] initWithCoordinate:coordinate];
    self.animatedCarAnnotation.imageName = @"location_current_icon";
    [_mapView addAnnotation:self.animatedCarAnnotation];
}

#pragma mark -- MAMapViewDelegate
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        NSLog(@"latitude: %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
        isUpdate = isUpdate + 1;
        if (isUpdate == 1) {
            [self addStartRunningPoint:CLLocationCoordinate2DMake((userLocation.coordinate.latitude)+0.00012,userLocation.coordinate.longitude)];
        }
        
        CLLocation *location0 = [[CLLocation alloc] initWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
        CLLocation *location1 = [[CLLocation alloc] initWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
        
        NSMutableArray *array = [NSMutableArray arrayWithObjects:location0, location1, nil];
        [self drawLineWithLocationArray:array];
    }
}

- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MAAnnotationView *view = views[0];
    MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
    pre.fillColor = [UIColor colorWithRed:0.9 green:0.1 blue:0.1 alpha:0];
    pre.strokeColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.9 alpha:0];
    pre.image = [UIImage imageNamed:@"location_image"];
    [_mapView updateUserLocationRepresentation:pre];
    
    view.calloutOffset = CGPointMake(0, 0);
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[AnnotationLocation class]])
    {
        static NSString *animatedAnnotationIdentifier = @"AnimatedAnnotationIdentifier";
        
        CustomAnnotationView *annotationView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:animatedAnnotationIdentifier];
        
        if (annotationView == nil)
        {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation
                                                              reuseIdentifier:animatedAnnotationIdentifier];
            //annotationView.canShowCallout   = YES;
            //annotationView.draggable        = YES;
        }
        
        return annotationView;
    }
    
    return nil;
}

- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineView *polylineView = [[MAPolylineView alloc] initWithPolyline:overlay];
        
        polylineView.lineWidth = 10.f;
        polylineView.strokeColor = [UIColor greenColor];
        //polylineView.lineJoinType = kMALineJoinRound;//连接类型
        //polylineView.lineCapType  = kMALineCapRound;//端点类型
        
        return polylineView;
    }
    return nil;
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
