//
//  CommunityDeltaLatestModel.m
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CommunityDeltaLatestModel.h"

@implementation CommunityDeltaLatestModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+ (NSMutableArray *)modelConfigerJsonDic:(NSDictionary *)jsonDic
{
    NSMutableArray *modelArray = [NSMutableArray array];
    NSDictionary *dataDic = jsonDic[@"data"];
    NSArray *array = dataDic[@"entry"];
    for (NSDictionary *dic in array) {
        CommunityDeltaLatestModel *model = [[CommunityDeltaLatestModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [modelArray addObject:model];
    }
    return modelArray;
}
@end
