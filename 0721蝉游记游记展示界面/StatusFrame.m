//
//  StatusFrame.m
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/7/21.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "StatusFrame.h"
#import "describeTripViewController.h"
#import "Cmodel.h"
#import "Photo.h"

//cell的控件间距
#define BORDER 5
//文字的字体
#define FONT 12
#define UPHEIGHT 70



@implementation StatusFrame
{
    NSString *string;
    
}


- (void)setCModel:(Cmodel *)cModel
{
  //获得模型数据后，根据数据计算所有的子控件的frame
    _cModel = cModel;


    CGFloat cellW = [[UIScreen mainScreen] bounds].size.width;
    //大地点
    if (cModel.upName == nil) {
        _upLabelFrame = CGRectZero;
    }else
    {
        _upLabelFrame.size.height = UPHEIGHT;
        _upLabelFrame = CGRectMake(0, 0, 300, UPHEIGHT);
        string = cModel.upName;
        
    }
    
    //照片
    if (cModel.photo == nil) {
        _showImageViewFrame = CGRectZero;
        NSLog(@"此model没有图片");
    }else
    {
        int photoURLHeight = [cModel.photo.image_height intValue];
        int photoURLWidth = [cModel.photo.image_width intValue];
        float proportion = photoURLHeight/photoURLWidth;
        CGFloat width = cellW-2*BORDER;
        CGFloat height;
        if (0 < proportion < 0.58) {
            height = 200;
        }else if (0.58 < proportion < 0.79)
        {
            height = 350;
        }else if (proportion > 0.79)
        {
            height = 505;
        }
        CGSize showImageSize = CGSizeMake(width,height);
        _showImageViewFrame = (CGRect){{BORDER,BORDER+_upLabelFrame.size.height},showImageSize};
    
    }
    
    if (cModel.descriptions == nil) {
        _describeLabelFrame = CGRectZero;
    }else
    {
        CGFloat desX = BORDER;
        CGFloat desY = _showImageViewFrame.size.height+BORDER+_upLabelFrame.size.height;

        CGSize desSize = [cModel.descriptions sizeWithFont:[UIFont systemFontOfSize:FONT] constrainedToSize:CGSizeMake(cellW-2*BORDER, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        _describeLabelFrame = (CGRect){{desX,desY},desSize};
    
    }
    
    //button的
    _buttonViewFrame = (CGRect){{BORDER,3*BORDER+_upLabelFrame.size.height+_showImageViewFrame.size.height +_describeLabelFrame.size.height},CGSizeMake(cellW-2*BORDER, 60)};
    
    _cellHeight = 3*BORDER+_upLabelFrame.size.height+_showImageViewFrame.size.height +_describeLabelFrame.size.height+60;
    _totalHeight = _cellHeight;
    
    
    _topImageViewFrame = CGRectMake(0, 0, cellW, _cellHeight);
    
}


@end
