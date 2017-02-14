//
//  BoxView.m
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/8/15.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "BoxView.h"
#import "SiteModel.h"
#import <Mantle.h>
#import "Netinterface.h"

@implementation BoxView
{
    NSString *URLString;
}

+ (instancetype)appear
{
    NSLog(@"获得nib");
    return [[[NSBundle mainBundle] loadNibNamed:@"BoxView" owner:nil options:nil] lastObject];
}

- (void)show
{
    NSString *siteName = _dict[@"country_name" ];
    [_siteButton setTitle:siteName forState:UIControlStateNormal];
    [_siteButton addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
    _lowTem.text = [NSString stringWithFormat:@"%@",_dict[@"temp_min"]];
    _heightTem.text = [NSString stringWithFormat:@"%@",_dict[@"temp_max"]];
    _time.text = _dict[@"current_time"];
    
    
    
}

- (void)jump
{
    if (_delegate && [_delegate respondsToSelector:@selector(jumpToListVC)]) {
        [_delegate jumpToListVC];
    }
    
}


- (IBAction)tranButton:(UIButton *)sender {
}
- (IBAction)chargeButton:(UIButton *)sender {
}
- (IBAction)mapButton:(UIButton *)sender {
}
- (IBAction)exchangeButton:(UIButton *)sender {
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end