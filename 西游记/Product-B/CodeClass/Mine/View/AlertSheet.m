//
//  AlertSheet.m
//  Product-A
//
//  Created by lanou on 16/7/1.
//  Copyright © 2016年 tongwei. All rights reserved.
//

#import "AlertSheet.h"

@implementation AlertSheet
- (IBAction)selectFromLibrary:(UIButton *)sender {
    if (_selectFromLibraryBlock) {
        _selectFromLibraryBlock();
    }
}
- (IBAction)takePhoto:(UIButton *)sender {
    if (_takePhotoBlock) {
        _takePhotoBlock();
    }
}

- (IBAction)cancel:(UIButton *)sender{
    if (_cancelBlock) {
        _cancelBlock();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
