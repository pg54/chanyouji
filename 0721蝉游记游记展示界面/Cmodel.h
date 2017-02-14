//
//  Cmodel.h
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/8/6.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle.h>
#import "Photo.h"

@interface Cmodel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *descriptions;

@property (nonatomic, strong) Photo *photo;

@property (nonatomic, strong) NSString *upName;

@property (nonatomic, strong) NSString *downName;



@end
