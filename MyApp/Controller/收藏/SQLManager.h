//
//  SQLManager.h
//  MyApp
//
//  Created by qianfeng001 on 15/10/14.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DayNewsModel.h"
@interface SQLManager : NSObject

+ (instancetype)shareInstance;

- (void)add:(Detail_DayNewsModel*)infomation;
- (void)delete:(Detail_DayNewsModel*)infomation;
- (Detail_DayNewsModel *)fetchById:(NSString *)anId;
- (NSMutableArray *)fetchAll;
@end
