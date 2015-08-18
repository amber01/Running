//
//  RunningInfoView.h
//  Running
//
//  Created by shlity on 15/8/18.
//  Copyright (c) 2015年 shlity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RunningInfoView : UIView

@property (nonatomic,retain)UIView   *bgView;

@property (nonatomic,retain)UILabel  *distanceLabel;  //当前跑步公里数

@property (nonatomic,retain)UILabel  *timeLabel;   //跑步时长
@property (nonatomic,retain)UILabel  *averageSpeedLabel;  //平均速度 公里/小时

@property (nonatomic,retain)UILabel  *speedLabel;       //1分钟多少公里数
@property (nonatomic,retain)UILabel  *kcalLabel;        //卡路里

@property (nonatomic,retain)UIButton *showViewBtn;




@end
