//
//  EntranceTicketsModel.m
//  Product-B
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "EntranceTicketsModel.h"

@implementation EntranceTicketsModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}



+(NSMutableArray *)tableArrModelConfigure:(NSDictionary *)jsonDic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *data = jsonDic[@"data"];
    NSArray *listArr = data[@"list"];
    for (NSDictionary *dic in listArr) {
        EntranceTicketsModel *model = [[EntranceTicketsModel alloc]init];
        model.TabID = dic[@"id"];
        [model setValuesForKeysWithDictionary:dic];
        [arr addObject:model];
    }
    return arr;
    
}


@end
