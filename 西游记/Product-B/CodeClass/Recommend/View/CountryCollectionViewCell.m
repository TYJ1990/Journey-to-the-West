//
//  CountryCollectionViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/21.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CountryCollectionViewCell.h"
#import "CountryModel.h"
@implementation CountryCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)cellConfigureWithModel:(CountryModel *)model {
    [self.poto sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:kPlacehodeImage completed:nil];
    self.countryC.text = model.cnname;
    self.cOUNTRYe.text = model.enname;
    if (model.poi_count == nil || [model.poi_count isEqualToString:@"0"]) {
        self.cityNumber.text = @"Ta还没有添加旅行地";
    }else{
        self.cityNumber.text = [NSString stringWithFormat:@"%@个去过的履行地",model.poi_count];
    }
}
@end
