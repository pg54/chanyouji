//
//  CacheTool.h
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/7/28.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface CacheTool : NSObject


//+ (void)addTrips:(NSArray *)dictArray;
//添加缓存
+ (void)addTrip:(NSDictionary *)dict andID:(NSString *)idstr;
//读取缓存
//根据传来的值 输出对应的字典

+ (NSDictionary *)putoutwithID:(NSString *)idstr;



@end
