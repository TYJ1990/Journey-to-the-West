//
//  DiscountModel.m
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "DiscountModel.h"

@implementation DiscountModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
+ (NSMutableArray *)modelCongifureWithJsonDic:(NSDictionary *)jsonDic
{
    NSMutableArray *array = [NSMutableArray array];
    NSDictionary *dicc = jsonDic[@"data"];
    NSMutableArray *arr = dicc[@"discount_subject"];
    for (NSDictionary *dic in arr) {
        DiscountModel *model = [[DiscountModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [array addObject:model];
    }
    return array;
}
@end
