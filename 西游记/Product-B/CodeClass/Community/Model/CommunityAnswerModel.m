//
//  CommunityAnswerModel.m
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CommunityAnswerModel.h"

@implementation CommunityAnswerModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)ke
{
    
}
+ (NSMutableArray *)modelConfigerJsonDic:(NSDictionary *)jsonDic
{
    NSMutableArray *modelArray = [NSMutableArray array];
    NSArray *dataArray = jsonDic[@"data"];
    for (NSDictionary *dic in dataArray) {
        CommunityAnswerModel *model = [[CommunityAnswerModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [modelArray addObject:model];
    }
    return modelArray;
}


@end
