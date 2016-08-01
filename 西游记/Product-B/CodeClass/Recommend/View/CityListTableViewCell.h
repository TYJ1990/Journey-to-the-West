//
//  CityListTableViewCell.h
//  Product-B
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CityModel;
@interface CityListTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *cityImg;
@property (strong, nonatomic) IBOutlet UILabel *areaNa;
@property (strong, nonatomic) IBOutlet UILabel *areaEN;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UIImageView *star1;
@property (strong, nonatomic) IBOutlet UIImageView *star2;
@property (strong, nonatomic) IBOutlet UIImageView *star3;
@property (strong, nonatomic) IBOutlet UIImageView *star4;
@property (strong, nonatomic) IBOutlet UIImageView *star5;
@property (strong, nonatomic) IBOutlet UILabel *people;
@property (strong, nonatomic) IBOutlet UILabel *intro;
@property (strong, nonatomic) IBOutlet UIImageView *tuijianImg;
@property (strong, nonatomic) IBOutlet UIView *imageLine;

@property (strong, nonatomic) IBOutlet UIView *lableLine;




- (void)cellConfigireWithModel:(CityModel *)model;
@end
