//
//  Bmodel.m
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/8/6.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "Bmodel.h"


@implementation Bmodel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"entry_name":@"entry_name",
             @"notes":@"notes"};
}

+(NSValueTransformer *)notesJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[Cmodel class]];
}
@end
