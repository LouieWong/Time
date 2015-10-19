//
//  FourViewController.m
//  MyApp
//
//  Created by qianfeng001 on 15/10/15.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import "FourViewController.h"

@interface FourViewController ()

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self fetDatawithUrl:[NSString stringWithFormat:kAssortmentDataUrl,2]];
}
- (void)fetWebData
{
    [self fetDatawithUrl:[NSString stringWithFormat:kAssortmentDataUrl,2]];
}
- (void)fetOldWebData
{
    AssortmentArrayOtherModel *model = super.dataArray[super.dataArray.count-1];
    
    NSLog(@"%@",model.id);
    [self fetOldDatawithUrl:[NSString stringWithFormat:kAssortmentOldDataUrl,2,model.id]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
