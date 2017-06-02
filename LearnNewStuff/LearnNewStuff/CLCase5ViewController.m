//
//  CLCase5ViewController.m
//  LearnNewStuff
//
//  Created by Leo on 16/8/31.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "CLCase5ViewController.h"
#import <Masonry.h>

static CGFloat HeaderViewHeight = 235;
@interface CLCase5ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property(strong,nonatomic) UITableView * tableView;
@property(strong,nonatomic) UIImageView * headerView;
@property(strong,nonatomic) MASConstraint * headerViewHeightConstraint;

@end

@implementation CLCase5ViewController

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentInset = UIEdgeInsetsMake(HeaderViewHeight, 0, 0, 0);
        //将headerView inset到TableView下面  必须设置背景色透明才能看到头部图
        _tableView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

-(UIImageView *)headerView{
    if (!_headerView) {
        _headerView = [[UIImageView alloc]init];
        [self.view insertSubview:_headerView belowSubview:_tableView];
//        [self.view insertSubview:_headerView aboveSubview:_tableView];
        _headerView.contentMode = UIViewContentModeScaleAspectFill;
        _headerView.image = [UIImage imageNamed:@"parallax_header_back"];
        [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self.view);
            make.top.equalTo(self.view).with.offset(64);
            _headerViewHeightConstraint = make.height.equalTo(@(HeaderViewHeight));
//            make.height.equalTo(@(HeaderViewHeight));
        }];
        // Add KVO
//        [_tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Parallax Header";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self tableView];
    [self headerView];
    
    
}

#pragma mark - UITableView dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = @(indexPath.row).stringValue;
    return cell;
}

// *************************
// 两种方法监听contentOffset
// *************************

// 方法1：直接在scrollViewDidScroll:刷新
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y < -HeaderViewHeight) {
        _headerViewHeightConstraint.equalTo(@(-scrollView.contentOffset.y));
//        [_headerView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(@(-scrollView.contentOffset.y));
//        }];
    }
}

// 方法2：利用KVO
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
//    if ([keyPath isEqualToString:@"contentOffset"]) {
//        CGPoint contentOffset = ((NSValue *)change[NSKeyValueChangeNewKey]).CGPointValue;
//        if (contentOffset.y < -HeaderViewHeight) {
//            _headerViewHeightConstraint.equalTo(@(-contentOffset.y));
//        }
//    }
//}

//- (void)dealloc {
//    [_tableView removeObserver:self forKeyPath:@"contentOffset"];
//}

@end
