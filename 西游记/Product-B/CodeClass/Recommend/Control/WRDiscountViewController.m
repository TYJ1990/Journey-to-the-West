//
//  WRDiscountViewController.m
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//
#define DISCOUNTSMAL2 @"&track_app_channel=App%2520Store&track_app_version=6.8&track_device_info=iPhone7%2C1&track_deviceid=7B6FA080-F9FB-44C1-B932-401CD69CD5D2&track_os=ios%25209.1&track_user_id=6971539&v=1"
#define DISCOUNTSMAL111 @"http://open.qyer.com/lastminute/app_lastminute_list?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&continent_id=0&count=20&country_id=0&departure=&is_show_pay=1&is_show_supplier=1&lat=40.03616355444207&lon=116.3638803295888&max_id=0&page=%d&page_size=20&product_type=0&times=%@"

///拼接抢折扣
#define DISCOUNTSMAL1 @"http://open.qyer.com/lastminute/app_lastminute_list?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&continent_id=%@&count=20&country_id=%@&departure=%@&is_show_pay=1&is_show_supplier=1&lat=40.03623532599696&lon=116.363827305307&max_id=0&oauth_token=2c8a27f98da55363b7f5ca09940dc14c&page=1&page_size=20&product_type=%@&times=%@%@"

#define DISCOUNTSMAL11 @"http://open.qyer.com/lastminute/app_lastminute_list?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&continent_id=%@&count=20&country_id=%@&departure=%@&is_show_pay=1&is_show_supplier=1&lat=40.03623532599696&lon=116.363827305307&max_id=0&oauth_token=2c8a27f98da55363b7f5ca09940dc14c&page=%d&page_size=20&product_type=%@&times=%@%@"

//抢折扣
#define DISCOUNT @"http://open.qyer.com/lastminute/app_lastminute_list?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&continent_id=0&count=20&country_id=0&departure=&is_show_pay=1&is_show_supplier=1&lat=40.03616355444207&lon=116.3638803295888&max_id=0&page=1&page_size=20&product_type=0&times=&track_app_channel=App%2520Store&track_app_version=6.8&track_device_info=iPhone7%2C1&track_deviceid=7B6FA080-F9FB-44C1-B932-401CD69CD5D2&track_os=ios%25209.1&v=1"
//抢折扣头
#define DISCOUNTHEADER @"http://open.qyer.com/lastminute/get_all_categorys?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&continent_id=0&count=20&country_id=0&departure=&lat=40.03622967559039&lon=116.3638269096286&oauth_token=2c8a27f98da55363b7f5ca09940dc14c&page=1&times=&track_app_channel=App%2520Store&track_app_version=6.8&track_device_info=iPhone7%2C1&track_deviceid=7B6FA080-F9FB-44C1-B932-401CD69CD5D2&track_os=ios%25209.1&track_user_id=6971539&type=0&v=1"
#import "WRDiscountViewController.h"
#import "FSDropDownMenu.h"
#import "DiscountLabelCell.h"
#import "RecommendWebViewController.h"
@interface WRDiscountViewController ()<FSDropDownMenuDataSource,FSDropDownMenuDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIAlertViewDelegate>
{
    NSMutableArray* dataSource;
    UICollectionView* _collection;
    int currentPage;
    NSString* pathStrAll;
}

//全部类型
@property(nonatomic,strong) NSMutableArray* typeArr;
//出发地
@property(nonatomic,strong) NSMutableArray* departArr;
//目的地
@property(nonatomic,strong) NSMutableArray* areaArr;
@property(nonatomic,strong) NSMutableArray* contryArr;
@property(nonatomic,strong) NSMutableArray* currentContryArr;
//时间
@property(nonatomic,strong) NSMutableArray* timeArr;
// 价格
@property(nonatomic,strong) NSMutableArray* priceArr;
@end

@implementation WRDiscountViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    // self.navigationController.navigationBar.translucent = YES;
    _collection.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        currentPage = 1;
        [self reloadTableSource];
    }];
    [_collection.mj_header beginRefreshing];
}
#pragma mark --- viewDidLoad主程序 ---
- (void)viewDidLoad {
    [super viewDidLoad];
    currentPage=1;
    dataSource=[[NSMutableArray alloc]init];
    _contryArr = [[NSMutableArray alloc]init];
    [self initHeadViewAndButton];
    [self creatCollection];
    [self reloadTableSource];
}
#pragma mark --- 透视图+筛选button ---
- (void)initHeadViewAndButton {
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.f];
    UIView* headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    headerView.tag = 111;
    headerView.backgroundColor=[UIColor colorWithWhite:1 alpha:1.f];
    [self.view addSubview:headerView];
    
    NSArray* headArray=@[@"全部类型",@"出发地",@"目的地",@"旅行时间",@"更多筛选"];
    for (int i=0; i<5; i++) {
        UIButton *activityBtn = [[UIButton alloc] initWithFrame:CGRectMake(0+(headerView.frame.size.width/5.7+5)*i, 0, headerView.frame.size.width/5.7, 30)];
        activityBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [activityBtn setTitle:headArray[i] forState:UIControlStateNormal];
        [activityBtn setImage:[UIImage imageNamed:@"expandableImage"] forState:UIControlStateNormal];
         NSDictionary *dict = @{NSFontAttributeName:activityBtn.titleLabel.font};
        if (kScreenWidth == 320) {
            CGSize size = [headArray[i] boundingRectWithSize:CGSizeMake(130, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
            activityBtn.imageEdgeInsets = UIEdgeInsetsMake(11, size.width+14, 11, 0);

        }else if (kScreenWidth == 414){
            if (i == 0 || i == 3 || i == 4) {
            CGSize size = [headArray[i] boundingRectWithSize:CGSizeMake(130, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
            activityBtn.imageEdgeInsets = UIEdgeInsetsMake(11, size.width+16, 11, 0);
        }else{
            CGSize size = [headArray[i] boundingRectWithSize:CGSizeMake(150, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
            activityBtn.imageEdgeInsets = UIEdgeInsetsMake(11, size.width+25, 11, 0);
            }
        }else{
            if (i == 0 || i == 3 || i == 4) {
                CGSize size = [headArray[i] boundingRectWithSize:CGSizeMake(130, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
                activityBtn.imageEdgeInsets = UIEdgeInsetsMake(11, size.width+12, 11, 0);
            }else{
                CGSize size = [headArray[i] boundingRectWithSize:CGSizeMake(150, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
                activityBtn.imageEdgeInsets = UIEdgeInsetsMake(11, size.width+21, 11, 0);
            }

        }
        activityBtn.tag=501+i;
        [activityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [activityBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:activityBtn];
        FSDropDownMenu *menu = [[FSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 30) andHeight:300];
        menu.transformView = activityBtn.imageView;
        menu.tag = 1001+i;
        menu.dataSource = self;
        menu.delegate = self;
        [self.view addSubview:menu];
    }
}
#pragma mark --- button筛选方法 --- 
-(void)btnPressed:(id)sender{
    UIButton* btn=(UIButton* )sender;
    FSDropDownMenu *menu1 = (FSDropDownMenu*)[self.view viewWithTag:1001];
    FSDropDownMenu *menu2 = (FSDropDownMenu*)[self.view viewWithTag:1002];
    FSDropDownMenu *menu3 = (FSDropDownMenu*)[self.view viewWithTag:1003];
    FSDropDownMenu *menu4 = (FSDropDownMenu*)[self.view viewWithTag:1004];
    FSDropDownMenu *menu5 = (FSDropDownMenu*)[self.view viewWithTag:1005];
    
    if (self.typeArr.count==0||self.departArr.count==0||self.areaArr.count==0||self.timeArr.count==0 || self.priceArr.count == 0) {
        [RequestManager requestWithURLString:DISCOUNTHEADER pardic:nil requesttype:requestGET finish:^(NSData *data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            _typeArr = dic[@"data"][@"type"];
            _departArr = dic[@"data"][@"departure"];
            _areaArr = dic[@"data"][@"poi"];
            _timeArr = dic[@"data"][@"times_drange"];
            _priceArr = dic[@"data"][@"filter_tags"];
            for (NSDictionary* dic in _areaArr) {
                [_contryArr addObject:dic[@"country"]];
            }
            _currentContryArr = _contryArr[0];
            [menu5.leftTableView reloadData];
            [menu4.leftTableView reloadData];
            [menu3.leftTableView reloadData];
            [menu3.rightTableView reloadData];
            [menu2.leftTableView reloadData];
            [menu1.leftTableView reloadData];
        } error:^(NSError *error) {
            
        }];

    }
    
        if (btn.tag==501) {
        [UIView animateWithDuration:0.2 animations:^{
            
        } completion:^(BOOL finished) {
            [menu1 menuTapped];
            if (menu2.show==YES) {
                [menu2 menuTapped];
            }
            if (menu3.show==YES) {
                [menu3 menuTapped];
            }
            if (menu4.show==YES) {
                [menu4 menuTapped];
            }
            if (menu5.show==YES) {
                [menu5 menuTapped];
            }
        }];
    }else if(btn.tag==502){
        [UIView animateWithDuration:0.2 animations:^{
            
        } completion:^(BOOL finished) {
            [menu2 menuTapped];
            if (menu1.show==YES) {
                [menu1 menuTapped];
            }
            if (menu3.show==YES) {
                [menu3 menuTapped];
            }
            if (menu4.show==YES) {
                [menu4 menuTapped];
            }
            if (menu5.show==YES) {
                [menu5 menuTapped];
            }
        }];
    }else if (btn.tag==503) {
        [UIView animateWithDuration:0.2 animations:^{
            
        } completion:^(BOOL finished) {
            [menu3 menuTapped];
            if (menu1.show==YES) {
                [menu1 menuTapped];
            }
            if (menu2.show==YES) {
                [menu2 menuTapped];
            }
            if (menu4.show==YES) {
                [menu4 menuTapped];
            }
            if (menu5.show==YES) {
                [menu5 menuTapped];
            }
        }];
    }else if (btn.tag==504){
        [UIView animateWithDuration:0.2 animations:^{
            
        } completion:^(BOOL finished) {
            [menu4 menuTapped];
            if (menu1.show==YES) {
                [menu1 menuTapped];
            }
            if (menu2.show==YES) {
                [menu2 menuTapped];
            }
            if (menu3.show==YES) {
                [menu3 menuTapped];
            }
            if (menu5.show==YES) {
                [menu5 menuTapped];
            }
        }];
    }else if (btn.tag==505){
        [UIView animateWithDuration:0.2 animations:^{
            
        } completion:^(BOOL finished) {
            [menu5 menuTapped];
            if (menu1.show==YES) {
                [menu1 menuTapped];
            }
            if (menu2.show==YES) {
                [menu2 menuTapped];
            }
            if (menu3.show==YES) {
                [menu3 menuTapped];
            }
            if (menu4.show==YES) {
                [menu4 menuTapped];
            }
        }];
    }
    
}
#pragma mark --- FSDropDownMenu协议方法 ---
- (NSInteger)menu:(FSDropDownMenu *)menu tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    if (menu.tag==1001) {
        if (tableView == menu.rightTableView) {
            return 1;
        }else{
            return _typeArr.count;
        }
    }else if (menu.tag==1002){
        if (tableView == menu.rightTableView) {
            return 1;
        }else{
            return _departArr.count;
        }
    }else if (menu.tag==1003) {
        if (tableView == menu.rightTableView) {
            return _areaArr.count;
        }else{
            return _currentContryArr.count;
        }
    }else if (menu.tag==1004) {
        if (tableView == menu.rightTableView) {
            return 1;
        }else{
            return _timeArr.count;
        }
    }else{
        if (tableView == menu.rightTableView) {
            return 1;
        }else{
            return _priceArr.count;
        }
    }
    
}
- (NSString *)menu:(FSDropDownMenu *)menu tableView:(UITableView*)tableView titleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (menu.tag==1001) {
        if (tableView == menu.rightTableView) {
            
            return @"全部类型";
        }else{
            return _typeArr[indexPath.row][@"catename"];
        }
    }else if (menu.tag==1002){
        if (tableView == menu.rightTableView) {
            
            return @"全部出发地";
        }else{
            return _departArr[indexPath.row][@"city_des"];
        }
    }else if (menu.tag==1003) {
        if (tableView == menu.rightTableView) {
            return _areaArr[indexPath.row][@"continent_name"];
        }else{
            return _currentContryArr[indexPath.row][@"country_name"];
        }
    }else if (menu.tag==1004) {
        if (tableView == menu.rightTableView) {
            
            return @"全部时间";
        }else{
            return _timeArr[indexPath.row][@"description"];
        }
    }else {
        if (tableView == menu.rightTableView) {
            
            return @"价格/销量";
        }else{
            return _priceArr[indexPath.row][@"description"];
        }
    }
}
- (void)menu:(FSDropDownMenu *)menu tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"%ld",menu.tag);
    if (menu.tag==1001) {
        if(tableView == menu.rightTableView){
            
        }else{
            [self resetItemSizeWithMenuTag:menu.tag By:_typeArr[indexPath.row][@"catename"]];
        }
    }else if (menu.tag==1002){
        if(tableView == menu.rightTableView){
            
        }else{
            [self resetItemSizeWithMenuTag:menu.tag By:_departArr[indexPath.row][@"city_des"]];
        }
    }else if (menu.tag==1003) {
        if(tableView == menu.rightTableView){
            if (_contryArr.count!=0) {
                _currentContryArr = _contryArr[indexPath.row];
                [menu.leftTableView reloadData];
            }
        }else{
            [self resetItemSizeWithMenuTag:menu.tag By:_currentContryArr[indexPath.row][@"country_name"]];
        }
    }else  if (menu.tag==1004) {
        if(tableView == menu.rightTableView){
            
        }else{
            [self resetItemSizeWithMenuTag:menu.tag By:_timeArr[indexPath.row][@"description"]];
        }
    }else   if (menu.tag==1005) {
        if(tableView == menu.rightTableView){
            
        }else{
            [self resetItemSizeWithMenuTag:menu.tag By:_priceArr[indexPath.row][@"description"]];
        }
    }
}
#pragma mark - reset button size

-(void)resetItemSizeWithMenuTag:(NSInteger )tag By:(NSString*)str{
    //NSLog(@"%ld",tag);
    UIButton* btn;
    if (tag==1001) {
        btn = (UIButton*)[self.view viewWithTag:501];
    }else if (tag==1002){
        btn = (UIButton*)[self.view viewWithTag:502];
    }else if (tag==1003){
        btn = (UIButton*)[self.view viewWithTag:503];
    }else if (tag==1004){
        btn = (UIButton*)[self.view viewWithTag:504];
    }else{
        btn = (UIButton*)[self.view viewWithTag:505];
    }
    if (tag>=1001&&tag<=1005) {
        [btn setTitle:str forState:UIControlStateNormal];
        NSDictionary *dict = @{NSFontAttributeName:btn.titleLabel.font};
        CGSize size = [str boundingRectWithSize:CGSizeMake(150, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
        btn.frame = CGRectMake(btn.frame.origin.x, btn.frame.origin.y,size.width+33, 30);
        btn.imageEdgeInsets = UIEdgeInsetsMake(11, size.width+23, 11, 0);
    }
    if ((tag>=1001&&tag<=1005)||tag==0) {
        UIButton* btn1 = (UIButton*)[self.view viewWithTag:501];
        NSString* str1=btn1.titleLabel.text;
        UIButton* btn2 = (UIButton*)[self.view viewWithTag:502];
        NSString* str2=btn2.titleLabel.text;
        UIButton* btn3 = (UIButton*)[self.view viewWithTag:503];
        NSString* str3=btn3.titleLabel.text;
        UIButton* btn4 = (UIButton*)[self.view viewWithTag:504];
        NSString* str4=btn4.titleLabel.text;
        UIButton* btn5 = (UIButton*)[self.view viewWithTag:505];
        NSString* str5=btn5.titleLabel.text;
        //查找_type组的index值,找到拼接id
        int index=0;
        for (int i=0; i<_typeArr.count; i++) {
            if ([_typeArr[i][@"catename"] isEqualToString:str1]) {
                index=i;
            }
        }
        //NSLog(@"%@",_typeArr);
        NSString* pathStr1=_typeArr[index][@"id"];
        
        //查找_departArr组的index值,找到拼接id
        index=0;
        for (int i=0; i<_departArr.count; i++) {
            if ([_departArr[i][@"city_des"] isEqualToString:str2]) {
                index=i;
            }
        }
        NSString* pathStr2=_departArr[index][@"city"];
        //查找_areaArr数组 和_currentContryArr数组 的index值,找到拼接id
        index=0;
        int indexArea=0;
        int indexContry=0;
        NSMutableString* pathStr3=[[NSMutableString alloc]init];
        NSMutableString* pathStr4=[[NSMutableString alloc]init];
        for (int i=0; i<_areaArr.count; i++) {
            //NSLog(@"%d",i);
            NSMutableArray* tempArr=[[NSMutableArray alloc]init];
            [tempArr addObjectsFromArray:_areaArr[i][@"country"]];
            for (int j=0; j<tempArr.count; j++) {
                //NSLog(@"%d",j);
                if ([tempArr[j][@"country_name"] isEqualToString:str3]) {
                    indexContry=j;
                    indexArea=i;
                }
            }
        }
        [pathStr3 setString:[NSString stringWithFormat:@"%@",_areaArr[indexArea][@"continent_id"]]];
        [pathStr4 setString:[NSString stringWithFormat:@"%@",_currentContryArr[indexContry][@"country_id"]]];
        
        //查找_timeArr组的index值,找到拼接id
        index=0;
        for (int i=0; i<_timeArr.count; i++) {
            if ([_timeArr[i][@"description"] isEqualToString:str4]) {
                index=i;
            }
        }
         NSString* pathStr5=_timeArr[index][@"times"];
        index=0;
        for (int i=0; i<_priceArr.count; i++) {
            if ([_priceArr[i][@"description"] isEqualToString:str5]) {
                index=i;
            }
        }
        pathStrAll=[NSString stringWithFormat:DISCOUNTSMAL1,pathStr3,pathStr4,pathStr2,pathStr1,pathStr5,DISCOUNTSMAL2];
        [RequestManager requestWithURLString:pathStrAll pardic:nil requesttype:requestGET finish:^(NSData *data) {
            [dataSource removeAllObjects];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSMutableArray *arr = dic[@"data"][@"lastminutes"];
            [dataSource addObjectsFromArray:arr];
            if (dataSource.count!=0) {
                   [_collection reloadData];
            [_collection.mj_footer endRefreshing];
            [_collection.mj_header endRefreshing]; 
            }else{
                UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"没有查找到相关条目" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"清空筛选条件" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    UIView *headView = [self.view viewWithTag:111];
                    [headView removeFromSuperview];
                    [self initHeadViewAndButton];
                    [self reloadTableSource];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }];
                [alterVC addAction:action1];
                [alterVC addAction:action2];
                [self presentViewController:alterVC animated:YES completion:nil];
            }
            
        } error:^(NSError *error) {
            
        }];

    }else{
        if (_typeArr.count==0&&_departArr.count==0&&_timeArr.count==0&&_areaArr.count==0&&_contryArr.count==0&&_currentContryArr.count==0&&_priceArr.count==0) {
            
            
            NSString* pageStrAll=[NSString stringWithFormat:DISCOUNTSMAL111,currentPage,DISCOUNTSMAL2];
            
            [RequestManager requestWithURLString:pageStrAll pardic:nil requesttype:requestGET finish:^(NSData *data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                if (currentPage == 1) {
                    [dataSource removeAllObjects];
                }
                NSMutableArray *arr = dic[@"data"][@"lastminutes"];
                [dataSource addObjectsFromArray:arr];
                [_collection reloadData];
                [_collection.mj_footer endRefreshing];
                [_collection.mj_header endRefreshing];
            } error:^(NSError *error) {
                
            }];

            
        }else{
            //NSLog(@"%d",tag);
            UIButton* btn1 = (UIButton*)[self.view viewWithTag:501];
            NSString* str1=btn1.titleLabel.text;
            UIButton* btn2 = (UIButton*)[self.view viewWithTag:502];
            NSString* str2=btn2.titleLabel.text;
            UIButton* btn3 = (UIButton*)[self.view viewWithTag:503];
            NSString* str3=btn3.titleLabel.text;
            UIButton* btn4 = (UIButton*)[self.view viewWithTag:504];
            NSString* str4=btn4.titleLabel.text;
            UIButton* btn5 = (UIButton*)[self.view viewWithTag:505];
            NSString* str5=btn5.titleLabel.text;
            
            //查找_type组的index值,找到拼接id
            int index=0;
            for (int i=0; i<_typeArr.count; i++) {
                if ([_typeArr[i][@"catename"] isEqualToString:str1]) {
                    index=i;
                }
            }
            //NSLog(@"%@",_typeArr);
            NSString* pathStr1=_typeArr[index][@"id"];
            
            //查找_departArr组的index值,找到拼接id
            index=0;
            for (int i=0; i<_departArr.count; i++) {
                if ([_departArr[i][@"city_des"] isEqualToString:str2]) {
                    index=i;
                }
            }
            NSString* pathStr2=_departArr[index][@"city"];
            
            //查找_areaArr数组 和_currentContryArr数组 的index值,找到拼接id
            index=0;
            int indexArea=0;
            int indexContry=0;
            NSMutableString* pathStr3=[[NSMutableString alloc]init];
            NSMutableString* pathStr4=[[NSMutableString alloc]init];
            for (int i=0; i<_areaArr.count; i++) {
                //NSLog(@"%d",i);
                NSMutableArray* tempArr=[[NSMutableArray alloc]init];
                [tempArr addObjectsFromArray:_areaArr[i][@"country"]];
                for (int j=0; j<tempArr.count; j++) {
                    //NSLog(@"%d",j);
                    if ([tempArr[j][@"country_name"] isEqualToString:str3]) {
                        indexContry=j;
                        indexArea=i;
                    }
                }
            }
            [pathStr3 setString:[NSString stringWithFormat:@"%@",_areaArr[indexArea][@"continent_id"]]];
            [pathStr4 setString:[NSString stringWithFormat:@"%@",_currentContryArr[indexContry][@"country_id"]]];
            
            //查找_timeArr组的index值,找到拼接id
            index=0;
            for (int i=0; i<_timeArr.count; i++) {
                if ([_timeArr[i][@"description"] isEqualToString:str4]) {
                    index=i;
                }
            }
            NSString* pathStr5=_timeArr[index][@"times"];
        for (int i=0; i<_priceArr.count; i++) {
            if ([_priceArr[i][@"description"] isEqualToString:str5]) {
                index=i;
            }
        }
            NSString* pageStrAll=[NSString stringWithFormat:DISCOUNTSMAL11,pathStr3,pathStr4,pathStr2,currentPage,pathStr1,pathStr5,DISCOUNTSMAL2];
            [RequestManager requestWithURLString:pageStrAll pardic:nil requesttype:requestGET finish:^(NSData *data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                if (currentPage == 1) {
                    [dataSource removeAllObjects];
                }
                NSMutableArray *arr = dic[@"data"][@"lastminutes"];
                [dataSource addObjectsFromArray:arr];
                [_collection reloadData];
                [_collection.mj_footer endRefreshing];
                [_collection.mj_header endRefreshing];
            } error:^(NSError *error) {
                
            }];
        
        }
    }
   
}
#pragma mark --- 创建collectionView --- 
-(void)creatCollection{
    UICollectionViewFlowLayout* layout=[[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    _collection=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 30, kScreenWidth, self.view.frame.size.height - 94) collectionViewLayout:layout];
    _collection.dataSource=self;
    _collection.delegate=self;
    _collection.backgroundColor=[UIColor colorWithWhite:0.9 alpha:1.f];
    [self.view addSubview:_collection];
    
    [_collection registerClass:[DiscountLabelCell class] forCellWithReuseIdentifier:@"DiscountLabelCell"];
    _collection.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        currentPage = 1;
        [self resetItemSizeWithMenuTag:50 By:nil];
    }];
    
    _collection.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        currentPage++;
        [self resetItemSizeWithMenuTag:50 By:nil];
    }];

}
#pragma mark --- collectionView协议方法 ---
-(NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *disCellID = @"DiscountLabelCell";
    DiscountLabelCell *disCell = [collectionView dequeueReusableCellWithReuseIdentifier:disCellID forIndexPath:indexPath];
        NSString *imageStr = dataSource[indexPath.row][@"pic"];
        [disCell.disImageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:kPlacehodeImage completed:nil];
        disCell.disTitlelabel.text = dataSource[indexPath.row][@"title"];
        disCell.disTimeLabel.text = dataSource[indexPath.row][@"departureTime"];
        NSString* strPrice = dataSource[indexPath.row][@"price"];
        NSString* search = @"(>)(\\w+)(<)";
        NSRange range = [strPrice rangeOfString:search options:NSRegularExpressionSearch];
        if (range.location != NSNotFound) {
            
            disCell.disPriceLabel.text = [strPrice substringWithRange:NSMakeRange(range.location + 1, range.length - 2)];
            
        }
        
        disCell.disDiscountLabel.text = dataSource[indexPath.row][@"lastminute_des"];
    
    
    return disCell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(181*(kScreenWidth/375.0), 190*(kScreenHeight/667.0));
}

//设置collectionView当前页距离四周的边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 2.5*(kScreenWidth/375.0), 0, 2.5*(kScreenHeight/375.0));
}

//设置最小行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 7*(kScreenHeight/667.0);
}
//设置最小列间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5*(kScreenWidth/375.0);
}
// cell点击方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    RecommendWebViewController* webView=[[RecommendWebViewController alloc]init];
    webView.pathStr=dataSource[indexPath.row][@"url"];
    [self.navigationController pushViewController:webView animated:YES];
}
#pragma mark --- 网络请求 --- 
-(void)reloadTableSource {
    [RequestManager requestWithURLString:DISCOUNT pardic:nil requesttype:requestGET finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *arr = dic[@"data"][@"lastminutes"];
        [dataSource addObjectsFromArray:arr];
        [_collection reloadData];
        [_collection.mj_header endRefreshing];
    } error:^(NSError *error) {
        
    }];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden=NO;
}
@end
