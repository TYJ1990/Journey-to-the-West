//
//  CommunityViewController.m
//  Product-B
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CommunityViewController.h"
#import "CommunityModel.h"
#import "HelpCollectionViewCell.h"
#import "ContinentCollectionViewCell.h"
#import "CommCollectionReusableView.h"

#import "CommunityAnswerViewController.h"
#import "CommunityCompanyViewController.h"
#import "CommunityDeltaViewController.h"
@interface CommunityViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong)NSMutableArray *communityArray;

@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSDictionary *dic;

@property (nonatomic, strong)NSMutableArray *groupArray;

@property(nonatomic,strong)NSMutableArray *forum_listArr;


@end

@implementation CommunityViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestData];
    [self initCollectionView];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navImg"] forBarMetrics:0];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.title = @"说走就走";
}

#pragma mark 数据请求
- (void)requestData
{
    [RequestManager requestWithURLString:CommunityURL pardic:nil requesttype:requestGET finish:^(NSData *data) {
        self.dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.groupArray = [NSMutableArray array];
        NSDictionary *dataDic = self.dic[@"data"];
        self.forum_listArr = dataDic[@"forum_list"];
         for (NSDictionary *dic in self.forum_listArr) {
             NSMutableArray *arr = [NSMutableArray array];
              for (NSDictionary *dic1 in dic[@"group"]) {
                CommunityModel *model = [[CommunityModel alloc] init];
                 model.photo = dic1[@"photo"];
                 model.groupName = dic1[@"name"];
                 model.groupId = dic1[@"id"];
                 model.total_threads = dic1[@"total_threads"];
                 model.name = dic[@"name"];
                 [arr addObject:model];
             }
             [self.groupArray addObject:arr];
         }
         [self.collectionView reloadData];
    } error:^(NSError *error) {
    }];

}

#pragma mark  创建CollectionView
- (void)initCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kScreenWidth/2 - 10, kScreenHeight * 0.15);
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 5, 0, 5);
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    layout.headerReferenceSize = CGSizeMake(200, 40);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)collectionViewLayout:layout];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
     self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    // 注册
    [self.collectionView registerClass:[HelpCollectionViewCell class] forCellWithReuseIdentifier:@"button"];
    [self.collectionView registerClass:[ContinentCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[CommCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot"];


    [self.view addSubview:self.collectionView];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.forum_listArr.count + 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }else{
        
        NSMutableArray *arr = self.groupArray[section-1];
        return arr.count ;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 第一个分区
    if (indexPath.section == 0) {
        HelpCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"button" forIndexPath:indexPath];

        if (indexPath.row == 0) {
            cell.nameTitleL.text = @"问答";
            cell.countL.text = [NSString stringWithFormat:@"%@个问题得到解决",self.dic[@"data"][@"counts"][@"ask"]];
            cell.backgroundColor = [UIColor blueColor];
            return cell;

        }else{
            cell.nameTitleL.text = @"结伴";
            cell.countL.text = [NSString stringWithFormat:@"%@个网友在此结伴",self.dic[@"data"][@"counts"][@"company"]];
            cell.backgroundColor = [UIColor redColor];
            return cell;
        }
    }else{
   
       ContinentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
       CommunityModel *model = self.groupArray[indexPath.section-1][indexPath.row];
      [cell.photoImageV sd_setImageWithURL:[NSURL URLWithString:model.photo]];
       cell.nameL.text = model.groupName;
       cell.total_threadsL.text = [NSString stringWithFormat:@"%@个帖子",model.total_threads];
       
       return cell;
    }
}
#pragma mark  分区头
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CommCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"head" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        view.titleL.text = @"爱心帮助";
        return view;
    }
    CommunityModel *model = self.groupArray[indexPath.section-1][indexPath.row];
    view.titleL.text = model.name;
    return view;
}

#pragma mark 点击进入问答界面
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            CommunityAnswerViewController *caVC = [[CommunityAnswerViewController alloc] init];
            [self.navigationController pushViewController:caVC animated:YES];
        }else{
            CommunityCompanyViewController *ccVC = [[CommunityCompanyViewController alloc] init];
            [self.navigationController pushViewController:ccVC animated:YES];
        }
    }else{
        CommunityDeltaViewController *cdVC = [[CommunityDeltaViewController alloc] init];
        CommunityModel *model = self.groupArray[indexPath.section-1][indexPath.row];
        cdVC.groupId = model.groupId;
        cdVC.groupName = model.groupName;
        cdVC.photo = model.photo;
        cdVC.total_threads = model.total_threads;
        [self.navigationController pushViewController:cdVC animated:YES];
        
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
