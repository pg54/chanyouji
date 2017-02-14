//
//  Amodel.h
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/8/6.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle.h>
#import "Bmodel.h"


@interface Amodel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *day;

@property (nonatomic, strong) NSString *trip_date;

@property (nonatomic, strong) NSArray *nodes;

//@property (nonatomic, strong) NSMutableArray *sectionArray;

@end
