//
//  HotelViewController.m
//  Product-B
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 lanou. All rights reserved.
//
#define hotelUrl @"http://open.qyer.com/qyer/hotel/search_list?checkin=2016-8-13%2000%3A00%3A01&checkout=2016-8-14%2023%3A59%3A59&city_id="

#define hotelUrl2 @"&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&from_key=app_ios_city_search&lat=31.13012201174614&lon=121.2840113162357&orderby=1&page=1&track_app_channel=App%2520Store&track_app_version=6.9.4&track_device_info=iPhone7%2C2&track_deviceid=FDA917EF-BF2C-4F87-A49E-81DE31077108&track_os=ios%25209.2&v=1"

#import "HotelViewController.h"

#import "HotelModel.h"
#import "HotelTableViewCell.h"
#import "UIWEBController.h"
@interface HotelViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *hotelTable;
@property(nonatomic,strong)NSMutableArray *HotelArr;

#pragma mark ---头部视图

@property(nonatomic,strong)UIView *Headview;
@property(nonatomic,strong)NSMutableArray *headArr;
@property(nonatomic,strong)HotelModel *hotelmodel;
@property(nonatomic,strong)HotelModel *hotelmodel2;
@property(nonatomic,strong)NSMutableArray *hotelPriceArr;
@end

@implementation HotelViewController

-(NSMutableArray *)hotelPriceArr
{
    if (!_hotelPriceArr) {
        _hotelPriceArr = [NSMutableArray array];
    }
    return _hotelPriceArr;
}

-(NSMutableArray *)headArr
{
    if (!_headArr) {
        _headArr = [NSMutableArray array];
    }
    return _headArr;
}

-(NSMutableArray *)HotelArr
{
    if (!_HotelArr) {
        _HotelArr = [NSMutableArray array];
    }
    return _HotelArr;
}
#pragma mark --- 数据解析
-(void) requestData
{
    NSString *path = [NSString stringWithFormat:@"%@%@%@",hotelUrl,self.ID,hotelUrl2];
    NSLog(@"%@",path);
    [RequestManager requestWithURLString:path pardic:nil requesttype:requestGET finish:^(NSData *data) {
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.HotelArr = [HotelModel hotelArrModelConfigure:jsonDic];
        
        self.headArr = [HotelModel hotelheadArrModelConfigure:jsonDic];
        
        self.hotelmodel = [HotelModel modelConfigure:jsonDic];
        self.hotelmodel2 = [HotelModel modelconfigure2:jsonDic];

        
        [self.hotelTable reloadData];
    } error:^(NSError *error) {
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"网络错误" message:@"检查网络是否连接" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleCancel) handler:nil];
        
        [ac addAction:act];
        
        [self presentViewController:ac animated:YES completion:nil];
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self requestData];
    
    [self createTableV];
}
#pragma mark ---创建tableView
- (void)createTableV
{
    self.hotelTable = [[UITableView alloc]initWithFrame:[self createFrimeWithX:0 andY:0 andWidth:375 andHeight:667] style:(UITableViewStyleGrouped)];
    
    self.hotelTable.separatorColor = [UIColor grayColor];
    self.hotelTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.hotelTable.delegate = self;
    self.hotelTable.dataSource = self;

    [self.hotelTable registerClass:[HotelTableViewCell class] forCellReuseIdentifier:@"HotelTableViewCell"];
    [self.view addSubview:self.hotelTable];
}

#pragma mark ---tableView的头部视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.Headview = [[UIView alloc]initWithFrame:[self createFrimeWithX:0 andY:0 andWidth:375 andHeight:80]];
    
    if (self.headArr.count==0) {
        self.Headview.frame = [self createFrimeWithX:0 andY:0 andWidth:375 andHeight:80];
    }else
    {
        self.Headview.frame = [self createFrimeWithX:0 andY:0 andWidth:375 andHeight:250];
    }
    
    
    UITextField *FT = [[UITextField alloc]initWithFrame:[self createFrimeWithX:35 andY:15 andWidth:305 andHeight:30]];
    FT.borderStyle = UITextBorderStyleRoundedRect;
    FT.textAlignment = 1;
    FT.placeholder = @"请输入酒店名称";
    FT.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:self.Headview.frame];
    
    [imageV sd_setImageWithURL:[NSURL URLWithString:self.hotelmodel.city_photo] placeholderImage:nil completed:nil];
    UIToolbar *blurView = [[UIToolbar alloc]init];
    blurView.barStyle = UIBarStyleBlackOpaque;
    blurView.frame = imageV.bounds;
    [imageV addSubview:blurView];
    
    
    UILabel *allArea = [[UILabel alloc]initWithFrame:[self createFrimeWithX:50 andY:65 andWidth:275 andHeight:20]];
    allArea.textAlignment = 1;
    allArea.textColor = [UIColor whiteColor];
    allArea.font = [UIFont systemFontOfSize:12];
    allArea.text = self.hotelmodel2.name;
    
    
    
    
    
    
    UILabel *intro = [[UILabel alloc]initWithFrame:[self createFrimeWithX:40 andY:85 andWidth:295 andHeight:50]];
    
    intro.text = self.hotelmodel2.intro;
    intro.numberOfLines = 0;
    intro.textColor = [UIColor whiteColor];
    intro.font = [UIFont systemFontOfSize:13];
    
    UILabel *reference = [[UILabel alloc]initWithFrame:[self createFrimeWithX:40 andY:150 andWidth:60 andHeight:40]];
    reference.text = @"参考价格  |";
    reference.textColor = [UIColor whiteColor];
    reference.font = [UIFont systemFontOfSize:12];
    
    if (self.headArr.count==0) {
        reference.hidden = YES;
    }else
    {
        reference.hidden = NO;
    }
    
    
    
    [self.Headview addSubview:imageV];
    [self.Headview addSubview:FT];
    [self.Headview addSubview:allArea];
    [self.Headview addSubview:intro];
    [self.Headview addSubview:reference];
    
    
    
    for (int i = 0; i < self.headArr.count; i++) {
        UILabel *price = [[UILabel alloc]initWithFrame:[self createFrimeWithX:100+i*60 andY:150 andWidth:50 andHeight:20]];
        
       price.textColor = [UIColor whiteColor];
        price.textAlignment = 1;
        price.font = [UIFont systemFontOfSize:12];
        
        
        HotelModel *model = self.headArr[i];
        price.text = [NSString stringWithFormat:@"%@",model.price];
        UILabel *type = [[UILabel alloc]initWithFrame:[self createFrimeWithX:100+i*60 andY:170 andWidth:50 andHeight:20]];
        type.text = model.name;
        type.textAlignment = 1;
        type.font = [UIFont systemFontOfSize:12];
        type.textColor = [UIColor whiteColor];
        
        [self.Headview addSubview:price];
        [self.Headview addSubview:type];
        
    }
    

   
    
    return self.Headview;
}
-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.headArr.count==0) {
        return 80*(kScreenWidth/375);
    }
 
    return 250*(kScreenWidth/375);
    
}



#pragma mark ---tableView的代理实现方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.HotelArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotelModel *model = self.HotelArr[indexPath.row];
    HotelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotelTableViewCell"];
    
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:nil completed:nil];
    cell.cnnameL.text = model.cnname;
    
    NSNumber *num = model.ranking;

    float fo = [num floatValue];
    NSString *s = [NSString stringWithFormat:@"%.1f",fo];
    cell.rankingL.text = [NSString stringWithFormat:@"%@",s];
    cell.ennameL.text = model.enname;
    cell.starL.text = model.star;
    cell.priceL.text = [NSString stringWithFormat:@"%@",model.price];
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

#pragma mark ---tableV的点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotelModel *model = self.HotelArr[indexPath.row];
    
    UIWEBController *webV = [[UIWEBController alloc]init];
    
    webV.htmlUrl = model.link;
    
    [self.navigationController pushViewController:webV animated:YES];
    
    
}




// 适配屏幕方法
-(CGRect)createFrimeWithX:(CGFloat)x andY:(CGFloat)y andWidth:(CGFloat)width andHeight:(CGFloat)height
{
    
    return CGRectMake(x*(kScreenWidth/375), y*(kScreenHeight/667), width*(kScreenWidth/375), height*(kScreenHeight/667));
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
