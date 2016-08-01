//
//  WRAllSpecialViewController.m
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "WRAllSpecialViewController.h"
#import "SpecialAllImageCell.h"
#import "AllSpecilModel.h"
#import "RecommendWebViewController.h"
@interface WRAllSpecialViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray* dataSource;
    
    int currentPage;
}
@property (nonatomic,strong) UICollectionView *collectionView;
@end

@implementation WRAllSpecialViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    
}
#pragma mark --- collectionView ---
-(void)creatCollection{
    UICollectionViewFlowLayout* layout=[[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    _collectionView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[SpecialAllImageCell class] forCellWithReuseIdentifier:@"SpecialAllImageCell"];
    self.collectionView .mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        currentPage = 1;
        [self reloadDataSource];
    }];
    
    self.collectionView .mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        currentPage++;
        [self reloadDataSource];
    }];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    currentPage=1;
    dataSource=[[NSMutableArray alloc]init];
    [self creatCollection];
    [self reloadDataSource];

}
-(void)reloadDataSource{
       NSString* pathStr=[NSString stringWithFormat:SPECIALALL1,currentPage,SPECIALALL2];
    [RequestManager requestWithURLString:pathStr pardic:nil requesttype:requestGET finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *arr = [AllSpecilModel modelCongifureWithJsonDic:dic];
        if (currentPage == 1) {
            [dataSource removeAllObjects];
        }
        [dataSource addObjectsFromArray:arr];
        [self.collectionView reloadData];
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView.mj_header endRefreshing];
    } error:^(NSError *error) {
        
    }];
}

-(NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return dataSource.count;
}

-(UICollectionViewCell* )collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AllSpecilModel *model = dataSource[indexPath.row];
    static NSString* special=@"SpecialAllImageCell";
    SpecialAllImageCell* specialCell=[collectionView dequeueReusableCellWithReuseIdentifier:special forIndexPath:indexPath];
        [specialCell.speImageView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:kPlacehodeImage completed:nil];
    return specialCell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(357*(kScreenWidth/375.0), 250*(kScreenHeight/667.0));
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    AllSpecilModel *model = dataSource[indexPath.row];
    RecommendWebViewController* webView=[[RecommendWebViewController alloc]init];
    webView.pathStr = model.url;
    webView.naVCtitle = model.title;
    [self.navigationController pushViewController:webView animated:YES];
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden=NO;
}


@end
