//
//  searchViewController.h
//  0707 蝉游记
//
//  Created by pangang on 15/7/13.
//  Copyright (c) 2015年 pangang. All rights reserved.
//
#import "MJWheelButton.h"

@implementation MJWheelButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = 40;
    CGFloat imageH = 47;
    CGFloat imageX = (contentRect.size.width - imageW) * 0.5;
    CGFloat imageY = 20;
    return CGRectMake(imageX, imageY, imageW, imageH);
}



@end
