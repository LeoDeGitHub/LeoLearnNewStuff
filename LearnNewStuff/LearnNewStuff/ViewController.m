//
//  ViewController.m
//  LearnNewStuff
//
//  Created by Leo on 16/8/17.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "ViewController.h"
#import "CLAliyunTestViewController.h"
#import "CLCase1ViewController.h"
#import "CLCase2ViewController.h"
#import "CLCase3ViewController.h"
#import "CLCase4ViewController.h"
#import "CLCase5ViewController.h"
#import "CLCase6ViewController.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic) UITableView * tableView;
@property(strong,nonatomic) NSArray * array;

@end

@implementation ViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"大鹏说";
    [self tableView];
}

//比较两个版本号大小
-(void)compareTwoVersion{
    NSString * num1 = @"3.0.5.0";
    NSString * num2 = @"3.0.5.1";
    if ([num1 compare:num2 options:NSNumericSearch] == NSOrderedDescending) {
        NSLog(@"大");
    }else if ([num1 compare:num2 options:NSNumericSearch] == NSOrderedAscending){
        NSLog(@"小");
    }
}

#pragma mark - tableView dataSource/delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd%@",indexPath.row,self.array[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        CLAliyunTestViewController * aliyunTestVC = [[CLAliyunTestViewController alloc]init];
        [self.navigationController pushViewController:aliyunTestVC animated:YES];
    }else if (indexPath.row == 1) {
        CLCase1ViewController * case1VC = [[CLCase1ViewController alloc]init];
        [self.navigationController pushViewController:case1VC animated:YES];
    }else if (indexPath.row == 2) {
        CLCase2ViewController * case2VC = [[CLCase2ViewController alloc]init];
        [self.navigationController pushViewController:case2VC animated:YES];
    }else if (indexPath.row == 3) {
        CLCase3ViewController * case3VC = [[CLCase3ViewController alloc]init];
        [self.navigationController pushViewController:case3VC animated:YES];
    }else if (indexPath.row == 4) {
        CLCase4ViewController * case4VC = [[CLCase4ViewController alloc]init];
        [self.navigationController pushViewController:case4VC animated:YES];
    }else if (indexPath.row == 5) {
        CLCase5ViewController * case5VC = [[CLCase5ViewController alloc]init];
        [self.navigationController pushViewController:case5VC animated:YES];
    }else if (indexPath.row == 6) {
        CLCase6ViewController * case6VC = [[CLCase6ViewController alloc]init];
        [self.navigationController pushViewController:case6VC animated:YES];
    }
}

#pragma mark - lazy load
-(NSArray *)array{
    if (!_array) {
        _array = @[@"大鹏说:aliyun上传图片",@"大鹏说:并排Laebl",@"大鹏说:动态居中",@"大鹏说:百分比宽度",@"大鹏说:变高UITableViewCell",@"大鹏说:下拉放大头部",@"大鹏说:HUD"];
    }
    return _array;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
