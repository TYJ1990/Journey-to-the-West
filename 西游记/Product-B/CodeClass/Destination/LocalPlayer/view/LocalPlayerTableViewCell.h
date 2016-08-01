//
//  LocalPlayerTableViewCell.h
//  Product-B
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocalPlayerModel.h"
@interface LocalPlayerTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *imageV;
@property(nonatomic,strong)UILabel *titleL;
@property(nonatomic,strong)UILabel *soldL;
@property(nonatomic,strong)UILabel *priceL;


-(void)passValue:(LocalPlayerModel *)model;

@end
