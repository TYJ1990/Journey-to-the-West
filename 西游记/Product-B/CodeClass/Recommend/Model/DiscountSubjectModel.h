//
//  DiscountSubjectModel.h
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscountSubjectModel : NSObject
@property (nonatomic,strong) NSString *photo;
@property (nonatomic,strong) NSString *priceoff;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSNumber *myID;
+ (NSMutableArray *)modelCongifureWithJsonDic:(NSDictionary *)jsonDic;
@end
