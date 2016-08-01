//
//  RcmLabelCell.h
//  yiluxiangxi
//
//  Created by 唐僧 on 15/11/3.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscountSubjectModel.h"
@interface RcmLabelCell : UICollectionViewCell

@property(nonatomic,strong) UIImageView* recImageView;
@property(nonatomic,strong) UILabel* recTitlelabel;
@property(nonatomic,strong) UILabel* recDiscountLabel;
@property(nonatomic,strong) UILabel* recPriceLabel;
- (void)cellCongigureWithModel:(DiscountSubjectModel *)model;
@end
