//
//  LoadingProgressView.h
//  CarApp
//
//  Created by 张三 on 2018/4/20.
//  Copyright © 2018年 freedomTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingProgressView : UIView{
        CAShapeLayer *backGroundFrameLayer;      //背景图层
        CAShapeLayer *backGroundLayer;      //背景图层
        CAShapeLayer *frontFillLayer;       //用来填充的图层
        UIBezierPath *backGroundFrameBezierPath; //背景贝赛尔曲
        UIBezierPath *backGroundBezierPath; //背景贝赛尔曲线
        UIBezierPath *frontFillBezierPath;  //用来填充的贝赛尔曲线
        UILabel *_contentLabel;              //中间的label
  
}
/*
下载弹窗的构造方法
*/
- (instancetype)initProgressView;

/** show出这个弹窗 */
- (void)show;

/** 移除此弹窗 */
- (void)dismiss;

/*
 设置progre值方法
 @param value 对应数字 0.0～1.0
 */
- (void) setProgressValue: (float) fValue;

@end
