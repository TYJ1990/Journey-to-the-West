//
//  DestionationCityModel.h
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DestionationCityModel : NSObject

@property(nonatomic,strong)NSString *cnname;// 轮播图上的中文名
@property(nonatomic,strong)NSString *enname;// 轮播图上的英文名
@property(nonatomic,strong)NSString *entryCont;// 轮播图上的简介

#pragma mark ---中间的collectionView的数据local_discount

@property(nonatomic,strong)NSString *priceoff;// 折扣
@property(nonatomic,strong)NSString *title;// 标题
@property(nonatomic,strong)NSString *photo;// 图片
@property(nonatomic,strong)NSNumber *collectionID; // ID
@property(nonatomic,strong)NSString *price;

#pragma mark ---下方的tableView的数据new_discount

@property(nonatomic,strong)NSString *expire_date;
@property(nonatomic,strong)NSString *tableID;


+(NSMutableArray *)lunbotuModelconfigure:(NSDictionary *)jsonDic;// 轮播图的图片数据解析;

+(DestionationCityModel *)lunbotuDataModelConfigure:(NSDictionary *)jsonDic;// 轮播图的上面数据的解析;

+(NSMutableArray *)collectionModelConfigure:(NSDictionary *)jsonDic;// 中间的collection的数据解析

+(NSMutableArray *)tableModelConfigure:(NSDictionary *)jsonDic;

@end
