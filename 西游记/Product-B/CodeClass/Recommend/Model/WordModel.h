//
//  WordModel.h
//  Product-B
//
//  Created by lanou on 16/7/21.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WordModel : NSObject
@property (nonatomic,strong) NSString *cnname;
@property (nonatomic,strong) NSString *enname;
@property (nonatomic,strong) NSString *countryID;
@property (nonatomic,assign) BOOL isSelect;
+ (NSMutableArray *)modelCongifureWithJsonDic:(NSDictionary *)jsonDic;
@end
