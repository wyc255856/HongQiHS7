//
//  LoadingProgressView.m
//  CarApp
//
//  Created by 张三 on 2018/4/20.
//  Copyright © 2018年 freedomTeam. All rights reserved.
//

#import "HS7LoadingProgressView.h"
#import "UIColor+HS7Util.h"
#import "UIView+HS7frameAdjust.h"
#import "HS7CarBundleTool.h"
#import "UIView+HS7CARAdd.h"
#import "HS7CarAppConstant.h"



@interface LoadingProgressView ()
/** 弹窗主内容view */
@property (nonatomic,strong) UIView   *contentView;
/** 提示 label */
@property (nonatomic,strong) UILabel  *tipLabel;

/** 进度条 **/
@property (nonatomic,strong) UIProgressView   *progressView;
/** 进度 label */
@property (nonatomic,strong) UILabel  *progressValueLabel;

/** 显示进度 **/
@property (nonatomic,copy)   NSString *progressValue;


@end

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation LoadingProgressView{
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

/*
 下载弹窗的构造方法
 */
- (instancetype)initProgressView{
    if (self = [super init]) {
        //self.delegate = delegate;
        
        // 接收键盘显示隐藏的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
        
        // UI搭建
        [self setUpUI];

        [self setUp];

    }
    return self;
}
#pragma mark - UI搭建
/** UI搭建 */
- (void)setUpUI{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 1;
    }];
    
    //设置背景
    UIImageView *bgImgView =  [[UIImageView alloc] initWithFrame:self.frame];
    //[bgImgView setImage:[UIImage imageNamed:@"bg_style_1"]];
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *bundleURL = [bundle URLForResource:@"HS7CarResource" withExtension:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithURL: bundleURL];
    
    NSString *resName = @"bg_style_1";
    [bgImgView setImage:resourceBundle?[UIImage imageNamed:resName inBundle:resourceBundle compatibleWithTraitCollection:nil]:[UIImage imageNamed:resName]];
    [self addSubview:bgImgView];
    
    //------- 弹窗主内容 -------//
    self.contentView = [[UIView alloc]init];
    self.contentView.frame = CGRectMake((SCREEN_WIDTH - 400) / 2, (SCREEN_HEIGHT - 20) / 2, SCREEN_WIDTH*0.7, 80);
    self.contentView.center = self.center;
    [self addSubview:self.contentView];
      //  self.contentView.backgroundColor = [UIColor colorWithHexString:@"#09497b"];
    //    self.contentView.layer.cornerRadius = 6;
    //    self.contentView.layer.borderWidth = 1;
    //    self.contentView.layer.borderColor = [[UIColor colorWithHexString:@"#1bb2fa"] CGColor];
    
    
    //------- 提示文字 -------//
    self.tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bottom-100*KScale, self.contentView.width, 22)];
    [self.contentView addSubview:self.tipLabel];
    self.tipLabel.font = [UIFont boldSystemFontOfSize:20];
    self.tipLabel.textAlignment = NSTextAlignmentCenter;
    self.tipLabel.textColor = [UIColor colorWithHexString:@"#dee9f5"];
    self.tipLabel.text = @"正在下载离线文件...";

    
    //------- 下载图标 -------//
    //UIImage * loadIconImg =  [UIImage imageNamed:@"icon_load"];
//    NSString *resLoadName = @"icon_load";
//    UIImage *loadIconImg =  resourceBundle?[UIImage imageNamed:resLoadName inBundle:resourceBundle compatibleWithTraitCollection:nil]:[UIImage imageNamed:resName];
//
//    UIImageView *loadIconView = [[UIImageView alloc] initWithFrame:CGRectMake(20, (self.contentView.frame.size.height - loadIconImg.size.height)/2, loadIconImg.size.width, loadIconImg.size.height)];
//    loadIconView.image = loadIconImg;
//    [self.contentView addSubview:loadIconView];

    
    //------- 进度条 -------//
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(50, self.tipLabel.bottom+30, 50 , 50)];
    //self.progressView.layer.masksToBounds = YES;
   // self.progressView.layer.cornerRadius = 5;
    //更改进度条高度
    self.progressView.backgroundColor = [UIColor clearColor];
    //self.progressView.transform = CGAffineTransformMakeScale(10.0f,10.0f);
    
    self.progressView.trackTintColor= [UIColor clearColor];

    self.progressView.progressTintColor= [UIColor clearColor];
    
    [self.contentView addSubview:self.progressView];
    
    
    
    //------- 进度值 -------//
    self.progressValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.center.x, self.center.y, 100, 22)];
    
    [self addSubview:self.progressValueLabel];
    self.progressValueLabel.font = [UIFont boldSystemFontOfSize:20];
    self.progressValueLabel.textAlignment = NSTextAlignmentCenter;
    self.progressValueLabel.textColor = [UIColor colorWithHexString:@"#dee9f5"];
    self.progressValueLabel.text = @"";
    
//    //这个容器 因为进度条的  进度覆盖了轨道 需求轨道是包含在外的 强行添加一个轨道放在进度条上面
//    UIView *containerProView = [[UIView alloc] initWithFrame:CGRectMake(loadIconView.frame.size.width+40+1, (self.contentView.frame.size.height-self.progressView.frame.size.height)/2, self.progressView.frame.size.width-1 , self.progressView.frame.size.height+1)];
//    
//    containerProView.layer.cornerRadius = 5;
//    containerProView.layer.borderWidth = 1;
//    containerProView.layer.borderColor = [[UIColor colorWithHexString:@"#1bb2fa"] CGColor];
//    
//    containerProView.layer.shadowColor = [[UIColor colorWithHexString:@"#1bb2fa"] CGColor];
//    containerProView.layer.shadowOpacity = 1;
//    containerProView.layer.shadowRadius = 5;
//    containerProView.layer.shadowOffset = CGSizeMake(0, 0);
//    [self.contentView addSubview:containerProView];
    
    
}

#pragma mark - 弹出此弹窗
/** 弹出此弹窗 */
- (void)show{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
}

#pragma mark - 移除此弹窗
/** 移除此弹窗 */
- (void)dismiss{
    [self removeFromSuperview];
}

/*
 设置progre值方法
 @param value 对应数字 0.0～1.0
 */
- (void) setProgressValue: (float) fValue{
    
    NSString *strTempValue=[NSString stringWithFormat:@"%0.2f", fValue];
    self.progressView.progress= [strTempValue floatValue];
    
    NSLog(@"--1--%f",fValue);
    NSLog(@"--2--%@",strTempValue);
    
    float f2Value = [strTempValue floatValue];
    if(f2Value > 0.5){
        frontFillBezierPath = [UIBezierPath bezierPath];
        [frontFillBezierPath addArcWithCenter:self.center radius:100.0 startAngle:2*M_PI-(M_PI*f2Value - M_PI*0.5) endAngle:M_PI*0.5+M_PI*f2Value clockwise:YES];
        [frontFillBezierPath fill];
        frontFillLayer.path = frontFillBezierPath.CGPath;
    }else{
        frontFillBezierPath = [UIBezierPath bezierPath];
        [frontFillBezierPath addArcWithCenter:self.center radius:100.0 startAngle:M_PI*0.5 -M_PI*f2Value  endAngle:M_PI*0.5+M_PI*f2Value clockwise:YES];
        [frontFillBezierPath fill];
        frontFillLayer.path = frontFillBezierPath.CGPath;
    }

    
    
    NSString *tempString = @"%";
    _contentLabel.text = [[NSString stringWithFormat:@"%d",(int)(fValue*100)] stringByAppendingString:tempString];
    
}

//初始化创建图层
- (void)setUp
{
    backGroundFrameLayer = [CAShapeLayer layer];
    backGroundFrameLayer.fillColor = nil;

    //创建背景图层
    backGroundLayer = [CAShapeLayer layer];
    backGroundLayer.fillColor = nil;
    
    //创建填充图层
    frontFillLayer = [CAShapeLayer layer];
    frontFillLayer.fillColor = nil;
    
    
    [self.layer addSublayer:backGroundFrameLayer];
    [self.layer addSublayer:backGroundLayer];
    [self.layer addSublayer:frontFillLayer];
    
    
    //创建中间label
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.text = @"0%";
    _contentLabel.font = [UIFont systemFontOfSize:30];
    _contentLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_contentLabel];

    //设置颜色
    backGroundFrameLayer.strokeColor = [UIColor colorWithHexString:@"#1a75d5"].CGColor;
    backGroundFrameLayer.lineWidth= 2.0;
    
    backGroundLayer.fillColor = [UIColor colorWithHexString:@"#203b63"].CGColor;
    backGroundLayer.opacity = 0.8;
    
    frontFillLayer.fillColor = [UIColor colorWithHexString:@"#1a75d5"].CGColor;
    
    _contentLabel.textColor = [UIColor whiteColor];
}

#pragma mark -子控件约束
-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    _contentLabel.frame = CGRectMake(self.centerX, self.centerY, 100, 30);
    _contentLabel.center = self.center;
 //   backGroundLayer.frame = self.contentView.bounds;
//    
//    
//    backGroundBezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width/2.0f, width/2.0f) radius:(CGRectGetWidth(self.contentView.bounds)-2.0)/2.f startAngle:0 endAngle:M_PI*2
//                                                       clockwise:YES];
//    backGroundLayer.path = backGroundBezierPath.CGPath;
//    
//    
//    frontFillLayer.frame = self.contentView.bounds;
    
    
    
    //创建path
    backGroundFrameBezierPath = [UIBezierPath bezierPath];
    [backGroundFrameBezierPath addArcWithCenter:self.center radius:103.0 startAngle:0.0 endAngle:M_PI*2 clockwise:YES];
    // 描边和填充
    [backGroundFrameBezierPath stroke];
    backGroundFrameLayer.path = backGroundFrameBezierPath.CGPath;

    
    
    //创建path
    backGroundBezierPath = [UIBezierPath bezierPath];
    // 添加圆到path
    [backGroundBezierPath addArcWithCenter:self.center radius:100.0 startAngle:0.0 endAngle:M_PI*2 clockwise:YES];
    [backGroundBezierPath fill];
    backGroundLayer.path = backGroundBezierPath.CGPath;
    
    
//    frontFillBezierPath = [UIBezierPath bezierPath];
//    [frontFillBezierPath addArcWithCenter:self.center radius:100.0 startAngle:0.0 endAngle:M_PI clockwise:YES];
//    [frontFillBezierPath fill];
//    frontFillLayer.path = frontFillBezierPath.CGPath;

}


@end
