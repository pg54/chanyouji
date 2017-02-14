//
//  AtacticModel.h
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/8/5.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle.h>
@class TacticModel;

@interface AtacticModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,strong) NSNumber *category_type;

@property (nonatomic,strong) NSArray *tacticModel;

@end
