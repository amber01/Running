//
//  RunningInfoView.m
//  Running
//
//  Created by shlity on 15/8/18.
//  Copyright (c) 2015年 shlity. All rights reserved.
//

#import "RunningInfoView.h"

@implementation RunningInfoView
{
    UIImageView *imageView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 268)];
        _bgView.backgroundColor = [UIColor whiteColor];
        
        UIColor *lineColor = [UIColor colorWithHexString:@"#dddddb"];
        UIColor *textColor = [UIColor colorWithHexString:@"#43434b"];
        UIColor *textColor2 = [UIColor colorWithHexString:@"#a4a7ac"];
        
        UIView  *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 117, ScreenWidth, 0.5)];
        lineView1.backgroundColor = lineColor;
        
        UIView  *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 117 + 65, ScreenWidth, 0.5)];
        lineView2.backgroundColor = lineColor;
        
        UIView  *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0, 117 + 65 + 65, ScreenWidth, 0.5)];
        lineView3.backgroundColor = lineColor;
        
        UIView  *lineView4 = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/2 - 0.25, 117, 0.5, 65*2)];
        lineView4.backgroundColor = lineColor;
        
        //当前跑步公里数
        _distanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 27, ScreenWidth, 40)];
        _distanceLabel.textAlignment = NSTextAlignmentCenter;
        _distanceLabel.textColor = textColor;
        _distanceLabel.font = [UIFont fontWithName:@"Helvetica" size:45];
        _distanceLabel.text = @"1232";
        
        UILabel *distanceTipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _distanceLabel.bottom + 5, ScreenWidth, 20)];
        distanceTipsLabel.textAlignment = NSTextAlignmentCenter;
        distanceTipsLabel.textColor = textColor2;
        distanceTipsLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
        distanceTipsLabel.text = @"距离(米)";
        
        //时长
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, lineView1.bottom + 13, ScreenWidth/2, 20)];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.textColor = textColor;
        _timeLabel.font = [UIFont fontWithName:@"Helvetica" size:22];
        _timeLabel.text = @"00:22:12";
        
        UILabel *timeTipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _timeLabel.bottom + 3, ScreenWidth/2, 20)];
        timeTipsLabel.textAlignment = NSTextAlignmentCenter;
        timeTipsLabel.textColor = textColor2;
        timeTipsLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
        timeTipsLabel.text = @"时长";
        
        //平均速度
        _averageSpeedLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2, lineView1.bottom + 13, ScreenWidth/2, 20)];
        _averageSpeedLabel.textAlignment = NSTextAlignmentCenter;
        _averageSpeedLabel.textColor = textColor;
        _averageSpeedLabel.font = [UIFont fontWithName:@"Helvetica" size:22];
        _averageSpeedLabel.text = @"0.5";
        
        UILabel *averageSpeedTipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2, _timeLabel.bottom + 3, ScreenWidth/2, 20)];
        averageSpeedTipsLabel.textAlignment = NSTextAlignmentCenter;
        averageSpeedTipsLabel.textColor = textColor2;
        averageSpeedTipsLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
        averageSpeedTipsLabel.text = @"平均速度(公里/时)";
        
        //配速
        _speedLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, lineView2.bottom + 13, ScreenWidth/2, 20)];
        _speedLabel.textAlignment = NSTextAlignmentCenter;
        _speedLabel.textColor = textColor;
        _speedLabel.font = [UIFont fontWithName:@"Helvetica" size:22];
        _speedLabel.text = @"--";
        
        UILabel *speedTipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _speedLabel.bottom + 3, ScreenWidth/2, 20)];
        speedTipsLabel.textAlignment = NSTextAlignmentCenter;
        speedTipsLabel.textColor = textColor2;
        speedTipsLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
        speedTipsLabel.text = @"配速(分钟/公里)";
        
        //卡路里
        _kcalLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2, lineView2.bottom + 13, ScreenWidth/2, 20)];
        _kcalLabel.textAlignment = NSTextAlignmentCenter;
        _kcalLabel.textColor = textColor;
        _kcalLabel.font = [UIFont fontWithName:@"Helvetica" size:22];
        _kcalLabel.text = @"23.3";
        
        UILabel *kcalTipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2, _speedLabel.bottom + 3, ScreenWidth/2, 20)];
        kcalTipsLabel.textAlignment = NSTextAlignmentCenter;
        kcalTipsLabel.textColor = textColor2;
        kcalTipsLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
        kcalTipsLabel.text = @"卡路里(大卡)";

        //
        _showViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _showViewBtn.frame = CGRectMake(0, lineView4.bottom, ScreenWidth, 22);
        [_showViewBtn addTarget:self action:@selector(showViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [_showViewBtn setBackgroundColor:[UIColor colorWithHexString:@"#f5f5f5"]];
        
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2 - 7.5, 3, 15, 15)];
        imageView.image = [UIImage imageNamed:@"map_up_btn"];
        [_showViewBtn addSubview:imageView];
        
        [_bgView addSubview:_showViewBtn];
        [_bgView addSubview:_speedLabel];
        [_bgView addSubview:speedTipsLabel];
        [_bgView addSubview:_kcalLabel];
        [_bgView addSubview:kcalTipsLabel];
        [_bgView addSubview:_averageSpeedLabel];
        [_bgView addSubview:averageSpeedTipsLabel];
        [_bgView addSubview:timeTipsLabel];
        [_bgView addSubview:_timeLabel];
        [_bgView addSubview:distanceTipsLabel];
        [_bgView addSubview:_distanceLabel];
        [_bgView addSubview:lineView1];
        [_bgView addSubview:lineView2];
        [_bgView addSubview:lineView3];
        [_bgView addSubview:lineView4];
        
        [self addSubview:_bgView];
    }
    return self;
}

- (void)showViewAction:(UIButton *)button
{
    [button setSelected:!button.selected];
    if (button.selected == NO) {
        imageView.image = [UIImage imageNamed:@"map_up_btn"];
        _bgView.hidden = NO;
    }else{
        imageView.image = [UIImage imageNamed:@"map_down_btn"];
        _bgView.hidden = YES;
    }
}

@end
