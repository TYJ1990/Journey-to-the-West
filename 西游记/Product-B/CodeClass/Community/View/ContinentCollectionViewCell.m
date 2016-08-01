//
//  ContinentCollectionViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ContinentCollectionViewCell.h"

@implementation ContinentCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.photoImageV = [[UIImageView alloc] init];
        [self.contentView addSubview:self.photoImageV];
        self.nameL = [[UILabel alloc] init];
        [self.contentView addSubview:self.nameL];
        self.total_threadsL = [[UILabel alloc] init];
        [self.contentView addSubview:self.total_threadsL];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.photoImageV.frame = CGRectMake(0, 5, self.contentView.frame.size.width * 0.35 , self.contentView.frame.size.height * 0.6);
    self.nameL.frame = CGRectMake(self.contentView.frame.size.width * 0.4, 0,  self.contentView.frame.size.width * 0.4, 30);
    self.nameL.font = [UIFont systemFontOfSize:15];
    self.total_threadsL.frame = CGRectMake(self.contentView.frame.size.width * 0.4, self.contentView.frame.size.height * 0.4, 100, 30);
    self.total_threadsL.textColor = [UIColor grayColor];
    self.total_threadsL.font = [UIFont systemFontOfSize:13];
}

@end
