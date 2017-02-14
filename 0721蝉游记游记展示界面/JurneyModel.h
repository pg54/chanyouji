//
//  JurneyModel.h
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/8/6.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle.h>

@interface JurneyModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *descriptions;

@property (nonatomic, strong) NSNumber *ID;

@property (nonatomic, strong) NSString *image_url;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *plan_days_count;
@property (nonatomic, strong) NSNumber *plan_nodes_count;







@end
