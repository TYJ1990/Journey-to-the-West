//
//  ScenicModel.h
//  Product-B
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger , cellType) {
    noDiscount,
    oneDiscount,
    twoDiscount
};

@interface ScenicModel : NSObject
// collectionV
@property(nonatomic,strong)NSString *pic;
@property(nonatomic,strong)NSString *link;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSNumber *type;

// tableV
@property(nonatomic,strong)NSString *photo;
@property(nonatomic,strong)NSNumber *beennumber;// 多少人去过
@property(nonatomic,strong)NSString *catename;// 景点类型
@property(nonatomic,strong)NSString *chinesename;// 景点名称(中文)
@property(nonatomic,strong)NSString *englishname;// 景点名称(英文)
@property(nonatomic,strong)NSString *rank;// 观光景点名次
@property(nonatomic,strong)NSString *distance;// 观光景点的距离
@property(nonatomic,strong)NSString *grade;// 观光景点评分
@property(nonatomic,strong)NSMutableArray  *discounts;// 折扣的数组
@property(nonatomic,strong)NSNumber *tableVID;

// tableV的折扣
//@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *priceoff;
@property(nonatomic,strong)NSNumber *discountsID;

@property(nonatomic,assign)cellType NumberOfDiscount;

+(NSMutableArray *)collectionConfigureModel:(NSDictionary *)jsonDic;

+(NSMutableArray *)tableVConfigureModel:(NSDictionary *)jsonDic;


@end
