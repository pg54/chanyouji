//
//  TableViewCell.h
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/7/21.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StatusFrame;
@interface TableViewCell : UITableViewCell

@property (nonatomic, strong) NSMutableArray *heightArray;


@property (nonatomic,strong) StatusFrame *statusFrame;

@property (nonatomic,strong) UIImageView *topImageView;

@property (nonatomic,strong) UIImageView *showImageView;

@property (nonatomic,strong) UILabel *describeLabel;

@property (nonatomic,strong) UIView *buttonView;

@property (nonatomic,strong) UIImageView *desImageView;

@property (nonatomic,strong) UILabel *desLabel;


@property (nonatomic,strong) UILabel *downLabel;

@property (nonatomic,strong) UILabel *upLabel;


@end
