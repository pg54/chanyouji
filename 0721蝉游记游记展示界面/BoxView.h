//
//  BoxView.h
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/8/15.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol jumpDelegate <NSObject>

- (void)jumpToListVC;

@end

@interface BoxView : UIView

@property (weak, nonatomic) IBOutlet UIButton *siteButton;
@property (weak, nonatomic) IBOutlet UILabel *lowTem;
@property (weak, nonatomic) IBOutlet UILabel *heightTem;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (nonatomic, copy) NSDictionary *dict;


@property (nonatomic, weak)id<jumpDelegate>delegate;

+ (instancetype)appear;
- (void)show;
@end
