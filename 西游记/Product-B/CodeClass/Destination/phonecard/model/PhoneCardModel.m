//
//  PhoneCardModel.m
//  Product-B
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "PhoneCardModel.h"

@implementation PhoneCardModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


+(NSMutableArray *)PhoneCardModelConfigure:(NSDictionary *)jsonDic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *dataDic = jsonDic[@"data"];
    NSArray *listArr = dataDic[@"list"];
    for (NSDictionary *dic in listArr) {
        PhoneCardModel *model = [[PhoneCardModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        model.tableID = dic[@"id"];
        [arr addObject:model];
    }
    return arr;
    
    
}

@end
