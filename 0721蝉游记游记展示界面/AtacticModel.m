//
//  AtacticModel.m
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/8/5.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "AtacticModel.h"
#import "TacticModel.h"

@implementation AtacticModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"category_type":@"category_type",
             @"tacticModel":@"pages"};
}

+ (NSValueTransformer *)tacticModelJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[TacticModel class]];
}

@end
