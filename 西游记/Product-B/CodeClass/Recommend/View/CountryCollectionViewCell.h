//
//  CountryCollectionViewCell.h
//  Product-B
//
//  Created by lanou on 16/7/21.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CountryModel;
@interface CountryCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *poto;
@property (strong, nonatomic) IBOutlet UILabel *countryC;
@property (strong, nonatomic) IBOutlet UILabel *cOUNTRYe;
@property (strong, nonatomic) IBOutlet UILabel *cityNumber;
- (void)cellConfigureWithModel:(CountryModel *)model;
@end
