//
//  CountryModel.m
//  Product-B
//
//  Created by lanou on 16/7/21.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CountryModel.h"

@implementation CountryModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
+ (NSMutableArray *)modelCongifureWithJsonDic:(NSDictionary *)jsonDic
{
    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *arr = jsonDic[@"data"];
    for (NSDictionary *dic in arr) {
        CountryModel *model = [[CountryModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        model.cityID = dic[@"id"];
        model.poi_count = [NSString stringWithFormat:@"%@",dic[@"poi_count"]];
        [array addObject:model];
    }
    return array;
}
@end
