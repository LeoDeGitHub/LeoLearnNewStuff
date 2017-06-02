//
//  CLCase1ViewController.m
//  LearnNewStuff
//
//  Created by Leo on 16/8/18.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "CLCase1ViewController.h"
#import "Masonry.h"

@interface CLCase1ViewController ()

@property(strong,nonatomic) UILabel * label1;
@property(strong,nonatomic) UILabel * label2;
@property(strong,nonatomic) UILabel * label3;
@property(strong,nonatomic) UIView * contentView;

@property(strong,nonatomic) UIStepper * stepper1;
@property(strong,nonatomic) UIStepper * stepper2;
@property(strong,nonatomic) UIStepper * stepper3;


@end

@implementation CLCase1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initViews];
}

- (void)initViews{
    _contentView = [[UIView alloc]init];
    _contentView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(84);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.height.equalTo(@100);
        
//        make.left.equalTo(self.view.mas_left).with.offset(10);
//        make.right.equalTo(self.view.mas_right).with.offset(-10);
//        make.centerX.equalTo(self.view.mas_centerX);
//        make.centerY.equalTo(self.view.mas_centerY);
//        make.height.equalTo(@100);
        
//        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    
    _stepper1 = [[UIStepper alloc]init];
    _stepper1.tag = 1;
    [_stepper1 addTarget:self action:@selector(addLabelContent:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_stepper1];
    
    _stepper2 = [[UIStepper alloc]init];
    _stepper2.tag = 2;
    [_stepper2 addTarget:self action:@selector(addLabelContent:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_stepper2];
    
    _stepper3 = [[UIStepper alloc]init];
    _stepper3.tag = 3;
    [_stepper3 addTarget:self action:@selector(addLabelContent:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_stepper3];
    
    [_stepper1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentView.mas_bottom).with.offset(10);
        make.left.equalTo(_contentView.mas_left);
    }];
    
    [_stepper2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_stepper1.mas_bottom).with.offset(10);
        make.left.equalTo(_contentView.mas_left);
    }];
    
    [_stepper3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_stepper2.mas_bottom).with.offset(10);
        make.left.equalTo(_contentView.mas_left);
    }];
    
    
    _label1 = [[UILabel alloc]init];
    _label1.backgroundColor = [UIColor yellowColor];
    _label1.text = @"大鹏说";
    [_contentView addSubview:_label1];
    
    _label2 = [[UILabel alloc]init];
    _label2.backgroundColor =[UIColor blueColor];
    _label2.text = @"玩物";
    [_contentView addSubview:_label2];
    
    _label3 = [[UILabel alloc]init];
    _label3.backgroundColor = [UIColor orangeColor];
    _label3.text = @"丧志";
    [_contentView addSubview:_label3];
    
    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentView).with.offset(10);
        make.left.equalTo(_contentView).with.offset(10);
    }];
    
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label1.mas_top);
        make.left.equalTo(_label1.mas_right);
    }];
    
    [_label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label2.mas_top);
        make.left.equalTo(_label2.mas_right);
        make.right.lessThanOrEqualTo(_contentView.mas_right).with.offset(-5);
    }];
    //ContentHuggingPriority设置似乎没有器作用
    //ContentCompressionResistancePriority设置有作用，值越高控件越不会被压缩
    
//    //设置label1的content hugging 为1000
//    [_label1 setContentHuggingPriority:UILayoutPriorityRequired
//                               forAxis:UILayoutConstraintAxisHorizontal];
    //设置label1的content compression 为1000
    [_label1 setContentCompressionResistancePriority:UILayoutPriorityRequired
                                             forAxis:UILayoutConstraintAxisHorizontal];
//    //设置右边的label2的content hugging 为250
//    [_label2 setContentHuggingPriority:UILayoutPriorityDefaultLow
//                               forAxis:UILayoutConstraintAxisHorizontal];
    //设置右边的label2的content compression 为250
    [_label2 setContentCompressionResistancePriority:UILayoutPriorityDefaultLow
                                             forAxis:UILayoutConstraintAxisHorizontal];
//    //设置右边的label2的content hugging 为750
//    [_label2 setContentHuggingPriority:UILayoutPriorityRequired
//                               forAxis:UILayoutConstraintAxisHorizontal];
    //设置右边的label3的content compression 为750
    [_label3 setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh
                                             forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)addLabelContent:(UIStepper *)sender {
    
    switch (sender.tag) {
        case 1:
            _label1.text = [self getLabelContentWithCount:(NSUInteger)sender.value];
            break;
            
        case 2:
            _label2.text = [self getLabelContentWithCount:(NSUInteger)sender.value];
            break;
        case 3:
            _label3.text = [self getLabelContentWithCount:(NSUInteger)sender.value];
            break;
            
        default:
            break;
    }
}

- (NSString *)getLabelContentWithCount:(NSUInteger)count {
    NSMutableString *ret = [NSMutableString new];
    
    for (NSUInteger i = 0; i <= count; i++) {
        [ret appendString:@"大鹏说"];
    }
    
    return ret.copy;
}

@end
