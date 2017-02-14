//
//  Photo.m
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/8/6.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "Photo.h"


@implementation Photo

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{

    return @{@"image_height":@"image_height",
             @"image_width":@"image_width",
             @"url":@"url"};
    
}

@end
