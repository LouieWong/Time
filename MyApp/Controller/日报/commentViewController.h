//
//  commentViewController.h
//  MyApp
//
//  Created by qianfeng001 on 15/10/13.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DayNewsModel.h"
@interface commentViewController : UIViewController
@property (nonatomic)NSMutableArray *longCommentsArray;
@property (nonatomic)NSMutableArray *shortCommentsArray;
@property (nonatomic)Long_CommentModel *long_Comments;
@property (nonatomic)Short_CommentModel *short_Comments;
@end
