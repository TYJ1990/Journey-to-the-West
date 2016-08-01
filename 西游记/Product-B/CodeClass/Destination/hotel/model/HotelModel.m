//
//  HotelModel.m
//  Product-B
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "HotelModel.h"

@implementation HotelModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    
}
+(NSMutableArray *)hotelArrModelConfigure:(NSDictionary *)jsonDic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *dataDic = jsonDic[@"data"];
    NSArray *hotelArr = dataDic[@"hotel"];
    for (NSDictionary *hotelDic in hotelArr) {
        HotelModel *model = [[HotelModel alloc]init];
        [model setValuesForKeysWithDictionary:hotelDic];
        [arr addObject:model];
    }
    return arr;
}

+(NSMutableArray *)hotelheadArrModelConfigure:(NSDictionary *)jsonDic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *dataDic = jsonDic[@"data"];
    NSDictionary *areaDic = dataDic[@"area"];
    NSArray *pricesarr = areaDic[@"prices"];
    for (NSDictionary *headdic in pricesarr) {
        HotelModel *model = [[HotelModel alloc]init];
        [model setValuesForKeysWithDictionary:headdic];
        [arr addObject:model];
    }
    return arr;
}


+(HotelModel *)modelConfigure:(NSDictionary *)jsonDic
{
    HotelModel *model = [[HotelModel alloc]init];
    NSDictionary *dataDic = jsonDic[@"data"];
    [model setValuesForKeysWithDictionary:dataDic];
    return  model;
    
}
+(HotelModel *)modelconfigure2:(NSDictionary *)jsonDic
{
    HotelModel *model = [[HotelModel alloc]init];
    NSDictionary *dataDic = jsonDic[@"data"];
    NSDictionary *areaDic = dataDic[@"area"];
    [model setValuesForKeysWithDictionary:areaDic];
    
    return  model;

}



@end
