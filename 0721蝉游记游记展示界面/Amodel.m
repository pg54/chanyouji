//
//  Amodel.m
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/8/6.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "Amodel.h"


@implementation Amodel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"day":@"day",
             @"trip_date":@"trip_date",
             @"nodes":@"nodes"};
}

+ (NSValueTransformer *)nodesJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[Bmodel class]];
}

@end
