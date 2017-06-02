//
//  CLCase2ViewController.m
//  LearnNewStuff
//
//  Created by Leo on 16/8/19.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "CLCase2ViewController.h"
#import <Masonry.h>

#define ImageHeight 32
@interface CLCase2ViewController ()

@property(strong,nonatomic) UIView * contentView;
@property(strong,nonatomic) UIView * switchView;
@property(strong,nonatomic) NSMutableArray * imageViews;
@property(strong,nonatomic) NSMutableArray * switchViews;
@property(strong,nonatomic) NSMutableArray * widthConstraints;
@property(strong,nonatomic) NSArray * imageNames;

@end

@implementation CLCase2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _imageViews = [[NSMutableArray alloc]init];
    _switchViews = [[NSMutableArray alloc]init];
    _widthConstraints = [[NSMutableArray alloc]init];
    _imageNames = @[@"bluefaces_1", @"bluefaces_2", @"bluefaces_3", @"bluefaces_4"];
    
    [self initViews];
}

-(void)initViews{
    _contentView = [[UIView alloc]init];
    _contentView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(ImageHeight));
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).with.offset(200);
    }];
    
    for (int i = 0; i < 4; i++) {
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:self.imageNames[i]];
        [_imageViews addObject:imageView];
        [_contentView addSubview:imageView];
    }
    UIImageView __block* lastView ;
    MASConstraint __block* widthConstraint;
    NSInteger count = _imageViews.count;
    NSInteger __block index = 0;
    for (UIImageView * imageView in _imageViews) {
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            widthConstraint = make.width.equalTo(@(ImageHeight));
            make.height.equalTo(@(ImageHeight));
            make.left.equalTo(lastView ? lastView.mas_right : imageView.superview.mas_left);
            make.centerY.equalTo(imageView.superview.mas_centerY);
            if (index == count - 1) {
                make.right.equalTo(imageView.superview.mas_right);
            }
            [_widthConstraints addObject:widthConstraint];
            lastView = imageView;
            index ++;
        }];
    }
    
    _switchView = [[UIView alloc]init];
    _switchView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_switchView];
    [_switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentView.mas_bottom).with.offset(20);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.equalTo(@31);
    }];
    
    for (int i = 0; i < 4; i++) {
        UISwitch * swh = [[UISwitch alloc]init];
        [swh addTarget:self action:@selector(switchEvent:) forControlEvents:UIControlEventValueChanged];
        swh.tag = i;
        swh.on = YES;
        [_switchViews addObject:swh];
        [_switchView addSubview:swh];
    }
    UISwitch __block* lastswh;
    [_switchViews enumerateObjectsUsingBlock:^(UISwitch * swh, NSUInteger idx, BOOL * _Nonnull stop) {
        [swh mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lastswh ? lastswh.mas_right :swh.superview.mas_left);
            make.width.equalTo(@51);
            make.height.equalTo(@31);
            make.centerY.equalTo(swh.superview.mas_centerY);
            if (idx == 3) {
                make.right.equalTo(swh.superview.mas_right);
            }
            lastswh = swh;
        }];
    }];
}

-(void)switchEvent:(UISwitch *)sender{
    NSInteger index = sender.tag;
    MASConstraint * width = _widthConstraints[index];
    if (sender.on) {
        width.equalTo(@(ImageHeight));
    }else{
        width.equalTo(@0);
    }
}



@end
