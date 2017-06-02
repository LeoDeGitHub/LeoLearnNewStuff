//
//  CLCase4ViewController.m
//  LearnNewStuff
//
//  Created by Leo on 16/8/29.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "CLCase4ViewController.h"
#import "CLCase4Cell.h"

static NSString * const reuseID = @"case4Cell";
@interface CLCase4ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic) UITableView * tableView;
@property(strong,nonatomic) NSArray * data ;

@end

@implementation CLCase4ViewController

-(NSArray *)data{
    if (!_data) {
        _data = [NSArray array];
    }
    return _data;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[CLCase4Cell class] forCellReuseIdentifier:reuseID];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableView];
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self generateData];
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CLCase4Cell * cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    cell.data = self.data[indexPath.row];
    return  cell;
}

#pragma mark - Private methods

// 生成数据
- (void)generateData {
    NSMutableArray *tmpData = [NSMutableArray new];
    for (int i = 0; i < 20; i++) {
        CLCase4Data *data = [[CLCase4Data alloc]init];
        data.avatar = [NSString stringWithFormat:@"bluefaces_%d", (i % 4) + 1];
        data.title = [NSString stringWithFormat:@"大鹏说: %d", i];
        data.content = [self getText:@"stranger.things-" withRepeat:i * 2 + 1];
        [tmpData addObject:data];
    }
    _data = [tmpData copy];
}

// 重复text字符串repeat次
- (NSString *)getText:(NSString *)text withRepeat:(int)repeat {
    NSMutableString *tmpText = [[NSMutableString alloc]init];
    for (int i = 0; i < repeat; i++) {
        [tmpText appendString:text];
    }
    return tmpText;
}

@end
