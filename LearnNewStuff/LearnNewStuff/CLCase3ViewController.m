//
//  CLCase3ViewController.m
//  LearnNewStuff
//
//  Created by Leo on 16/8/29.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "CLCase3ViewController.h"
#import <Masonry.h>

@interface CLCase3ViewController ()

@property(strong,nonatomic) UIView * containerView;
@property(assign,nonatomic) CGFloat maxWidth;

@end

@implementation CLCase3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel * topLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    [self.view addSubview:topLabel];
    topLabel.text = @"子view的宽度始终是父View宽度的一半";
    topLabel.textAlignment = NSTextAlignmentCenter;
    
    _containerView = [[UIView alloc]init];
    _containerView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_containerView];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.top.equalTo(topLabel.mas_bottom);
        make.width.equalTo(@(self.view.bounds.size.width - 20));
        make.height.equalTo(@44);
    }];
    
    UIView * redView = [[UIView alloc]init];
    redView.backgroundColor = [UIColor redColor];
    [_containerView addSubview:redView];
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_containerView.mas_left);
        make.top.equalTo(_containerView.mas_top);
        make.bottom.equalTo(_containerView.mas_bottom);
        make.width.equalTo(_containerView.mas_width).multipliedBy(0.5);
    }];
    
    UISlider * slider = [[UISlider alloc]init];
    [slider setValue:1.0];
    [self.view addSubview:slider];
    [slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_containerView.mas_bottom).with.offset(20);
        make.left.equalTo(self.view.mas_left).with.offset(30);
        make.right.equalTo(self.view.mas_right).with.offset(-30);
        make.height.equalTo(@31);
    }];
    [slider addTarget:self action:@selector(widthChange:) forControlEvents:UIControlEventValueChanged];
    
    _maxWidth = self.view.bounds.size.width - 20;
    
}

-(void)widthChange:(UISlider *)sender{
    NSLog(@"%f--%f",sender.value,_maxWidth);
    [_containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(_maxWidth * sender.value));
    }];
}


@end
