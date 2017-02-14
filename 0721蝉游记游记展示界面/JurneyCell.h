//
//  JurneyCell.h
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/8/6.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JurneyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *frontImageView;
@property (weak, nonatomic) IBOutlet UILabel *describeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *destinCountLabel;
@end
