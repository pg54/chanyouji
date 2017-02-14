//
//  Cmodel.m
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/8/6.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "Cmodel.h"

@implementation Cmodel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"descriptions":@"description",
             @"photo":@"photo"};
}

+ (NSValueTransformer *)photoJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Photo class]];
}

@end
