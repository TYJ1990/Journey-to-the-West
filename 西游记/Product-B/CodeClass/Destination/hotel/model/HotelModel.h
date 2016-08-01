//
//  HotelModel.h
//  Product-B
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotelModel : NSObject

#pragma mark ---头部视图的东西
@property(nonatomic,strong)NSString *city_name;// 城市的名字
@property(nonatomic,strong)NSString *city_photo; // 城市的照片
@property(nonatomic,strong)NSString *intro; // 城市的介绍
@property(nonatomic,strong)NSString *name; // 宾馆类型
//@property(nonatomic,strong)NSString *price; // 价格类型

#pragma mark ---铺界面用的
@property(nonatomic,strong)NSString *cnname;// 中文酒店名字
@property(nonatomic,strong)NSString *enname;// 英文酒店名
@property(nonatomic,strong)NSNumber *hotelID;// 酒店的ID
@property(nonatomic,strong)NSNumber *ranking;// 评分
@property(nonatomic,strong)NSString *star;// 星级别
@property(nonatomic,strong)NSNumber *price;// 价格
@property(nonatomic,strong)NSString *photo;
#pragma mark ---不知道有什么用的
@property(nonatomic,strong)NSNumber *has_room;
//酒店网址啊
@property(nonatomic,strong)NSString *link;




+(NSMutableArray *)hotelArrModelConfigure:(NSDictionary *)jsonDic;


+(NSMutableArray *)hotelheadArrModelConfigure:(NSDictionary *)jsonDic;

+(HotelModel *)modelConfigure:(NSDictionary *)jsonDic;// 头部视图的图和地区名字
+(HotelModel *)modelconfigure2:(NSDictionary *)jsonDic;

@end
