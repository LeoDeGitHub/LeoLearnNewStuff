//
//  CLCase6ViewController.m
//  LearnNewStuff
//
//  Created by Leo on 16/8/31.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "CLCase6ViewController.h"
#import <SVProgressHUD.h>
#import <MBProgressHUD.h>

@interface CLCase6ViewController ()

@end

@implementation CLCase6ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"HUD";
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *array = @[@"0",@"1"];
    NSLog(@"%@",array[2]);
    
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
//    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
//    [SVProgressHUD show];
//    [SVProgressHUD showWithStatus:@"hud"];
//    [SVProgressHUD showInfoWithStatus:@"hud"];
//    [SVProgressHUD showSuccessWithStatus:@"hud"];
//    [SVProgressHUD showErrorWithStatus:@"hud"];
    
}


@end
