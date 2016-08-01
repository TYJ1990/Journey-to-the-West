//
//  PhoneCardViewController.m
//  Product-B
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "PhoneCardViewController.h"
#import "PhoneCardModel.h"
#import "PhoneCardTableViewCell.h"
#import "PhoneCardCollectionViewCell.h"

@interface PhoneCardViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)UITableView *tableV;

@property(nonatomic,strong)NSMutableArray *tabArr;

@property(nonatomic,strong)UIView *headview;

@property(nonatomic,strong)NSMutableArray *Btnarr;

// 筛选的CollectionV

@property(nonatomic,strong)UICollectionView *selectCollectionV;

@property(nonatomic,strong)NSArray *selectArr;

// 筛选的MidTableV
@property(nonatomic,strong)UITableView *midSelectTableV;
@property(nonatomic,strong)NSMutableArray *MidtabArr;


@end

@implementation PhoneCardViewController
#pragma mark ---懒加载

-(NSMutableArray *)Btnarr
{
    if (!_Btnarr) {
        _Btnarr = [NSMutableArray array];
    }
    return _Btnarr;
    
}

-(NSMutableArray *)tabArr
{
    if (!_tabArr) {
        _tabArr = [NSMutableArray array];
    }
    return _tabArr;
}


-(void)requestData
{
    NSString *path = @"http://open.qyer.com/qyer/discount/zk/search_list?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&keyword=%E5%8F%B0%E6%B9%BE&lat=31.13008220649684&lon=121.2839679825676&order=1&page=1&track_app_channel=App%2520Store&track_app_version=6.9.4&track_device_info=iPhone7%2C2&track_deviceid=FDA917EF-BF2C-4F87-A49E-81DE31077108&track_os=ios%25209.2&type2=2375&v=1";
    
    
    [RequestManager requestWithURLString:path pardic:nil requesttype:requestGET finish:^(NSData *data) {
        
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        self.tabArr = [PhoneCardModel PhoneCardModelConfigure:jsonDic];
        
        [self.tableV reloadData];
        
    } error:^(NSError *error) {
        
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"网络错误" message:@"检查网络是否连接" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleCancel) handler:nil];
        
        [ac addAction:act];
        
        [self presentViewController:ac animated:YES completion:nil];
    }];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.selectArr =[NSArray arrayWithObjects:@"全部产品",@"机酒套餐",@"特价机票",@"签证",@"WIFI/电话卡",@"门票",@"当地游",@"交通票券",@"接送机",@"自驾租车",@"特价酒店",@"保险",@"邮轮", nil];
    
    self.MidtabArr = [NSMutableArray arrayWithObjects:@"智能排序",@"销量从高到低",@"价格从高到底",@"按新品排序", nil];
    
    [self createheadV];
    
    [self createTableL];
    
    [self requestData];

    [self createCollectionV];
    
    [self createMidTableV];
    
}






#pragma mark ---创建tableV
- (void)createTableL {
    
    self.tableV = [[UITableView alloc]initWithFrame:[self createFrimeWithX:0 andY:40 andWidth:375 andHeight:667-124] style:(UITableViewStylePlain)];
    
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableV.delegate =self;
    
    self.tableV.dataSource = self;
    
    [self.tableV registerClass:[PhoneCardTableViewCell class] forCellReuseIdentifier:@"ss"];
    
    [self.view addSubview:self.tableV];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableV) {
        return self.tabArr.count;
    }else
    {
        return self.MidtabArr.count;
    }
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableV) {
        PhoneCardModel *model = self.tabArr[indexPath.row];
        
        PhoneCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss" forIndexPath:indexPath];
        
        [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:nil completed:nil];
        
        cell.titleL.text = model.title;
        
        cell.soldL.text = model.sold;
        
        cell.priceL.text = [NSString stringWithFormat:@"%@",model.price];
        
        return cell;

    }else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aa"];
        if (cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"aa"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.text = self.MidtabArr[indexPath.row];
        
        cell.textLabel.textAlignment = 1;
        
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        
        return cell;
    }
    
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableV) {
        return 100;
    }else
    {
        return 40;
    }
}
#pragma mark ---头部视图的创建

-(void)createheadV
{
    NSArray *arr = [NSArray arrayWithObjects:@"WIFI电话",@"智能排序",@"更多筛选", nil];
    
    self.headview = [[UIView alloc]initWithFrame:[self createFrimeWithX:0 andY:0 andWidth:375 andHeight:40]];
    
    self.headview.backgroundColor = [UIColor redColor];
    
    self.headview.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i<3; i++) {
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        
        btn.frame = [self createFrimeWithX:0+125*i andY:0 andWidth:125 andHeight:40];
        
        [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        
        [btn setTitle:arr[i] forState:(UIControlStateNormal)];
        
        NSLog(@"%@",btn.titleLabel.text);
        
        [btn addTarget:self action:@selector(shuaixuan:) forControlEvents:(UIControlEventTouchUpInside)];
        
        btn.tag = i+100;
        
        [self.Btnarr addObject:btn];
        
        [self.headview addSubview:btn];
       
    }
    
     [self.view addSubview:self.headview];

}

#pragma mark ---筛选的点击方法
-(void)shuaixuan:(UIButton *)btn
{
    for (UIButton *button in self.Btnarr) {
        [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    }
    
    
    if (btn.tag==100) {
        
        [UIView animateWithDuration:0.2 animations:^{
            self.midSelectTableV.frame = [self createFrimeWithX:0 andY:40 andWidth:375 andHeight:0];
        }];
        if (self.selectCollectionV.frame.size.height==0) {
            
            [UIView animateWithDuration:0.2 animations:^{
                
                self.selectCollectionV.frame = [self createFrimeWithX:0 andY:40 andWidth:375 andHeight:300];
                
                [btn setTitleColor:[UIColor greenColor] forState:(UIControlStateNormal)];
                
            }];
            
        }else
            
        {
            
            [UIView animateWithDuration:0.2 animations:^{
                self.selectCollectionV.frame = [self createFrimeWithX:0 andY:40 andWidth:375 andHeight:0];
                
            }];

        }
        
    }else if (btn.tag==101)
    {
        [UIView animateWithDuration:0.2 animations:^{
            self.selectCollectionV.frame = [self createFrimeWithX:0 andY:40 andWidth:375 andHeight:0];
            
        }];
        
        
        
        if (self.midSelectTableV.frame.size.height==0) {
            [UIView animateWithDuration:0.2 animations:^{
                self.midSelectTableV.frame = [self createFrimeWithX:0 andY:40 andWidth:375 andHeight:160];
            }];
             [btn setTitleColor:[UIColor greenColor] forState:(UIControlStateNormal)];
        }else
        {
            [UIView animateWithDuration:0.2 animations:^{
                self.midSelectTableV.frame = [self createFrimeWithX:0 andY:40 andWidth:375 andHeight:0];
            }];
            
        }
    }
    
}


#pragma mark ---tableview一滑动就把筛选栏收起
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.1 animations:^{
        self.midSelectTableV.frame = [self createFrimeWithX:0 andY:40 andWidth:375 andHeight:0];
    }];

    
    [UIView animateWithDuration:0.1 animations:^{
        self.selectCollectionV.frame = [self createFrimeWithX:0 andY:40 andWidth:375 andHeight:0];
    }];
    
}

#pragma mark ---创建筛选的CollectionV

-(void)createCollectionV
{
    UICollectionViewFlowLayout *layout  = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 1;
    layout.minimumLineSpacing = 1;
    layout.itemSize = CGSizeMake(90*(kScreenWidth/375), 70*(kScreenHeight/667));
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    
    self.selectCollectionV = [[UICollectionView alloc]initWithFrame:[self createFrimeWithX:0 andY:40 andWidth:375 andHeight:0] collectionViewLayout:layout];
    
    self.selectCollectionV.delegate = self;
    self.selectCollectionV.dataSource =self;
    self.selectCollectionV.backgroundColor = [UIColor whiteColor];
    
    [self.selectCollectionV registerNib:[UINib nibWithNibName:@"PhoneCardCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"PhoneCardCell"];
    
    [self.view addSubview:self.selectCollectionV];
    

}

#pragma mark ---CollectionV的代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.selectArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhoneCardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhoneCardCell" forIndexPath:indexPath];
    
    cell.titleL.text = self.selectArr[indexPath.row];
    return cell;
    
}

#pragma mark ---MidtableView的创建
-(void)createMidTableV
{
    self.midSelectTableV = [[UITableView alloc]initWithFrame:[self createFrimeWithX:0 andY:40 andWidth:375 andHeight:0] style:(UITableViewStylePlain)];
    
    self.midSelectTableV.delegate =self;
    
    self.midSelectTableV.dataSource =self;
    
    self.midSelectTableV.scrollEnabled = NO;
    
    self.midSelectTableV.separatorColor = [UIColor grayColor];
    
    [self.view addSubview:self.midSelectTableV];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (tableView == self.tableV) {
        
        
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





#pragma mark ---适配屏幕的方法;
-(CGRect)createFrimeWithX:(CGFloat)x andY:(CGFloat)y andWidth:(CGFloat)width andHeight:(CGFloat)height{
    
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
