//
//  DestionationCityModel.m
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "DestionationCityModel.h"

@implementation DestionationCityModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(NSMutableArray *)lunbotuModelconfigure:(NSDictionary *)jsonDic // 轮播图的图片
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *dataDic = jsonDic[@"data"];
    NSArray *photosArr = dataDic[@"photos"];
    arr = [photosArr mutableCopy];
    
    return  arr;

}
+(DestionationCityModel *)lunbotuDataModelConfigure:(NSDictionary *)jsonDic//轮播图上面的数据解析
{
    DestionationCityModel *model = [[DestionationCityModel alloc]init];
    NSDictionary *dataDic = jsonDic[@"data"];
    [model setValuesForKeysWithDictionary:dataDic];

    return model;

}

+(NSMutableArray *)collectionModelConfigure:(NSDictionary *)jsonDic // 中间的collection的数据解析
{
    NSMutableArray *arr = [NSMutableArray array];
    
    NSDictionary *dataDic = jsonDic[@"data"];
    
    NSArray *local_discountArr = dataDic[@"local_discount"];
    
    for (NSDictionary *listDic in local_discountArr) {
        DestionationCityModel *model = [[DestionationCityModel alloc]init];
        [model setValuesForKeysWithDictionary:listDic];
        
        model.collectionID = listDic[@"id"];
        
        NSString *strPrice = listDic[@"price"];
        NSString *search = @"(>)(\\w+)(<)";
        NSRange range = [strPrice rangeOfString:search options:NSRegularExpressionSearch];
        if (range.location != NSNotFound) {
            
            model.price = [strPrice substringWithRange:NSMakeRange(range.location + 1, range.length - 2)];
    }
      [arr addObject:model];
}
     return arr;
    
}
+(NSMutableArray *)tableModelConfigure:(NSDictionary *)jsonDic
{
    NSMutableArray *arr = [NSMutableArray array];
    
    NSDictionary *dataDic = jsonDic[@"data"];
    
    NSArray *new_discount = dataDic[@"new_discount"];
    
    for (NSDictionary *listdic in new_discount) {
        DestionationCityModel *model = [[DestionationCityModel alloc]init];
        [model setValuesForKeysWithDictionary:listdic];
        
        model.tableID = listdic[@"id"];
        NSString *strPrice = listdic[@"price"];
        
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
