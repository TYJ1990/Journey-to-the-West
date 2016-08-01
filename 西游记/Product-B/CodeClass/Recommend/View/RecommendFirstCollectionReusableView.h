//
//  RecommendFirstCollectionReusableView.h
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//
#import "RecommendViewController.h"
#import <UIKit/UIKit.h>
#import "RecommendWebViewController.h"
@interface RecommendFirstCollectionReusableView : UICollectionReusableView
@property (nonatomic,strong) CycleScrollView *scrollView;
-(void)creatSubViewsWithImagArrar:(NSMutableArray *)modelArr;
@property (nonatomic,strong) RecommendViewController *reVC;
@end
