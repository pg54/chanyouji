//
//  Photo.h
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/8/6.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle.h>

@interface Photo : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *image_height;

@property (nonatomic, strong) NSNumber *image_width;

@property (nonatomic, strong) NSString *url;

@end
