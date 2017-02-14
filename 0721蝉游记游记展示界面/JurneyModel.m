//
//  JurneyModel.m
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/8/6.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "JurneyModel.h"

@implementation JurneyModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"descriptions":@"description",
             @"ID":@"id",
             @"image_url":@"image_url",
             @"name":@"name",
             @"plan_days_count":@"plan_days_count",
             @"plan_nodes_count":@"plan_nodes_count"};
}

@end
