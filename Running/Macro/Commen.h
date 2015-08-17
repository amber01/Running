//
//  Commen.h
//  GoddessClock
//
//  Created by wubing on 14-8-16.
//  Copyright (c) 2014年 iMac. All rights reserved.
//

#import "AFNetworkReachabilityManager.h"
#import "HexColor.h"


/*通知中心标示*/
#define kNotificationEditModuleDidSelectRing @"EditModuleDidSelectRing"
#define kNotificationEditModuleDidSelectDate @"EditModuleDidSelectDate"
#define kNotificationEditModuleDidSetMutiDate @"EditModuleDidSetMutiDate"
#define kNotificationEditModuleDidSetPeriod @"EditModuleDidSetPeriod"
#define kNotificationEditModuleDidSwitchNap @"EditModuleDidSwitchNap"
#define kNotificationEditModuleDidResetTitle @"EditModuleDidResetTitle"
#define kNotificationEditModuleDidSetVolume @"EditModuleDidSetVolume"
/** 个推配置 **/
// development
#define GetuiAppId           @"Q4Gn7U3F7G6VjojQb0l1L1"
#define GetuiAppKey          @"IH85qSyZtc8aGjTGNV8aM9"
#define GetuiAppSecret       @"CyEO5POzSyA4mCIt2ulH87"

//客户QQ号
#define KGCustomerWithdrawQQ @"2641171701"
#define KGCustomerQQ @"2635249354"

//视频加载圈尺寸
#define WIDTH_LOADING    50.0f
#define HEIGHT_LOADING   50.0f

#define TIME_NETOUT     30.0f

//UITableView group样式时,section高度 bug修复
#define KGTalbelViewStyleGroupedSectionHeightFix 0.00001f

// 导航中右按钮距离屏幕右边界的距离
#define KGNavigationRightButtonOffSetRightScreenDistance 17

//屏幕尺寸
#define ScreenHeight    [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth     [[UIScreen mainScreen] bounds].size.width
#define MainHeight      (ScreenHeight - StateBarHeight)
#define MainWidth       ScreenWidth
#define StateBarHeight  20
#define TabBarHeight    49
#define NavBarHeight    44
#define StandardY       (StateBarHeight + NavBarHeight)
#define NavStatusHeight StandardY
//系统判定
#define  IOS_VERSION        [[[UIDevice currentDevice]systemVersion]floatValue]

//工程文件
#define BUNDLE_PATH(file,ext) [[NSBundle mainBundle]pathForResource:file ofType:ext]
//fileurl
#define FILEURL(file) (file?[[NSURL alloc] initFileURLWithPath:file]:nil)
//url
#define URL(file)   (file?[[NSURL alloc] initWithString:file]:nil)
//加载图片
#define LOADIMAGE(file) [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingString:file]]

#define ImageNamed(_pointer) [UIImage imageNamed:_pointer]

float gSystemVersion;
float gDeviceSize;//3.5/4.0
//时间量级
#define TIME_SCALE 600

// 永久天数界限
#define KGForeverDayCountDivide 9000

//枚红色
#define MAINCOLOR_RGB 0xf73aa0
//背景灰
#define BACK_GRAY_RGB 0Xf6f6f8
//clock列表表头色值
#define TABLE_HEAD_RGB 0xeeeef0
//闹钟关闭时文字颜色值
#define RGB_CLOCK_CLOSED 0x818181

// 公用的灰色(十六进制)
#define COMMON_GRAY_COLOR_HEX @"#eeeeee"
// 公用的紫色(十六进制)
#define COMMON_RED_COLOR_HEX @"#9d72d2"


// 默认的tableView背景色
#define COMMON_DEFAULT_TABLEVIEW_BGCOLOR_HEX  @"#f0eff5"

//alarm中userinfo 的clockid标示
#define ALARM_CLOCKINFO @"clockInfo"
#define ALARM_CLOCK_ID @"clockID"
#define ALARM_UID      @"uid"
#define ALARM_TYPE     @"type"
#define VIDEO_EXPIRE   @"videoExpire"
//图片资源命名
#define BUTTON_PLAY    @"btn_commen_play"
#define ICON_COMMON_LITTLE_PLAY @"icon_common_little_play" // 播放小图标
#define ICON_COMMON_BIG_PLAY @"icon_common_big_play" // 播放大图标
#define ICON_COMMEN_RELOADING @"icon_reloading" //重新加载
#define NOTE_EXPIRE    @"note_video_expire"                                                                                                          
#define BUTTON_RENEW    @"btn_myRingMade_renew"
#define BUTTON_WRITE   @"btn_setclock_write"
#define AVATAR_COMMON_DEFAULT_PLACEHOLDER   @"avatar_common_default_placeholder" // 用户默认占位头像
#define DEFAULT_VIDEO_COVER  @""
//人气等级图标大小
#define HOT_LEVEL_ICON_SIZE (CGSize){36, 21}
//财富等级图标大小
#define FORTUNE_LEVEL_ICON_SIZE (CGSize){25, 25}


//NSUserDefault存储的一些key
#define NoLongerRemind_PlayWithNO_WIFI @"NoLongerRemind_PlayWithNO_WIFI"//非WIFI环境播放不再提醒
#define NoLongerRemind_SetClockInteractor_Info @"NoLongerRemind_SetClockInteractor_Info"//"设置闹钟"页面"重要信息"不再提醒

#define IS_IOS7 (IOS_VERSION>=7.0)
#define IS_IOS8 (IOS_VERSION>=8.0)

#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

//判断Reachability连通性域名
#define AFNetworkReachabilityDomain @"91kge.com"


#define kUserDefaultSurpriseVideosInfo @"kSurpriseVideosInfoUserDefault"

#ifdef   DEBUG
//#define  NSLog(...) NSLog(__VA_ARGS__);
#define  NSLog_METHOD NSLog(@"%s", __func__);
#else
#define  NSLog(...) ;
#define  NSLog_METHOD ;
#endif

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

#define iOS7Delta (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ) ? 20 : 0 )

/**
 *客服QQ
 */
#define  kCustomServiceQQ   @"(QQ: 3112663781)"

/**
 通知相关
 */

#define  kNotificationToLogin               @"loginNotification"
#define  kNotificationToUserInfoChanged     @"userInfoChangedNotification"
#define  kNotificationToLoginStateChanged   @"loginStateChanged"

//三方key
//SMS SDK
static  NSString *SMSSDK_APPKEY = @"5ed75995164c";
static  NSString *SMSSDK_APPSECRET = @"e2acd1fbdbc339412cf0b8bb1fffe581";

//shareSDK
static  NSString *SHARESDK_APPKEY = @"5b75606c0742";
static  NSString *SHARESDK_APPSECRET = @"a166180cbb04444c564ebb33515c1567";

//新浪微博
static  NSString *SHARESDK_APPKEY_WB = @"2523841303";
static  NSString *SHARESDK_APPSECRET_WB = @"034be8dccb8f50be5112c9c12842cd26";

//微信
static  NSString *SHARESDK_APPKEY_WX = @"wx39487ba95f05475f";
static  NSString *SHARESDK_APPSECRET_WX = @"5c3b70121bb959729d923b73236ca7ec";

//QQ
static  NSString *SHARESDK_APPKEY_QQ = @"1104291507";
static  NSString *SHARESDK_APPSECRET_QQ = @"QcCU68aMW6Nc3uvS";


//环信SDK
static  NSString *EASEMOBSDK_APPKEY = @"inao#virtuallove";
static  NSString *EASEMOBSDK_CLIENT_ID = @"YXA6csTd8KClEeSNnGMLKPej7w";
static  NSString *EASEMOBSDK_CLIENT_SECRET = @"YXA6PithtQSqUUK70Cy7huXOALoX9XI";

//信鸽
static  NSString *XGPUSHSDK_APP_KEY         = @"IRE748FR66LU";
static  uint32_t XGPUSHSDK_APP_ID           =  2200092301;
static  NSString *XGPUSHSDK_CLIENT_SECRET   = @"c8ebb79eebc0325a351bef5cc1ba04d2";


//友盟
static  NSString *MOBCLICK_APP_KEY      =   @"54cb373cfd98c502720007e9";
