//
//  searchListViewController.h
//  0707 蝉游记
//
//  Created by pangang on 15/7/18.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface searchListViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *actionView;

@property (nonatomic,strong) NSString *URLString;
@property (weak, nonatomic) IBOutlet UIButton *popularButton;

@property (weak, nonatomic) IBOutlet UIButton *seasonButton;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (nonatomic, strong) NSString *labelStr;

@end
