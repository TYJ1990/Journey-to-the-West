//
//  AllSpecilModel.m
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "AllSpecilModel.h"

@implementation AllSpecilModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
+ (NSMutableArray *)modelCongifureWithJsonDic:(NSDictionary *)jsonDic
{
    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *arr = jsonDic[@"data"];
    for (NSDictionary *dic in arr) {
        AllSpecilModel *model = [[AllSpecilModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [array addObject:model];
    }
    return array;
}

@end
