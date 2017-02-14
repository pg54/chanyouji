//
//  SiteModel.h
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/8/8.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle.h>
@interface SiteModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *country_name;

@property (nonatomic, strong) NSString *currency_code;

@property (nonatomic, strong) NSString *current_time;

@property (nonatomic, strong) NSNumber *temp_max;
@property (nonatomic, strong) NSNumber *temp_min;



@end
