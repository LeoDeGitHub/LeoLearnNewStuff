//
//  CLCase4Cell.m
//  LearnNewStuff
//
//  Created by Leo on 16/8/30.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "CLCase4Cell.h"
#import <Masonry.h>

@interface CLCase4Cell ()

@property(strong,nonatomic) UIImageView * avatarImageView;
@property(strong,nonatomic) UILabel * titleLabel;
@property(strong,nonatomic) UILabel * contentLabel;

@end

@implementation CLCase4Cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initWithView];
    };
    return self;
}

-(void)initWithView{
    //Avatar 头像
    _avatarImageView = [[UIImageView alloc]init];
    _avatarImageView.backgroundColor = [UIColor redColor];
    [self  addSubview:_avatarImageView];
    [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(@44);
        make.left.and.top.equalTo(self).with.offset(5);
    }];

    //title 标题
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.backgroundColor = [UIColor redColor];
    [self  addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_avatarImageView.mas_centerY);
        make.left.equalTo(_avatarImageView.mas_right).with.offset(5);
    }];

    //内容
    // 计算UILabel的preferredMaxLayoutWidth值，多行时必须设置这个值，否则系统无法决定Label的宽度
    CGFloat preferredMaxWidth = [UIScreen mainScreen].bounds.size.width - 44 - 5 * 3; // 44 = avatar宽度，5 * 3为padding
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.backgroundColor = [UIColor redColor];
    _contentLabel.numberOfLines = 0;
    _contentLabel.preferredMaxLayoutWidth = preferredMaxWidth;
    [self addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_left);
        make.top.equalTo(_avatarImageView.mas_bottom);
        make.right.equalTo(self).with.offset(-5);
        make.bottom.equalTo(self).with.offset(-5);
    }];
}

-(void)setData:(CLCase4Data *)data{
    _data = data;
    self.avatarImageView.image = [UIImage imageNamed:data.avatar];
    self.titleLabel.text = data.title;
    self.contentLabel.text = data.content;
}

@end
