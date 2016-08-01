//
//  DestinationModel.m
//  Product-B
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "DestinationModel.h"

@implementation DestinationModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(NSMutableArray *)modelConfigure:(NSDictionary *)jsondic
{
    NSMutableArray *arr = [NSMutableArray array];
    
    NSArray *dataArr = jsondic[@"data"];


    arr = [dataArr mutableCopy];
    
    return arr;
}

+(NSMutableArray *)AllmodelConfigure:(NSDictionary *)dic// 所有国家数据解析
{
    NSMutableArray *arr = [NSMutableArray array];
   
        NSArray *countryArr = dic[@"country"];
        for (NSDictionary *listDic in countryArr) {
            DestinationModel *model = [[DestinationModel alloc]init];
            [model setValuesForKeysWithDictionary:listDic];
             model.Myid = listDic[@"id"];
            [arr addObject:model];
        
    }
    return arr;
}

+(NSMutableArray *)hotmodelConfigure:(NSDictionary *)dic// 热门国家的数据解析
{
    
    NSMutableArray *arr= [NSMutableArray array];
    
        NSArray *hot_country = dic[@"hot_country"];
        for (NSDictionary *listDic in hot_country) {
            DestinationModel *model = [[DestinationModel alloc]init];
            [model setValuesForKeysWithDictionary:listDic];
            model.Myid = listDic[@"id"];
            [arr addObject:model];
            
    }
    return arr;
    
}




@end
