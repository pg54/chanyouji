//
//  TacticModel.h
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/8/4.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle.h>

@interface TacticModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *title;


@end
