//
//  CLCase4Data.h
//  LearnNewStuff
//
//  Created by Leo on 16/8/30.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CLCase4Data : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *avatar;

// 缓存行高
@property (assign, nonatomic) CGFloat cellHeight;

@end
