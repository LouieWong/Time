//
//  SettingViewController.m
//  MyApp
//
//  Created by qianfeng001 on 15/10/15.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

//
//  SettingController.m
//  MyApp
//
//  Created by qianfeng001 on 15/10/15.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import "SettingController.h"
#import "SDImageCache.h"
@interface SettingController ()<UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>
@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSMutableArray *dataArray;
@end

@implementation SettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTableView];
    [super initUI];
    [self initData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)addTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (double)getCacheSize {
    // 在使用SDWebImage下载图片的时候，SD会把图片缓存到本地（作为图片文件存到沙盒里面），SD自带了清除缓存的机制
    // NSLog(@"%@", NSHomeDirectory());
    // 1bit, 即1个b 就是1个1或1个0 代表一个二进制位，bit是计算机存储的最小单位
    // 1个字节（Byte），即1个B, 就是8个bit, 1Byte = 8bit, 一般用Byte表示计算机存储的基本单位
    // 1个千字节(KB), 即1024个Byte, 即 1024个B, 即2^10个字节
    // 1个兆字节(M, MB, Megabytes)，即1024个千字节，即2^10个千字节 1M = 2^10 KB = 2^20 B = 2^20*8 bit
    // 1个吉字节(G, GB, GigaByte), 即1024个兆字节，即2^10个兆字节
    // 1个太字节(T, TB, TeraByte), 即1024个吉字节，即2^10个G字节
    // 1个拍字节(P, PB, PetaByte), 即1024个T字节，即2^10个T字节
    // 1个艾字节(E, EB, ExaByte), 即1024个P字节，即2^10个P字节
    // 1个泽它字节(Z, ZB, ZettaByte), 即1024个E字节，即2^10个E字节
    // 1个尧它字节(Y, YB, YaoitByte), 即1024个Z字节，即2^10个Z字节
    // 注意，换算方式也有以1000为单位的，所以一般的硬盘生产厂商采用1000为进制的换算, 故有其报告的容量比硬盘标示的容量小的情况发生, 没什么大惊小怪的
    
    // 获取缓存
    // SDWebImage自身下载图片有缓存
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    NSUInteger fileSize = [imageCache getSize]; // 以字节为单位
    double cacheM = fileSize/1024.0/1024.0;
    NSLog(@"SD Cache: %lfM", cacheM);
    
    // 本地下载的缓存（我们自己搞的缓存）
    // 假设我们做了缓存，缓存地址为沙盒的Library/Caches/MyCaches 注意，缓存路径随意，这里只是假设
    NSString *myCachePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/MyCaches"];
    // 获取指定文件信息
    NSFileManager *fm = [NSFileManager defaultManager];
    NSDictionary *fileInfo = [fm attributesOfItemAtPath:myCachePath error:nil];
    NSLog(@"本地缓存字节：%llu", fileInfo.fileSize);
    
    // SD图片缓存加上我们自己的缓存
    fileSize += fileInfo.fileSize;
    
    // 以兆为单位返回
    return fileSize/1024.0/1024.0;
}
- (void)initData {
    self.dataArray = [NSMutableArray arrayWithObjects:@[@"清除缓存"], @[@"感谢你使用本应用",@"版本 V1.0.1"], nil];
    
    // self.dataArray = [NSMutableArray arrayWithObjects:@[@"推送设置",@"开启推送通知",@"开启关注通知",@"清除缓存", @"推送设置",@"开启推送通知",@"开启关注通知",@"清除缓存", ], @[@"推荐爱限免",@"官方推荐",@"官方微博",@"版本 V1.8.1",@"感谢使用爱限免应用", @"推荐爱限免",@"官方推荐",@"官方微博",@"版本 V1.8.1",@"感谢使用爱限免应用", @"推荐爱限免",@"官方推荐",@"官方微博",@"版本 V1.8.1",@"感谢使用爱限免应用"], nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    NSArray *array = self.dataArray[indexPath.section];
    cell.textLabel.text = [array objectAtIndex:indexPath.row];
    
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            [self didClickSection0:indexPath.row];
            break;
        case 1:
            [self didClickSection1:indexPath.row];
            break;
        default:
            break;
    }
}
- (void)didClickSection0:(NSInteger)row {
    switch (row) {
        case 0: { // 清除缓存
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:[NSString stringWithFormat:@"确定清除缓存%.2fM", [self getCacheSize]] delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [sheet showInView:self.view];
            break;
        }
            break;
            
        default:
            break;
    }
}

- (void)didClickSection1:(NSInteger)row {}


#pragma mark - <UIActionSheetDelegate>
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) { // 确定清除
        [self removeCacheData];
    } else {
    }
}

- (void)removeCacheData {
    NSLog(@"%@", NSHomeDirectory());
    
    // SD清空缓存（实际上就是把缓存在本地的图片删除掉）
    [[SDImageCache sharedImageCache] clearDisk];
    
    // 本地的清除缓存
    // 。。。
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
