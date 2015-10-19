//
//  SQLManager.m
//  MyApp
//
//  Created by qianfeng001 on 15/10/14.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import "SQLManager.h"
#import "FMDatabase.h"
#define kTableName @"FavoriteTable"
@interface SQLManager()
@property (nonatomic) FMDatabase *dataBase;

@end
@implementation SQLManager

+ (instancetype)shareInstance
{
    static SQLManager *manager =nil;
    static dispatch_once_t once;
    dispatch_once(&once,^{
        manager = [[SQLManager alloc]init];
    });
    return manager;
}

- (void)add:(Detail_DayNewsModel*)infomation
{
    if ([self.dataBase open]) {
        NSString *sql = [NSString stringWithFormat:@"insert into %@ values(?,?,?,?,?,?)", kTableName];
        
//        NSData *data = UIImageJPEGRepresentation(infomation.image, 1.0); // 把image转换成data
        NSString *str = [NSString stringWithFormat:@"%@",infomation.css[0]];
        if ([self.dataBase executeUpdate:sql, infomation.id, infomation.title, infomation.share_url,infomation.body, str,infomation.image]) {
            NSLog(@"增加对象成功");
        }
        
        [self.dataBase close];
    }
}
- (void)delete:(Detail_DayNewsModel*)infomation
{

    [self deleteById:[NSString stringWithFormat:@"%@",infomation.id]];
}
// 以id号来删除
- (void)deleteById:(NSString *)anId {
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where id=?", kTableName];
    
    if ([self.dataBase open]) {
        // 执行sql
        if ([self.dataBase executeUpdate:sql, anId]) {
            NSLog(@"删除一条记录成功");
        }
        [self.dataBase close];
    }
}

- (Detail_DayNewsModel *)fetchById:(NSString *)anId {
    NSString *sql = [NSString stringWithFormat:@"select * from %@ where id=?", kTableName];
    if ([self.dataBase open]) {
        FMResultSet *set = [self.dataBase executeQuery:sql, anId];
        Detail_DayNewsModel *detail_DayNewsModel = nil;
        if ([set next]) {
            detail_DayNewsModel = [[Detail_DayNewsModel alloc] init];
            detail_DayNewsModel.id = @([[set stringForColumn:@"id"]integerValue]); // [set stringForColumnIndex:(int)]
        }
        [self.dataBase close];
        return detail_DayNewsModel;
    }
    return nil;
}


// 查询所有
- (NSMutableArray *)fetchAll {
    NSString *sql = [NSString stringWithFormat:@"select * from %@", kTableName];
    // 查询结果被放在FMResultSet里面，我们通过对FMResultSet对象发送next方法取到一条条记录
    if ([self.dataBase open]) {
        FMResultSet *set = [self.dataBase executeQuery:sql];
        NSMutableArray *Array = [NSMutableArray array]; // 存储学生对象
        while ([set next]) { // 如果返回真，说明我们取到记录
            Detail_DayNewsModel *detail_DayNewsModel = [[Detail_DayNewsModel alloc] init];
            detail_DayNewsModel.id = @([[set stringForColumn:@"id"]integerValue]);
            detail_DayNewsModel.title  = [set stringForColumn:@"title"];
            detail_DayNewsModel.body   = [set stringForColumn:@"body"];
            detail_DayNewsModel.image = [set stringForColumn:@"image"];;
            [Array addObject:detail_DayNewsModel];
        }
        [self.dataBase close];
        return Array;
    }
    
    return nil;
}

- (instancetype)init {
    if (self = [super init]) {
        // 创建数据库和学生表格
        // 1. 指定数据库文件位置
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]; // Documents 相当于 [NSHomeDirectory() stringByAppendingPathComponent:@"Document"]
        NSString *dbPath = [docPath stringByAppendingPathComponent:@"sql.db"]; // 后缀无所谓，可以写成student.sqlite
        
        NSLog(@"%@", dbPath);
        
        // 2. 新建FMDB对象关联数据库文件
        self.dataBase = [[FMDatabase alloc] initWithPath:dbPath];
        
        // 3. 打开数据库文件创建表格
        if ([_dataBase open]) { // 打开数据库文件，如果原来数据库文件存在，则直接打开，如果不存在，则创建数据库文件
            NSLog(@"打开数据库成功");
            
            // 创建表格
            NSString *sql = [NSString stringWithFormat:@"create table if not exists %@(id varchar(128) primary key, title text, share_url text, body text,css text,image text)", kTableName]; // 准备sql语句  blob 二进制
            // 注：数据库中可以直接存储二进制，但是我们不建议这样做 对于大量的图片，二进制流，一般我们采用文件管理方式把它作为文件存在沙盒中(SDWebImage就是这样做的)
            if ([self.dataBase executeUpdate:sql]) { // 执行sql语句
                NSLog(@"创建表格成功");
            }
            
            [self.dataBase close];
        }
    }
    return self;
}


@end
