//
//  WordModel.m
//  Product-B
//
//  Created by lanou on 16/7/21.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "WordModel.h"

@implementation WordModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
+ (NSMutableArray *)modelCongifureWithJsonDic:(NSDictionary *)jsonDic
{
    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *arr = jsonDic[@"data"];
    for (NSDictionary *dic in arr) {
        WordModel *model = [[WordModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        model.countryID = [NSString stringWithFormat:@"%@",dic[@"id"]];
        [array addObject:model];
    }
    return array;
}
@end
