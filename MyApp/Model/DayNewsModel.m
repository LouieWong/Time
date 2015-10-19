//
//  AppIndexBigJSON.m
//  FirstApp
//
//  Created by qianfeng001 on 15/10/4.
//  Copyright (c) 2015年 Louie Wong. All rights reserved.
//

#import "DayNewsModel.h"

@implementation DayNewsModel
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;//JSONModel提供给我们的接口，有了它等于给所有属性加了<option>
}

@end
@implementation DetailExtra_DayNewsModel


@end
@implementation Stories_DayNewsModel


@end
@implementation TopStories_DayNewsModel


@end
@implementation Detail_DayNewsModel

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;//JSONModel提供给我们的接口，有了它等于给所有属性加了<option>
}
@end
@implementation CommentsModel

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;//JSONModel提供给我们的接口，有了它等于给所有属性加了<option>
}

@end
@implementation Long_CommentModel



@end
@implementation Short_CommentModel



@end