//
//  ScenicTableViewCell.h
//  Product-B
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScenicTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *imageV; // 图片
@property(nonatomic,strong)UILabel *titleLabel; // 标题
@property(nonatomic,strong)UIImageView *gradeV; // 评分图片
@property(nonatomic,strong)UILabel *gradeL; // 评分
@property(nonatomic,strong)UILabel *rankL; // 观光景点名次
@property(nonatomic,strong)UILabel *beennumberL;// 多少人去过
@property(nonatomic,strong)UILabel *catenameL; // 景点类型
@property(nonatomic,strong)UILabel *distanceL; // 观光景点距离

@property(nonatomic,strong)UILabel *DiscountitleL;
@property(nonatomic,strong)UILabel *DiscountpriceL;
@property(nonatomic,strong)UILabel *DiscountpriceoffL;

@property(nonatomic,strong)UILabel *DiscountitleL2;
@property(nonatomic,strong)UILabel *DiscountpriceL2;
@property(nonatomic,strong)UILabel *DiscountpriceoffL2;

@end
