//
//  CommunityCompanyModel.m
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CommunityCompanyModel.h"

@implementation CommunityCompanyModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
+ (NSMutableArray *)modelConfigerJsonDic:(NSDictionary *)JsonDic
{
    NSMutableArray *modelArray = [NSMutableArray array];
    NSArray *array = JsonDic[@"data"];
    for (NSDictionary *dic in array) {
        CommunityCompanyModel *model = [[CommunityCompanyModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [modelArray addObject:model];
    }
    return modelArray;
}
@end
