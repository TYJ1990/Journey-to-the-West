//
//  NextStationModel.m
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "NextStationModel.h"

@implementation NextStationModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
+ (NSMutableArray *)modelCongifureWithJsonDic:(NSDictionary *)jsonDic
{
    NSMutableArray *array = [NSMutableArray array];
    NSDictionary *dicc = jsonDic[@"data"];
    NSMutableArray *arr = dicc[@"subject"];
    for (NSDictionary *dic in arr) {
        NextStationModel *model = [[NextStationModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [array addObject:model];
    }
    return array;
}
@end
