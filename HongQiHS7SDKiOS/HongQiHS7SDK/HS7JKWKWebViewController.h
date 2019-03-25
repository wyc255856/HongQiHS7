//
//  JKWKWebViewController.h
//  Pods
//
//  Created by Jack on 17/4/1.
//
//

#import <UIKit/UIKit.h>
#import "HS7WelcomeViewController.h"

@interface JKWKWebViewController : UIViewController{
    int nScreen;
}
@property (nonatomic, weak) id bottomViewController;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign, getter=isValue) BOOL isGoBack;

- (void)showLoadFailedAlert;
- (void)downLoadZip;
- (void)goSettingWebView;
- (void)exitH5View;
@end
