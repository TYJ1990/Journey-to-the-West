//
//  CityListTableViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CityListTableViewCell.h"
#import "CityModel.h"
@implementation CityListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
- (void)cellConfigireWithModel:(CityModel *)model {
    [self.cityImg sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:kPlacehodeImage completed:nil];
    self.areaNa.text = model.cnname;
    self.areaEN.text = model.enname;
    self.people.text = model.beenstr;

    
    if (model.discount.count != 0) {
         NSString* strPrice = model.discount[@"price"];
         NSString* search = @"(>)(\\w+)(<)";
    NSRange range = [strPrice rangeOfString:search options:NSRegularExpressionSearch];
    if (range.location != NSNotFound) {
        NSString *price = [strPrice substringWithRange:NSMakeRange(range.location + 1, range.length - 2)];
        self.price.text = [NSString stringWithFormat:@"%@元起",price];
       }
    }else{
        self.price.text = nil;
    }
    NSInteger judge = [model.has_mguide integerValue];
    if (judge == 1) {
        self.tuijianImg.hidden = NO;
    }else if(judge == 0){
        self.tuijianImg.hidden = YES;
    }
    NSArray *picArr = @[self.star1,self.star2,self.star3,self.star4,self.star5];
    NSInteger number = [model.ranking integerValue];
    NSInteger main = number%2;
    NSInteger b = number/2;
    for (NSInteger i = 0; i < b; i++) {
            UIImageView *imageV = picArr[i];
            imageV.image = [UIImage imageNamed:@"man"];
        }
    if (main != 0) {
        UIImageView *imageV = picArr[b];
        imageV.image = [UIImage imageNamed:@"ban"];
            }
}
@end
