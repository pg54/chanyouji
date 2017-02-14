//
//  Bmodel.h
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/8/6.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle.h>
#import "Cmodel.h"

@interface Bmodel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *entry_name;
@property (nonatomic, strong) NSArray *notes;

@end
