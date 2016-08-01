//
//  LocalPlayerModel.h
//  Product-B
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface LocalPlayerModel : NSObject

#pragma mark --- collectionView
@property(nonatomic,strong)NSString *catename;
@property(nonatomic,strong)NSNumber *CollectID;
@property(nonatomic,strong)NSNumber *type;

#pragma mark ---tableview
@property(nonatomic,strong)NSNumber *tableID;
@property(nonatomic,strong)NSString *photo;
@property(nonatomic,strong)NSNumber *price;
@property(nonatomic,strong)NSString *sold;
@property(nonatomic,strong)NSString *title;





+(NSMutableArray *)CollectionModelConfigure:(NSDictionary *)jsonDic;

+(NSMutableArray *)TableModelConfigure:(NSDictionary *)jsonDic;


@end
