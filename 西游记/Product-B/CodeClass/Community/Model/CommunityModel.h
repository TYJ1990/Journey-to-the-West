//
//  CommunityModel.h
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommunityModel : NSObject

// 字典counts中的问答和结伴
@property (nonatomic, strong)NSDictionary *counts;
@property (nonatomic, strong)NSNumber *ask; // 问答
@property (nonatomic, strong)NSNumber *company; // 结伴



// 数组forum_list
@property (nonatomic, strong)NSNumber *commID;
@property (nonatomic, strong)NSString *name; // 分区名称


// 数组group
@property (nonatomic, strong)NSMutableArray *group;
@property (nonatomic, strong)NSNumber *groupId; // 传下个界面的参数
@property (nonatomic, strong)NSString *groupName; // name
@property (nonatomic, strong)NSString *photo; // 图片
@property (nonatomic, strong)NSString *total_threads; // 多少帖子



//+ (NSMutableArray *)modelConfigerJsonDic:(NSDictionary*)jsonDic;



@end
