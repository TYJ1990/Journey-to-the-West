//
//  IntercontinentalModel.m
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "IntercontinentalModel.h"

@implementation IntercontinentalModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
+ (NSMutableArray *)modelCongifureWithJsonDic:(NSDictionary *)jsonDic
{
    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *arr = jsonDic[@"data"];
    for (NSDictionary *dic in arr) {
        NSMutableArray *interArr = [NSMutableArray array];
        NSArray *countryArr = dic[@"guides"];
        for (NSDictionary *dicc in countryArr) {
            IntercontinentalModel *model = [[IntercontinentalModel alloc] init];
            [model setValuesForKeysWithDictionary:dicc];
            model.name = dic[@"name"];
            [interArr addObject:model];
        }
        
        [array addObject:interArr];
    }
    return array;
}
@end
