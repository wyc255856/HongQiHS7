//
//  CarAppConstant.h
//  CarApp
//
//  Created by Yu Chen on 2018/4/21.
//  Copyright © 2018年 freedomTeam. All rights reserved.
//

#ifndef CarAppConstant_h
#define CarAppConstant_h

// 视图
#define kScreenWidth               ([UIScreen mainScreen].bounds.size.width)
/*
 iphoneX 底部虚拟home键高度 非安全区
 */
#define KIphoneXBottomOffset            (34)

/*
 1.若为iphoneX 机型 获取安全区域高度  计算方法为 812 - 34
 2.若为普通机型正常取值
 */
#define kScreenHeight                   ([UIScreen mainScreen].bounds.size.height>=812.0f?[UIScreen mainScreen].bounds.size.height-KIphoneXBottomOffset:[UIScreen mainScreen].bounds.size.height)

#define KScale                     ([UIScreen mainScreen].bounds.size.width/375.0f)
#define WeakSelf(x)                     __weak typeof(self) x = self

// 字体
#define CURRENTSYSTEM              ([[UIDevice currentDevice].systemVersion floatValue])
#define FIX_4_5(s)                (kScreenWidth > 320)? (s):(s - 1)
#define Font(s)                   ((CURRENTSYSTEM >= 9.0) ? [UIFont fontWithName:@"PingFangSC-Light" size:FIX_4_5(s)]: [UIFont systemFontOfSize:FIX_4_5(s)])

//上状态栏高
#define kStatusHeight                   ([[UIApplication sharedApplication] statusBarFrame].size.height)
//上导航栏宽高
#define kNavBarHeight                   ([[UINavigationController alloc]init].navigationBar.frame.size.height)

//导航高度
#define KNavBarHeight                   (kStatusHeight+kNavBarHeight)
// iphone X 适配   根据状态栏高度进行偏移24
#define kSafeAreaTopHeight              (kStatusHeight-20)

#ifndef UIColorHex
#define UIColorHex(_hex_)   [UIColor colorWithHexString:((__bridge NSString *)CFSTR(#_hex_))]
#endif

//判断iponex
#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

//在线车型首页web URL
#define BaseURL   (@"http://www.haoweisys.com/HS7/")

//在线设置页面web URL
#define SettingURL   (@"http://www.e-guides.faw.cn/C217/C217_1/pages/set.html")
#define SettingURLByType(sType)   ([NSString stringWithFormat:@"%@%@/pages/setPhone.html",BaseURL,sType])
#define VisitorSettingURLByType(sType)   ([NSString stringWithFormat:@"%@%@/pages/set.html",BaseURL,sType])

// 是否下载本地资源包状态
typedef NS_ENUM(NSUInteger, nState) {
    STATE_UNLOAD = 0,   //未下载
    STATE_HAVE_LOAD     //已经下载
};

// 在线/离线选择状态
typedef NS_ENUM(NSUInteger, nMode) {
    MODE_OUTLINE = 0,   //离线模式
    MODE_ONLINE         //在线模式
};


//车型
#define typeManualComfortable       (@"HS7_1")//  五座低配
#define typeManualLuxury            (@"HS7_2")//  五座中低配
#define typeManualHonorable         (@"HS7_3")//  七座中低配
#define typeAutomaticComfortable    (@"HS7_4")//  五座中高配
#define typeAutomaticLuxury         (@"HS7_5")//  七座中高配
#define typeAutomaticHonorable      (@"HS7_6")//  五座顶配
#define typeAutomaticUltimate       (@"HS7_7")//  七座顶配

//通过车名称获取车型
#define kFuncGetCarTypeByCarName(sName)\
^(){NSDictionary *dic = @{\
@"HS7_1":@"HS7_1",\
@"HS7_2":@"HS7_2",\
@"HS7_3":@"HS7_3",\
@"HS7_4":@"HS7_4",\
@"HS7_5":@"HS7_5",\
@"HS7_6":@"HS7_6",\
@"HS7_7":@"HS7_7",};\
return dic[sName];\
}()

//
typedef NS_ENUM(NSUInteger, CarType) {
    ManualComfortable = 100001,
    ManualLuxury,
    ManualHonorable,
    AutomaticComfortable,
    AutomaticLuxury,
    AutomaticHonorable,
    AutomaticUltimate
};


#endif /* CarAppConstant_h */
