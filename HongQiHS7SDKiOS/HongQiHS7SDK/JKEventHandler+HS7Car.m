//
//  JKEventHandler+Car.m
//  CarApp
//
//  Created by 张三 on 2018/3/30.
//  Copyright © 2018年 freedomTeam. All rights reserved.
//

#import "JKEventHandler+HS7Car.h"
#import <UIKit/UIKit.h>
#import "HS7ShareManager.h"
#import "HS7CarAppConstant.h"

@implementation JKEventHandler (Car)

/*
 首页设置按钮响应
 */
- (void)goSetPage:(id)params{
    //    NSLog(@"goSetPage :%@",params);
    
    //  是/否为在线
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if(![userDefaults objectForKey:@"HS7webviewLoadMode"] ){
        [userDefaults setInteger:MODE_ONLINE forKey:@"HS7webviewLoadMode"];
        [userDefaults synchronize];
    }
    NSInteger nWebViewLoadMode = [[userDefaults objectForKey:@"HS7webviewLoadMode"] integerValue];
    NSString *sCarName = [userDefaults objectForKey:@"chooseHS7CarModelName"];
    
    
    //  是/否为有本地下载
    if(![userDefaults objectForKey:@"haveHS7LocalPackaged"] ){
        [userDefaults setInteger:STATE_UNLOAD forKey:@"haveHS7LocalPackaged"];
        [userDefaults synchronize];
    }
    NSInteger nHaveLocal = [[userDefaults objectForKey:@"haveHS7LocalPackaged"] integerValue];
    
    //    1.设置请求路径
    NSString *urlBackStr=[NSString stringWithFormat:@"?model=%@&mode=%lu&haveLocalPackaged=%lu&version=v%@&upLoad=%@",sCarName,nWebViewLoadMode, nHaveLocal,[userDefaults objectForKey:@"HS7localVersion"],[userDefaults objectForKey:@"upHS7Load"]];
    
    
        NSString *sVisitor = [userDefaults objectForKey:@"HS7Visitor"];
        if([@"YES" compare:sVisitor] == NSOrderedSame){
            [[JKEventHandler shareInstance].webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@",VisitorSettingURLByType(sCarName),urlBackStr]]]];
        }else{
            [[JKEventHandler shareInstance].webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@",SettingURLByType(sCarName),urlBackStr]]]];
        }
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@",SettingURLByType(sCarName),urlBackStr]);

//
//    if([[ShareManager shareInstance] isBlankString:sCarName]){
//        [[JKEventHandler shareInstance].webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@",VisitorSettingURLByType(sCarName),urlBackStr]]]];
//
//    }else{
//        NSLog(@"%@",[NSString stringWithFormat:@"%@%@",SettingURLByType(sCarName),urlBackStr]);
//        [[JKEventHandler shareInstance].webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@",SettingURLByType(sCarName),urlBackStr]]]];
//
//    }
    
}

/*
 切换车类型响应
 手动..自动..
 */
- (void)selectModel:(id)params{
    //    NSLog(@"selectModel :%@",params);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger nWebViewLoadMode = [[userDefaults objectForKey:@"HS7webviewLoadMode"] integerValue];
    // 在线模式 可以切换车型浏览
    if(nWebViewLoadMode == MODE_ONLINE){
        //    1.设置请求路径
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@/?upLoad=%@",BaseURL,params,[userDefaults objectForKey:@"upHS7Load"]]]]];
        [userDefaults setObject:params forKey:@"chooseHS7CarModelName"];
        [userDefaults synchronize];
    }
    
}

- (void)cleanCache:(id)params{
    //    NSLog(@"cleanCache");
    
}

/*
 在线离线按钮响应
 */
- (void)modeCheck:(id)params{
    //    NSLog(@"modeCheck :%@",params);
    //[[ShareManager shareInstance].wkWebVC showAlert];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:1 forKey:@"HS7webviewLoadMode"];
    [userDefaults synchronize];
    
}

- (void)downloadZip:(id)params{
    //    NSLog(@"downloadZip");
    [[ShareManager shareInstance].wkWebVC downLoadZip];
    
}

- (void)getModel:(void(^)(id response))callBack{
    //    NSLog(@"getModel");
    NSString *str = @"Model";
    if(callBack){
        callBack(str);
    }
}

- (void)getMode:(void(^)(id response))callBack{
    //    NSLog(@"getMode");
    NSString *str = @"Mode";
    if(callBack){
        callBack(str);
    }
}

/*
 返回上一页
 */
- (void)goBack:(id)params{
    //    NSLog(@"goBack");
    if ([self.webView canGoBack]) {
        [ShareManager shareInstance].wkWebVC.isGoBack = YES;
        [self.webView goBack];
        // [self.webView reload];
        //        NSString *js = @"memoryNav()";
        //        [[JKEventHandler shareInstance].webView evaluateJavaScript:js completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        //            NSLog(@"response: %@ error: %@", response, error);
        //        }];
    }
}

/*
 返回首页
 */
- (void)goHome:(id)params{
    //    NSLog(@"goHome");
    //判断webview是/否加载本地
    //依据：1、选择在线模式 2、本地有下载的资源包
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *strCarName = [userDefaults objectForKey:@"chooseHS7CarModelName"];
    NSInteger nHaveLocal =[[userDefaults objectForKey: @"haveHS7LocalPackaged"] integerValue];
    NSInteger nWebViewLoadMode = [[userDefaults objectForKey:@"HS7webviewLoadMode"] integerValue];
    
    if([userDefaults objectForKey:@"HS7webviewLoadMode"]){
        if(nWebViewLoadMode){
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/?upLoad=%@",[ShareManager shareInstance].wkWebVC.url,[userDefaults objectForKey:@"upHS7Load"]]]]];
        }else{
            NSString *strLocalCarName = [userDefaults objectForKey:@"localHS7CarModelName"];
            NSURL *temDirURL = [[NSURL fileURLWithPath:NSTemporaryDirectory()] URLByAppendingPathComponent:[NSString stringWithFormat:@"%@/index.html",strLocalCarName]];
            [self.webView loadFileURL:temDirURL allowingReadAccessToURL:temDirURL];
        }
    }else{
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/?upLoad=%@",[ShareManager shareInstance].wkWebVC.url,[userDefaults objectForKey:@"upHS7Load"]]]]];
    }
}

/*
 退出应用程序
 */
- (void)exitApp:(id)params{
    [[ShareManager shareInstance].wkWebVC exitH5View];
}

/*
 下载资源包
 */
- (void)upLoad:(id)params{
    //    NSLog(@"upHS7Load");
    [[ShareManager shareInstance].wkWebVC downLoadZip];
}



@end
