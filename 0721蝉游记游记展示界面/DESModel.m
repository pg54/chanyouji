
//
//  DESModel.m
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/8/6.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "DESModel.h"


@implementation DESModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"attraction_trips_count":@"attraction_trips_count",
             @"description_summary":@"description_summary",
             @"ID":@"id",
             @"image_url":@"image_url",
             @"name":@"name",
             @"user_score":@"user_score"};
    

}




@end
