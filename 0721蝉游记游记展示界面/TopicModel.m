//
//  TopicModel.m
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/8/3.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "TopicModel.h"

@implementation TopicModel


+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"destination_id":@"destination_id",
             @"ID":@"id",
             @"image_url":@"image_url",
             @"name":@"name",
             @"title":@"title",
             @"updated_at":@"updated_at"
             
             };
}

+ (NSDateFormatter *)dateFormatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    return dateFormatter;
}
//+ (NSValueTransformer *)URLJSONTransformer
//{
//return [NSValueTransformer valueTransformerForName:mtl]
//}
//+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key
//{
//    if (key isEqualToString:@"updated_at") {
//        return [NSValueTransformer ]
//    }
//}
//+ (Class)classForParsingJSONDictionary:(NSDictionary *)JSONDictionary
//{
//    if (JSONDictionary[@"body"] != nil) {
//        return   ;
//    }
//}
//+ (NSValueTransformer *)assigneeJSONTransformer
//{
//    return [MTLJSONAdapter dictionaryTransformerWithModelClass:];
//}
//+ (NSValueTransformer *)updateAtJSONTransformer
//{
//return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
//    return [self.dateFormatter dateFromString:dateString];
//} reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
//    return [self.dateFormatter stringFromDate:date];
//}];
//}
//- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error
//{
//    self = [super initWithDictionary:dictionaryValue error:error];
//    if (self == nil) {
//        return nil;
//    }
//    _updated_at = [NSDate date];
//    return self;
//}


@end
