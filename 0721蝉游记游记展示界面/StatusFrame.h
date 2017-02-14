//
//  StatusFrame.h
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/7/21.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Cmodel.h"

@interface StatusFrame : NSObject


@property (nonatomic,strong) Cmodel *cModel;


@property (nonatomic,assign,readonly) CGRect upLabelFrame;


@property (nonatomic,assign,readonly) CGRect topImageViewFrame;

@property (nonatomic,assign,readonly) CGRect showImageViewFrame;

@property (nonatomic,assign,readonly) CGRect describeLabelFrame;

@property (nonatomic,assign,readonly) CGRect buttonViewFrame;

@property (nonatomic,assign,readonly) CGFloat cellHeight;

@property (nonatomic,assign) CGFloat totalHeight;



@end
