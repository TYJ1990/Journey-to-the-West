//
//  ScenicModel.m
//  Product-B
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ScenicModel.h"

@implementation ScenicModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
// collectionV的数据解析
+(NSMutableArray *)collectionConfigureModel:(NSDictionary *)jsonDic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *dataDic = jsonDic[@"data"];
    NSArray *tagsArr = dataDic[@"tags"];
    for (NSDictionary *listDic in tagsArr) {
        ScenicModel *model = [[ScenicModel alloc]init];
        [model setValuesForKeysWithDictionary:listDic];
        [arr addObject:model];
    }
    return arr;
}

// tableV的数据解析
+(NSMutableArray *)tableVConfigureModel:(NSDictionary *)jsonDic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *dataDic = jsonDic[@"data"];
    NSArray *entryArr = dataDic[@"entry"];
    for (NSDictionary *dic in entryArr) {
        ScenicModel *model = [[ScenicModel alloc]init];
        model.tableVID = dic[@"id"];
        [model setValuesForKeysWithDictionary:dic];
        NSArray *discountsArr = dic[@"discounts"];
        model.discounts = [NSMutableArray array];
        for (NSDictionary *discountDic in discountsArr) {
            ScenicModel *model1 = [[ScenicModel alloc]init];
            [model1 setValuesForKeysWithDictionary:discountDic];
            model1.discountsID = discountDic[@"id"];
            
            
            NSString *strPrice = discountDic[@"price"];
            NSString *search = @"(>)(\\w+)(<)";
            NSRange range = [strPrice rangeOfString:search options:NSRegularExpressionSearch];
            if (range.location != NSNotFound) {
                model1.price = [strPrice substringWithRange:NSMakeRange(range.location + 1, range.length - 2)];
                [model.discounts addObject:model1];
        }
        }
        
        
        [arr addObject:model];
        
    }
    
    return arr;
}

@end
