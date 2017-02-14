//
//  PlanCell.h
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/7/31.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlanCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *fronImageView;
@property (weak, nonatomic) IBOutlet UILabel *chineseLabel;
@property (weak, nonatomic) IBOutlet UILabel *englishLabel;
@property (weak, nonatomic) IBOutlet UIButton *tacticButton;
@property (weak, nonatomic) IBOutlet UIButton *journeyButton;
@property (weak, nonatomic) IBOutlet UIButton *destinationButton;
@property (weak, nonatomic) IBOutlet UIButton *topicButton;

@end
