//
//  CollectionViewCell.h
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/7/22.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *frontImageView;
@property (weak, nonatomic) IBOutlet UILabel *chineseLabel;
@property (weak, nonatomic) IBOutlet UILabel *englishLabel;
@property (weak, nonatomic) IBOutlet UIView *backgroudView;
@property (weak, nonatomic) IBOutlet UILabel *destinationCountLabel;

@end
