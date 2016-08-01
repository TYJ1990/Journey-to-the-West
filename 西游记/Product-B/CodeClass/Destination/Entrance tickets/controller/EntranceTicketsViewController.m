//
//  EntranceTicketsViewController.m
//  Product-B
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "EntranceTicketsViewController.h"
#import "EntranceTicketsModel.h"
#import "EntranceTicketsTableViewCell.h"
#import "EntranceCollectionViewCell.h"
#import "EntranceTicketsWebViewController.h"
@interface EntranceTicketsViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)UITableView *tableV;
@property(nonatomic,strong)NSMutableArray *tableArr;

@property(nonatomic,strong)NSArray *btnTitle;
// 创建筛选的第一个门票
@property(nonatomic,strong)UICollectionView *collectV;

@property(nonatomic,strong)NSArray *firstCollectionArr;


@property(nonatomic,strong)UITableView *SecondTabV;
@property(nonatomic,strong)NSArray *SecondArr;


@end

@implementation EntranceTicketsViewController

-(NSMutableArray *)tableArr
{
    if (!_tableArr) {
        _tableArr = [NSMutableArray array];
    }
    return _tableArr;
}






-(void)requestData
{
    NSString *string = @"http://open.qyer.com/qyer/discount/zk/search_list?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&keyword=%E6%BE%B3%E9%97%A8&lat=31.13009893174755&lon=121.2839738562559&order=1&page=1&track_app_channel=App%2520Store&track_app_version=6.9.4&track_device_info=iPhone7%2C2&track_deviceid=FDA917EF-BF2C-4F87-A49E-81DE31077108&track_os=ios%25209.2&type2=2377&v=1";
    [RequestManager requestWithURLString:string pardic:nil requesttype:requestGET finish:^(NSData *data) {
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.tableArr = [EntranceTicketsModel tableArrModelConfigure:jsonDic];
        [self.tableV reloadData];
        
    } error:^(NSError *error) {
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"网络错误" message:@"检查网络是否连接" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleCancel) handler:nil];
        
        [ac addAction:act];
        
        [self presentViewController:ac animated:YES completion:nil];
        
    }];
    
}

-(void)createshaixuan
{
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        btn.frame = [self createFrimeWithX:0+125*i andY:0 andWidth:125 andHeight:40];
        [btn addTarget:self action:@selector(shaixuan:) forControlEvents:(UIControlEventTouchUpInside)];
        [btn setTitle:self.btnTitle[i] forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        btn.tag = i + 100;
        [self.view addSubview:btn];
        
    }
    UIView *view = [[UIView alloc]initWithFrame:[self createFrimeWithX:0 andY:100 andWidth:375 andHeight:1]];
    
    view.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:view];
    
    
    

}

-(void)shaixuan:(UIButton *)btn
{

    if (btn.tag == 100) {
        [UIView animateWithDuration:0.3 animations:^{
            self.SecondTabV.frame = [self createFrimeWithX:0 andY:40 andWidth:375 andHeight:0];
        }];
      
        if (self.collectV.frame.size.height==0) {
            
            [UIView animateWithDuration:0.3 animations:^{
                self.collectV.frame =[self createFrimeWithX:0 andY:40 andWidth:375 andHeight:310];
            }];
        }else
        {
            [UIView animateWithDuration:0.3 animations:^{
                self.collectV.frame =[self createFrimeWithX:0 andY:40 andWidth:375 andHeight:0];
            }];
            
        }
    }else if (btn.tag ==101)
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.collectV.frame =[self createFrimeWithX:0 andY:40 andWidth:375 andHeight:0];
        }];

  
        if (self.SecondTabV.frame.size.height==0) {
            [UIView animateWithDuration:0.3 animations:^{
          self.SecondTabV.frame = [self createFrimeWithX:0 andY:40 andWidth:375 andHeight:160];
            }];
        }else
        {
            [UIView animateWithDuration:0.3 animations:^{
              self.SecondTabV.frame = [self createFrimeWithX:0 andY:40 andWidth:375 andHeight:0];
            }];
            
            
        }
        
        
    }else if (btn.tag==102)
    {
        
        
    
        
    }

}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.btnTitle = [NSArray arrayWithObjects:@"门票",@"智能排序",@"更多筛选", nil];
    
    self.firstCollectionArr = [NSArray arrayWithObjects:@"全部产品",@"机酒套餐",@"特价机票",@"签证",@"WIFI/电话卡",@"门票",@"当地游",@"交通票券",@"接送机",@"自驾租车",@"特价酒店",@"保险",@"邮轮", nil];
    
    self.SecondArr = [NSArray arrayWithObjects:@"智能排序",@"销量从高到低排序",@"价格从高到底排序",@"按新品排序" ,nil];
    
    
    
    [self createshaixuan];
    
    [self requestData];
    
    [self createTableView];
    
    [self createFirstCollectionV];
    [self createSecondTableV];
    
    
    
}

#pragma mark ---创建筛选门票的第一个
-(void)createFirstCollectionV
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.minimumInteritemSpacing = 1;
    
    layout.minimumLineSpacing  = 1;
    
    layout.itemSize = CGSizeMake(90*(kScreenWidth/375), 75*(kScreenHeight/667));
    
    layout.sectionInset = UIEdgeInsetsMake(1, 1, 1, 1);
    
    self.collectV = [[UICollectionView alloc]initWithFrame:[self createFrimeWithX:0 andY:40 andWidth:375 andHeight:0] collectionViewLayout:layout];
    self.collectV.delegate = self;
    self.collectV.dataSource =self;
    self.collectV.backgroundColor = [UIColor whiteColor];
    
    
    
    [self.collectV registerClass:[EntranceCollectionViewCell class] forCellWithReuseIdentifier:@"ss"];
    
    
    [self.view addSubview:self.collectV];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"%ld",self.firstCollectionArr.count);
    return self.firstCollectionArr.count;
    
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EntranceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ss" forIndexPath:indexPath];
    
    cell.titleL.text = self.firstCollectionArr[indexPath.row];
    
    return cell;
}

#pragma mark ---创建筛选门票的第二个
-(void)createSecondTableV
{
    self.SecondTabV = [[UITableView alloc]initWithFrame:[self createFrimeWithX:0 andY:40 andWidth:375 andHeight:0] style:(UITableViewStylePlain)];
    
    self.SecondTabV.delegate = self;
    
    self.SecondTabV.dataSource = self;
    
    self.SecondTabV.scrollEnabled = YES;
    self.SecondTabV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.SecondTabV];
    
}






#pragma mark ---创建所有的最大的tableView
-(void)createTableView
{
    self.tableV = [[UITableView alloc] initWithFrame:[self createFrimeWithX:0 andY:40 andWidth:375 andHeight:667-104] style:(UITableViewStylePlain)];
    
    self.tableV.delegate = self;
    
    self.tableV.dataSource = self;
    
    [self.tableV registerClass:[EntranceTicketsTableViewCell class] forCellReuseIdentifier:@"EntranceTicketsTableViewCell"];
    
    [self.view addSubview:self.tableV];
 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView ==self.tableV) {
        return self.tableArr.count;
    }else
    {
        return self.SecondArr.count;
    }
    
  
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView ==self.tableV) {
        EntranceTicketsModel *model = self.tableArr[indexPath.row];
        
        EntranceTicketsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EntranceTicketsTableViewCell" forIndexPath:indexPath];
        
        [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:nil completed:nil];
        
        cell.titleL.text = model.title;
        
        cell.priceL.text = [NSString stringWithFormat:@"%@元起",model.price];
        
        cell.soldL.text = model.sold;
        
        return cell;

    }else
    {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss"];
        
        if (cell==nil) {
        
            cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"ss"];
        
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.text = self.SecondArr[indexPath.row];
        
        cell.textLabel.textAlignment = 1;
        
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        
        if ([cell isSelected]) {
            
            cell.textLabel.textColor = [UIColor greenColor];
            
        }else
        {
            
            cell.textLabel.textColor = [UIColor blackColor];
            
        }
        
        return cell;
        
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (tableView == self.tableV) {
        
        return 100*(kScreenHeight/667);

    }else
    {
        return 40*(kScreenHeight/667);
    }
    
}

#pragma mark ---tableView 的选中方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.tableV) {
        
        EntranceTicketsModel *model = self.tableArr[indexPath.row];
        
        EntranceTicketsWebViewController *WebV = [[EntranceTicketsWebViewController alloc]init];
        NSLog(@"%@",model.TabID);
        
        WebV.WebID = [NSString stringWithFormat:@"%@",model.TabID];
        
        [self.navigationController pushViewController:WebV animated:YES];
    }else
    {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
            cell.textLabel.textColor = [UIColor greenColor];
        
    }
}


-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableV) {

    }else
    {
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        cell.textLabel.textColor = [UIColor blackColor];
        
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(CGRect)createFrimeWithX:(CGFloat)x andY:(CGFloat)y andWidth:(CGFloat)width andHeight:(CGFloat)height{
    
    return CGRectMake(x*(kScreenWidth/375), y*(kScreenHeight/667), width*(kScreenWidth/375), height*(kScreenHeight/667));
    
}

@end
