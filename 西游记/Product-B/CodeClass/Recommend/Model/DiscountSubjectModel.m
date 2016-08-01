//
//  DiscountSubjectModel.m
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "DiscountSubjectModel.h"

@implementation DiscountSubjectModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
+ (NSMutableArray *)modelCongifureWithJsonDic:(NSDictionary *)jsonDic
{
    NSMutableArray *array = [NSMutableArray array];
    NSDictionary *dicc = jsonDic[@"data"];
    NSMutableArray *arr = dicc[@"discount"];
    for (NSDictionary *dic in arr) {
        DiscountSubjectModel *model = [[DiscountSubjectModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        NSString* strPrice = dic[@"price"];
        
        NSString* search = @"(>)(\\w+)(<)";
        NSRange range = [strPrice rangeOfString:search options:NSRegularExpressionSearch];
        if (range.location != NSNotFound) {
            model.price = [strPrice substringWithRange:NSMakeRange(range.location + 1, range.length - 2)];
        }
        model.myID = dic[@"id"];

        [array addObject:model];
    }
    return array;
}
@end
