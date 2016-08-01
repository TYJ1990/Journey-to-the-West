//
//  DestinationDetailModel.m
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "DestinationDetailModel.h"

@implementation DestinationDetailModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(NSMutableArray *)LunbotumodelConfigure:(NSDictionary *)jsdic
{
    NSMutableArray *arr = [NSMutableArray array];
    
    NSDictionary *dataDic = jsdic[@"data"];
    
    NSArray *photosarr = dataDic[@"photos"];
    
    arr = [photosarr mutableCopy];
    
    return arr;
    
}

+(DestinationDetailModel *)lunboshujuConfigure:(NSDictionary *)jsdic
{
    DestinationDetailModel *model = [[DestinationDetailModel alloc]init];
    
    NSDictionary *dataDic = jsdic[@"data"];
    
    [model setValuesForKeysWithDictionary:dataDic];

    return model;
}

+(NSMutableArray *)collectionModelConfigure:(NSDictionary *)jsonDic
{
    
    NSMutableArray *arr = [NSMutableArray array];
    
    NSDictionary *dataDic = jsonDic[@"data"];
    
    NSArray *hotArr = dataDic[@"hot_city"];
    
    for (NSDictionary *hotDic in hotArr) {
        
        DestinationDetailModel *model = [[DestinationDetailModel alloc]init];
        
        [model setValuesForKeysWithDictionary:hotDic];
        
        model.collectionID = hotDic[@"id"];
        
        [arr addObject:model];
        
    }
    
    return arr;
    
}

+(NSMutableArray *)tableModelConfigure:(NSDictionary *)jsonDic
{
    NSMutableArray *arr = [NSMutableArray array];
    
    NSDictionary *dataDic = jsonDic[@"data"];
    
    NSArray *new_discountArr = dataDic[@"new_discount"];
    
    for (NSDictionary *new_discountDic in new_discountArr) {
        DestinationDetailModel *model = [[DestinationDetailModel alloc]init];
        
        [model setValuesForKeysWithDictionary:new_discountDic];
        
        model.tableID = new_discountDic[@"id"];
        
        NSString *strPrice = new_discountDic[@"price"];
        
        NSString *search = @"(>)(\\w+)(<)";
        
        NSRange range = [strPrice rangeOfString:search options:NSRegularExpressionSearch];
        
        if (range.location != NSNotFound) {
            model.price = [strPrice substringWithRange:NSMakeRange(range.location + 1, range.length - 2)];
            
        }
        [arr addObject:model];
    }
    return arr;
}



@end
