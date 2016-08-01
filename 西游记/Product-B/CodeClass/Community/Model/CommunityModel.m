//
//  CommunityModel.m
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CommunityModel.h"

@implementation CommunityModel
- (void)setValue:(id)value forKey:(NSString *)key
{

    if ([key isEqualToString:@"id"]) {
        value = self.groupId;
        
    }
    
    if ([key isEqualToString:@"name"]) {
        value = self.groupName;
    }
    
}


//+ (NSMutableArray *)modelConfigerJsonDic:(NSDictionary *)jsonDic
//{
//    NSMutableArray *array = [[NSMutableArray alloc] init];
//    NSDictionary *dataDic = jsonDic[@"data"];
//    NSArray *forumArray = dataDic[@"forum_list"];
//    NSMutableArray *group = [NSMutableArray arrayWithArray:forumArray];
//    for (NSDictionary *dic in group) {
//    NSMutableArray *modelArray = [[NSMutableArray alloc] init];
//         for (NSDictionary *dic1 in dic[@"group"] ) {
//            CommunityModel *model = [[CommunityModel alloc] init];
//            [model setValuesForKeysWithDictionary:dic1];
//            [modelArray addObject:model];
//        }
//        [array addObject:modelArray];
//    }
//    return array;
//    
//    
//}
//

@end
