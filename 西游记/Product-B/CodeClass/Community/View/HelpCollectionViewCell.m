//
//  HelpCollectionViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "HelpCollectionViewCell.h"

@implementation HelpCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.nameTitleL = [[UILabel alloc] init];
        [self.contentView addSubview:self.nameTitleL];
        self.countL = [[UILabel alloc] init];
        [self.contentView addSubview:self.countL];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.nameTitleL.frame = CGRectMake(self.contentView.frame.size.width * 0.05, self.contentView.frame.size.height * 0.15, self.contentView.frame.size.width * 0.3,30 );
    self.nameTitleL.textColor = [UIColor grayColor];
    self.countL.frame = CGRectMake(self.contentView.frame.size.width * 0.05, self.contentView.frame.size.height * 0.4, self.contentView.frame.size.width-5, 30);
    self.countL.textColor = [UIColor grayColor];
    self.countL.font = [UIFont systemFontOfSize:13];
}




@end
