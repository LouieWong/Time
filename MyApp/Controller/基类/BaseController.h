//
//  MainController.h
//  FirstApp
//
//  Created by qianfeng001 on 15/10/3.
//  Copyright (c) 2015年 Louie Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "helper.h"
#import "Masonry.h"
#import "AFNetworking.h"
#import "URL.h"
#import "UIImage+Blur.h"
#import "SQLManager.h"
#import "CachManager.h"
@interface BaseController : UIViewController



- (void)initUI;
- (void)fetchData;
- (void)fetchWebData;
- (NSString*)getCurrentTime;
//- (BOOL)prefersStatusBarHidden;
@end
