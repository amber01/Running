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

#define weight 62  //体重

@interface StartRunningViewController ()<MAMapViewDelegate>
{
    MAMapView       *_mapView;
    int             isUpdate;
    NSMutableArray  *routeLineArr; //存储轨迹
    NSMutableArray  *distanceArr;  //存储距离的经纬度
    RunningInfoView *runningInfoView;
    
    NSTimer         *timer;
    int             second;
    int             minute;
    int             hour;
    
    int             sumTime;  //总时间
    float           sumDistance;
}

@property (nonatomic, strong) AnnotationLocation *animatedCarAnnotation;
@property (nonatomic, retain) MAPolyline         *routeLine;
@end

@implementation StartRunningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    routeLineArr = [[NSMutableArray alloc]init];
    distanceArr  = [[NSMutableArray alloc]init];
    
    second = 0;
    minute = 0;
    hour   = 0;
    sumDistance = 0;
    sumTime = 0;
    
    self.navTitle = @"跑步记录中";
    isUpdate = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    [self createMapView];
    runningInfoView = [[RunningInfoView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 268)];
    [self.view addSubview:runningInfoView];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(currentTime:) userInfo:nil repeats:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    _mapView.showsUserLocation = YES; //开启定位
}

- (void)currentTime:(NSTimer *)timer
{
    sumTime = sumTime + 1;
    second = second + 1;
    if (second%60 == 0) {
        second = 0;
        minute = minute + 1;
    }
    
    if (minute!= 0) {
        if (minute%60 == 0){
            minute = 0;
            hour = hour + 1;
        }
    }
    runningInfoView.timeLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d",hour,minute,second];
}

#pragma mark -- MapView
- (void)createMapView
{
    _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    _mapView.delegate = self;
    [_mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES]; //地图跟着位置移动
    _mapView.compassOrigin = CGPointMake(_mapView.compassOrigin.x, 22);
    _mapView.scaleOrigin = CGPointMake(_mapView.scaleOrigin.x, 22);
    _mapView.zoomLevel = 17.2;
    [self.view addSubview:_mapView];
}

- (void)drawLineWithLocationArray:(NSMutableArray *)locationArray
{
    int pointCount = (int)[locationArray count];
    CLLocationCoordinate2D *coordinateArray = (CLLocationCoordinate2D *)malloc(pointCount * sizeof(CLLocationCoordinate2D));
    
    for (int i = 0; i < pointCount; ++i) {
        CLLocation *location = [locationArray objectAtIndex:i];
        coordinateArray[i] = [location coordinate];
    }
    
    self.routeLine = [MAPolyline polylineWithCoordinates:coordinateArray count:pointCount];
    //[_mapView setVisibleMapRect:[self.routeLine boundingMapRect]];
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
        //NSLog(@"latitude: %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
        isUpdate = isUpdate + 1;
        if (isUpdate == 1) {
            [self addStartRunningPoint:CLLocationCoordinate2DMake((userLocation.coordinate.latitude)+0.00012,userLocation.coordinate.longitude)];
        }
        //当前这一组
        CLLocation *location0 = [[CLLocation alloc] initWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
        NSString *locationStr = [NSString stringWithFormat:@"%f,%f",userLocation.coordinate.latitude,userLocation.coordinate.longitude];
        MAMapPoint point1     =  MAMapPointForCoordinate(CLLocationCoordinate2DMake(userLocation.coordinate.latitude,userLocation.coordinate.longitude));
        
        [routeLineArr addObject:location0];
        [distanceArr addObject:locationStr];
        
        //取出当前这一组和上一组之间的经纬度数据
        if (routeLineArr.count > 1) {
            NSMutableArray *array = [NSMutableArray arrayWithObjects:location0, routeLineArr[isUpdate - 2], nil];
            //第2组数据,用于计算距离
            NSString *tempStr = distanceArr[isUpdate - 2];
            
            //截取字符串
            NSArray *arr1 = [tempStr componentsSeparatedByString:@","];
            NSString *strSubStringDigNum = [arr1 objectAtIndex:0];
            float latitudeNum = [strSubStringDigNum floatValue];
 
            NSArray *arr2 = [tempStr componentsSeparatedByString:@","];
            NSString *strSubStringDigNum2 = [arr2 objectAtIndex:1];
            float longitudeNum = [strSubStringDigNum2 floatValue];
            
            [self drawLineWithLocationArray:array];
            MAMapPoint point2 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(latitudeNum,longitudeNum));
            CLLocationDistance distance = MAMetersBetweenMapPoints(point1,point2);
            sumDistance = sumDistance + distance; //距离
            
            //2.计算距离
            runningInfoView.distanceLabel.text = [NSString stringWithFormat:@"%d",(int)sumDistance];
            
            //平均速度
            float speed = sumDistance / sumTime;
            runningInfoView.averageSpeedLabel.text = [NSString stringWithFormat:@"%.1f",speed];
            
            //卡路里
            float kCal = (weight * sumDistance * 0.001)*1.036;
            runningInfoView.kcalLabel.text = [NSString stringWithFormat:@".2%f",kCal];
        }
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
    [timer invalidate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
