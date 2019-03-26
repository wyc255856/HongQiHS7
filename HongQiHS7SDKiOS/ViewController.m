//
//  ViewController.m
//  HongQiH5SDKiOS
//
//  Created by Yu Chen on 2018/7/11.
//  Copyright © 2018年 freedomTeam. All rights reserved.
//

#import "ViewController.h"
#import "HS7WelcomeViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 44)];
    [button setTitle:@"去看车" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    button.layer.borderWidth = 1.0;
    [self.view addSubview:button];
    
}

- (void)buttonClicked {
    //HS7WelcomeViewController *vc = [[HS7WelcomeViewController alloc] initWithCarName:@"EV_1"];
    HS7WelcomeViewController *vc = [[HS7WelcomeViewController alloc] initWithCarName:@""];
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
