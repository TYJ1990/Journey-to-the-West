//
//  LocalPlayerModel.m
//  Product-B
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "LocalPlayerModel.h"

@implementation LocalPlayerModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(NSMutableArray *)CollectionModelConfigure:(NSDictionary *)jsonDic
{
    NSMutableArray *arr= [NSMutableArray array];
    NSDictionary *dataDic = jsonDic[@"data"];
    NSArray *categoryArr = dataDic[@"category"];
    for (NSDictionary *CollectVdic in categoryArr) {
        LocalPlayerModel *model = [[LocalPlayerModel alloc]init];
        [model setValuesForKeysWithDictionary:CollectVdic];
        model.CollectID = CollectVdic[@"id"];
        [arr addObject:model];
    }
    return arr;
}

+(NSMutableArray *)TableModelConfigure:(NSDictionary *)jsonDic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *dataDic = jsonDic[@"data"];
    NSArray *listArr = dataDic[@"list"];
    for (NSDictionary *dic in listArr) {
        LocalPlayerModel *model = [[LocalPlayerModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        model.tableID = dic[@"id"];
        [arr addObject:model];
    }
    
    return arr;
    
}



@end
