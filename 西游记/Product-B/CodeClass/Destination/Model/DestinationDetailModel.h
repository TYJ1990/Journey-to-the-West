//
//  DestinationDetailModel.h
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DestinationDetailModel : NSObject


@property(nonatomic,strong)NSString *cnname;// 轮播图上的中文名

@property(nonatomic,strong)NSString *enname;// 轮播图上的英文名字和hot_city公用的
@property(nonatomic,strong)NSString *entryCont;// 轮播图上的介绍和hot_city公用的
// 有个id和hot_city公用的和new_discount
@property(nonatomic,assign)NSInteger *myId;

// 上面的图片与下面的图片也是公用的
@property(nonatomic,strong)NSString *photo;

// 中间的四个图片的城市的数组
@property(nonatomic,strong)NSMutableArray *hot_city;
@property(nonatomic,strong)NSNumber *collectionID;

// 最下方的tableview

@property(nonatomic,strong)NSMutableArray *newdiscount;
@property(nonatomic,strong)NSString *price;// 价格
@property(nonatomic,strong)NSString *title;//tableView的标题
@property(nonatomic,strong)NSString *priceoff;// 折扣;
@property(nonatomic,strong)NSString *expire_date;// 结束日期
@property(nonatomic,strong)NSNumber *tableID;
// 不知道有什么卵用的
@property(nonatomic,assign)NSInteger guide_num;
@property(nonatomic,assign)NSInteger beento;




// 轮播图的数据解析2个
+(NSMutableArray *)LunbotumodelConfigure:(NSDictionary *)jsdic;

+(DestinationDetailModel *)lunboshujuConfigure:(NSDictionary *)jsdic;

+(NSMutableArray *)collectionModelConfigure:(NSDictionary *)jsonDic;

+(NSMutableArray *)tableModelConfigure:(NSDictionary *)jsonDic;





@end
