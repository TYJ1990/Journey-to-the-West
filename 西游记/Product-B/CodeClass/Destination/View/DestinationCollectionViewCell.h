//
//  DestinationCollectionViewCell.h
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DestinationCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageV;
@property (strong, nonatomic) IBOutlet UILabel *numberOfCity;
@property (strong, nonatomic) IBOutlet UILabel *cityL;
@property (strong, nonatomic) IBOutlet UILabel *countyL;
@property (strong, nonatomic) IBOutlet UILabel *countryEnglish;

@property (strong, nonatomic) IBOutlet UIView *backV;







@end
