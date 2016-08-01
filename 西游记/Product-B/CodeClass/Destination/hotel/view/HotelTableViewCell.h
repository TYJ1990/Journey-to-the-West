//
//  HotelTableViewCell.h
//  Product-B
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelTableViewCell : UITableViewCell
/*@property(nonatomic,strong)NSString *cnname;// 中文酒店名字
 @property(nonatomic,strong)NSString *enname;// 英文酒店名
 @property(nonatomic,strong)NSNumber *hotelID;// 酒店的ID
 @property(nonatomic,strong)NSNumber *ranking;// 评分
 @property(nonatomic,strong)NSString *star;// 星级别
 @property(nonatomic,strong)NSNumber *price;// 价格*/
@property(nonatomic,strong)UIImageView *imageV;
@property(nonatomic,strong)UILabel *cnnameL;
@property(nonatomic,strong)UILabel *rankingL;
@property(nonatomic,strong)UILabel *ennameL;
@property(nonatomic,strong)UILabel *starL;
@property(nonatomic,strong)UILabel *priceL;



@end
