//
//  SleeveDisCountViewController.m
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "SleeveDisCountViewController.h"
#import "SleDetailHeaderView.h"
#import "SleDetailTableViewCell.h"
#import "OtherSleTableViewCell.h"
#import "CountryDetTableViewCell.h"
#import "SleHeadView.h"
#import "SleeveHtmlWebController.h"
#import "WriterViewController.h"
@interface SleeveDisCountViewController ()<UITableViewDataSource,UITableViewDelegate,SleDetailHeaderViewDelegate,NSURLSessionDownloadDelegate>{
    NSMutableDictionary* dataSource;
    UITableView* table;
    SleDetailHeaderView* sleDetailHeader;
    //定义NSURL对象
    NSURLSession* session;
    //创建下载任务对象
    NSURLSessionDownloadTask* task;
    //创建请求对象 NSURL
    NSMutableURLRequest* downloadrequest;
    //定义一个NSData类型的变量 接受下载下来的数据
    NSData* dataS;
    NSString* downPath;
    NSString* sleeveNameID;
    UIView *headerView;
}
@property (strong, nonatomic) FeHourGlass *hourGlass;
@end

@implementation SleeveDisCountViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTable];
    [self requestNet];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"返回"] imageWithRenderingMode:1] style:UIBarButtonItemStylePlain target:self action:@selector(popBack)];
    self.title = [NSString stringWithFormat:@"%@锦囊",self.name];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
  //  self.navigationItem.
}
- (void)popBack {
    [self.navigationController popViewControllerAnimated:YES];
}
// 网络请求
- (void)requestNet {
    _hourGlass = [[FeHourGlass alloc] initWithView:self.view];
    [self.view addSubview:_hourGlass];
    [_hourGlass showWhileExecutingBlock:^{
        [self myTask];
    } completion:^{
    }];
    NSString *urlStr = [NSString stringWithFormat:LATESTDETAIL,self.sleeveID];
    [RequestManager requestWithURLString:urlStr pardic:nil requesttype:requestGET finish:^(NSData *data) {
        dataSource = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil][@"data"];
        [table reloadData];
        [_hourGlass removeFromSuperview];
    } error:^(NSError *error) {
        
    }];
}
- (void)myTask
{
    // Do something usefull in here instead of sleeping ...
    sleep(12);
}
// tableView
- (void)initTable {
    table=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 20) style:UITableViewStyleGrouped];
    table.delegate=self;
    table.dataSource=self;
    table.backgroundColor = PKCOLOR(230, 230, 230);
    [table registerNib:[UINib nibWithNibName:@"SleDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"SleDetailTableViewCell"];
    [table registerNib:[UINib nibWithNibName:@"OtherSleTableViewCell" bundle:nil] forCellReuseIdentifier:@"OtherSleTableViewCell"];
    [table registerNib:[UINib nibWithNibName:@"CountryDetTableViewCell" bundle:nil] forCellReuseIdentifier:@"CountryDetTableViewCell"];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:table];
    sleDetailHeader = [[SleDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 2 / 5)];
    [table addSubview:sleDetailHeader];
}
// 分区个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}
// 分区对应rows个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1){
        NSArray *arr = dataSource[@"authors"];
        return arr.count;
    }else{
        NSArray *array = dataSource[@"related_guides"];
        return array.count;
    }
}
// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *country = @"CountryDetTableViewCell";
        CountryDetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:country forIndexPath:indexPath];
        cell.countyIntro.text = dataSource[@"info"];
        return cell;
    }else if (indexPath.section == 1){
        static NSString *selDet = @"SleDetailTableViewCell";
        SleDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:selDet forIndexPath:indexPath];
        cell.writeLabel.text = dataSource[@"authors"][indexPath.row][@"username"];
        cell.contentLabel.text = dataSource[@"authors"][indexPath.row][@"intro"];
        [cell.witerImag sd_setImageWithURL:[NSURL URLWithString:dataSource[@"authors"][indexPath.row][@"avatar"]] placeholderImage:kPlacehodeImage completed:nil];
        cell.witerImag.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blog:)];
        [cell.witerImag addGestureRecognizer:tap];
        return cell;
    }else{
        static NSString *other = @"OtherSleTableViewCell";
        OtherSleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:other forIndexPath:indexPath];
        NSArray* dataArray = dataSource[@"related_guides"];
        cell.cityName.text = dataArray[indexPath.row][@"cnname"];
        NSString* aireStr=[NSString stringWithFormat:@"%@/%@",dataArray[indexPath.row][@"category_title"],dataArray[indexPath.row][@"country_name_cn"]];
        cell.cityDress.text = aireStr;
       long long count=[dataArray[indexPath.row][@"cover_updatetime"] longLongValue];
        time_t it;
        it=(time_t)count;
        struct tm *local;
        local=localtime(&it);
        char buf[80];
        strftime(buf, 80, "%Y-%m-%d", local);
        cell.timeNew.text = [NSString stringWithFormat:@"%s更新",buf];
        NSString* imageStr=[NSString stringWithFormat:@"%@/260_390.jpg?cover_updatetime=%@",dataArray[indexPath.row][@"cover"],dataArray[indexPath.row][@"cover_updatetime"]];
        [cell.cityImg sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:kPlacehodeImage completed:nil];
        return cell;
    }
}
- (void)blog:(UITapGestureRecognizer *)tap {
    WriterViewController *writerVC = [[WriterViewController alloc] init];
    [self.navigationController pushViewController:writerVC animated:YES];
}
// cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [AdjustHeight adjustHeightByString:dataSource[@"info"] width:kScreenWidth - 20 font:14] + 45;
        
    }else if (indexPath.section == 1){
        return [AdjustHeight adjustHeightByString:dataSource[@"authors"][indexPath.row][@"intro"] width:kScreenWidth - 20 font:14] + 85;
    }else{
        return 130;
    }
}
// 分区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 2 / 5)];
        headerView.alpha = 0.0;
        NSString* imageStr=[NSString stringWithFormat:@"%@/670_420.jpg?cover_updatetime=%@",dataSource[@"cover"],dataSource[@"cover_updatetime"]];
        [sleDetailHeader.imageHeader sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:kPlacehodeImage completed:nil];
        sleDetailHeader.delegate = self;
        downPath = [NSString stringWithFormat:@"%@?modified=%@",dataSource[@"mobile"][@"file"],dataSource[@"cover_updatetime"]];
        sleeveNameID = dataSource[@"cover_updatetime"];
        NSFileManager* manger=[NSFileManager defaultManager];
        NSString *docFilePath = [NSSearchPathForDirectoriesInDomains(13, 1, 1) firstObject];
        NSString* filePath=[NSString stringWithFormat:@"%@/%@",docFilePath,sleeveNameID];
        BOOL isExist= [manger fileExistsAtPath:filePath];
        if (isExist) {
            [sleDetailHeader.downlondBtn setTitle:@"打开" forState:UIControlStateNormal];
        }else{
            
        }
        return headerView;
    }else if (section == 1){
        SleHeadView *view = [[SleHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenHeight, 30)];
        view.la.text = @"锦囊作者";
        return view;
    }else{
        SleHeadView *view = [[SleHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenHeight, 30)];
        view.la.text = @"相关锦囊";
        return view;

    }

}
// 分区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return kScreenHeight * 2 / 5;
    }else if (section == 1){
        return 30;
    }else{
        return 30;
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}
// cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        SleeveDisCountViewController* sleDisc=[[SleeveDisCountViewController alloc]init];
        sleDisc.sleeveID = dataSource[@"related_guides"][indexPath.row][@"id"];
        sleDisc.name = dataSource[@"related_guides"][indexPath.row][@"cnname"];
        [self.navigationController pushViewController:sleDisc animated:YES];
    }
}
#pragma mark --- 下载方法 ---
-(void)downloandSleeve:(UIButton* )btn {
    if ([btn.titleLabel.text isEqualToString:@"下载"]) {
        sleDetailHeader.progress.hidden=NO;
        [btn setTitle:@"暂停" forState:UIControlStateNormal];
        //<1>//创建NSURLSession的配置信息
        NSURLSessionConfiguration* configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
        //<2>创建session对象 将配置信息与Session对象进行关联
        session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        
        //<3>将路径准化成NSURL
        NSURL* url=[NSURL URLWithString:downPath];
        //NSLog(@"%@",downPath);
        //<4>请求对象
        downloadrequest = [NSMutableURLRequest requestWithURL:url];
        downloadrequest.timeoutInterval = 10.0;
        //<5>进行数据请求
        task= [session downloadTaskWithRequest:downloadrequest];
        //开始请求
        [task resume];
    }else if([btn.titleLabel.text isEqualToString:@"暂停"]){
        [btn setTitle:@"继续" forState:UIControlStateNormal];
        //<>暂停
        [task cancelByProducingResumeData:^(NSData *resumeData) {
            //resumData中存放的就是下载下来的数据
            dataS = resumeData;
        }];
    }else if([btn.titleLabel.text isEqualToString:@"继续"]){
        [btn setTitle:@"暂停" forState:UIControlStateNormal];
        //继续下载
        task = [session downloadTaskWithResumeData:dataS];
        [task resume];
    }else{
        //打开锦囊
        SleeveHtmlWebController* sleeveHtml=[[SleeveHtmlWebController alloc]init];
        sleeveHtml.sleeveNameID = sleeveNameID;
        UINavigationController* nav=[[UINavigationController alloc]initWithRootViewController:sleeveHtml];
        [self presentViewController:nav animated:YES completion:nil];
    }

}
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    //<1>获取存放信息的路径
    NSString *docFilePath = [NSSearchPathForDirectoriesInDomains(13, 1, 1) firstObject];
    NSString* destinationPath=[NSString stringWithFormat:@"%@/%@",docFilePath,sleeveNameID];
    
    BOOL isDir = YES;
    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath isDirectory:&isDir])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:destinationPath withIntermediateDirectories:YES attributes:nil error: nil];
    }
    
//    NSURL* url=[NSURL fileURLWithPath:sleevepath];
//    //<2>通过文件管理对象将下载下来的文件路径移到URL路径下
//    NSFileManager* manager=[NSFileManager defaultManager];
//    [manager moveItemAtURL:location toURL:url error:nil];
      [SSZipArchive unzipFileAtPath:location.path toDestination:destinationPath];
   // [manager removeItemAtURL:url error:nil];
      [sleDetailHeader.downlondBtn setTitle:@"打开" forState:UIControlStateNormal];
      sleDetailHeader.progress.hidden=YES;
}
//获取下载进度
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    CGFloat progress = (CGFloat)totalBytesWritten/totalBytesExpectedToWrite;
    sleDetailHeader.progress.progress = progress;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static float offsetY = 0;
    
    offsetY = scrollView.contentOffset.y;
     if (offsetY < 0) {
        sleDetailHeader.frame = CGRectMake(offsetY / 2, offsetY, kScreenWidth - offsetY, kScreenHeight * 2 /5 - offsetY);  // 修改头部的frame值就行了
     }

}

@end
