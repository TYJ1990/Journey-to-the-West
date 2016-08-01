//
//  SleeveHtmlWebController.m
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "SleeveHtmlWebController.h"
#import "ListTableViewController.h"
#import "ShareCustom.h"
static NSInteger pageNum = 0;

@interface SleeveHtmlWebController ()<UIWebViewDelegate>
{
    NSMutableArray* dataSource;
    UIWebView *_webView;
}
@property (nonatomic,strong) NSString *urlStr;
@end

@implementation SleeveHtmlWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWebView];
    [self setNavigationBarItem];
    [self setRecognize];
    
}

#pragma mark ---navigationBar的item 
- (void)setNavigationBarItem {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navImg.png"] forBarMetrics:UIBarMetricsDefault];
   UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"list"] imageWithRenderingMode:1]style:0 target:self action:@selector(ListTable)];
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"分享"] imageWithRenderingMode:1]style:0 target:self action:@selector(share)];
    self.navigationItem.rightBarButtonItems = @[rightItem,rightItem1];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"退出" style:UIBarButtonItemStylePlain target:self action:@selector(turnBack)];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}
- (void)share {
    /*
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"10.jpg"]];
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容" images:imageArray url:[NSURL URLWithString:self.urlStr] title:@"分享标题" type:SSDKContentTypeAuto];
        NSLog(@"%@",[NSURL URLWithString:self.urlStr]);
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil  items:nil shareParams:shareParams onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
            
            switch (state) {
                case SSDKResponseStateSuccess:
                {
                    UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:@"分享成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:0 handler:nil];
                    [alterVC addAction:cancel];
                    [self showDetailViewController:alterVC sender:nil];
                    break;
                }
                case SSDKResponseStateFail:
                {
                    UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:@"分享失败" message:[NSString stringWithFormat:@"%@",error] preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:0 handler:nil];
                    [alterVC addAction:cancel];
                    [self showDetailViewController:alterVC sender:nil];
                    break;
                }
                default:
                    break;
            }
        }];
    }*/

     NSArray* imageArray = @[[UIImage imageNamed:@"10.jpg"]];
    id publishContent = [NSMutableDictionary dictionary];
    NSString *str = @"https://www.baidu.com";
    [publishContent SSDKSetupShareParamsByText:@"分享内容" images:imageArray url:[NSURL URLWithString:str] title:@"分享标题" type:SSDKContentTypeAuto];
    //调用自定义分享
    [ShareCustom shareWithContent:publishContent controller:self];


}
#pragma mark --- 手势 ---
- (void)setRecognize {
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [_webView addGestureRecognizer:swipe];
    UISwipeGestureRecognizer *swipe1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    swipe1.direction = UISwipeGestureRecognizerDirectionLeft;
    [_webView addGestureRecognizer:swipe1];
}

#pragma mark --- 手势方法 ---
-(void)swipeAction:(UISwipeGestureRecognizer *)swipe
{
    if(swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        if (pageNum == 0) {
            [self initAlterViewWithTitle:@"这已是第一页"];
        }else{
            pageNum--;
            [self webRequest];
        }

    }else if(swipe.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        if (pageNum == dataSource.count - 1) {
             [self initAlterViewWithTitle:@"这已是最后一页"];
        }else{
            pageNum++;
            [self webRequest];
        }
    }
}
#pragma mark --- 提示框方法 --- 
- (void)initAlterViewWithTitle:(NSString *)title {
    UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    alterVC.view.backgroundColor = [UIColor lightGrayColor];
    alterVC.view.alpha = 0.7;
    [self presentViewController:alterVC animated:YES completion:nil];
    [self performSelector:@selector(popBack:) withObject:alterVC afterDelay:0.5];
}
- (void)popBack:(UIAlertController *)alterVC {
    [alterVC dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark --- 初始化webView ---
- (void)initWebView {
    dataSource = [[NSMutableArray alloc]init];
     NSString *docFilePath = [NSSearchPathForDirectoriesInDomains(13, 1, 1) firstObject];
    NSString* filePath = [NSString stringWithFormat:@"%@/%@/menu.json",docFilePath,self.sleeveNameID];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    dataSource = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    //创建webView
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    [self webRequest];
    [self.view addSubview:_webView];

}
#pragma mark --- web网络请求 ---
- (void)webRequest {
     NSString *docFilePath = [NSSearchPathForDirectoriesInDomains(13, 1, 1) firstObject];
     NSString* htmlPath=[NSString stringWithFormat:@"%@/%@/%@",docFilePath,self.sleeveNameID,dataSource[pageNum][@"file"]];
    self.urlStr = htmlPath;
    NSURL *url = [NSURL URLWithString:htmlPath];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [_webView loadRequest:request];
    self.navigationItem.title=[NSString stringWithFormat:@"%@ %ld/%lu",dataSource[pageNum][@"title"],pageNum+1,(unsigned long)dataSource.count];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor whiteColor]}] ;
}
- (void)turnBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark --- 右边item跳转方法 ---
- (void)ListTable {
    ListTableViewController *listVC = [[ListTableViewController alloc] init];
    listVC.dataSource = dataSource;
    listVC.sleeveNameID = self.sleeveNameID;
    listVC.pageNum = pageNum;
    [self.navigationController pushViewController:listVC animated:YES];
    listVC.pageNumber = ^(NSInteger n){
        pageNum = n;
        [self webRequest];
    };
    
}
@end
