//
//  DestinationModel.h
//  Product-B
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DestinationModel : NSObject

@property(nonatomic,strong)NSString *cnname;// 中文名

@property(nonatomic,strong)NSString *enname;// 英文名

@property(nonatomic,assign)NSInteger count;// 城市数量

@property(nonatomic,assign)NSInteger flag;// flag值

@property(nonatomic,strong)NSNumber *Myid;// id值

@property(nonatomic,strong)NSString *label;// label值

@property(nonatomic,strong)NSString *photo;// 城市图片

@property(nonatomic,strong)NSMutableArray *country;//全部城市的数组

@property(nonatomic,strong)NSMutableArray *hot_country;//热门城市的数组

+(NSMutableArray *)modelConfigure:(NSDictionary *)jsondic;

+(NSMutableArray *)AllmodelConfigure:(NSDictionary *)dic; // 所有国家数据解析

+(NSMutableArray *)hotmodelConfigure:(NSDictionary *)dic;// 热门国家的数据解析



@end
