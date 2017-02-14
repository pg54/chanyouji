//
//  SiteModel.m
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/8/8.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "SiteModel.h"

@implementation SiteModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"country_name":@"country_name",
             @"currency_code":@"currency_code",
             @"current_time":@"current_time",
             @"temp_max":@"temp_max",
             @"temp_min":@"temp_min",};
}

@end
