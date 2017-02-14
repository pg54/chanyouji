//
//  TopicModel.h
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/8/3.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle.h>



@interface TopicModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *destination_id;

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *image_url;
@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *updated_at;






@end
