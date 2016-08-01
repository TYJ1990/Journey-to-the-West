//
//  CityModel.m
//  Product-B
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
+ (NSMutableArray *)modelCongifureWithJsonDic:(NSDictionary *)jsonDic
{
    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *arr = jsonDic[@"data"];
    for (NSDictionary *dic in arr) {
        CityModel *model = [[CityModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [array addObject:model];
    }
    return array;
}
@end
