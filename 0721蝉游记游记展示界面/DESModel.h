//
//  DESModel.h
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/8/6.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle.h>

@interface DESModel : MTLModel<MTLJSONSerializing>


@property (nonatomic, strong) NSNumber *attraction_trips_count;
@property (nonatomic, strong) NSString *description_summary;
@property (nonatomic, strong) NSNumber *ID;

@property (nonatomic, strong) NSString *image_url;
@property (nonatomic, strong) NSString *name;

@property (nonatomic,strong) NSString *user_score;
@end
