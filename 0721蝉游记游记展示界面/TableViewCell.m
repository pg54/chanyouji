//
//  TableViewCell.m
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/7/21.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "TableViewCell.h"
#import "StatusFrame.h"
#import "Cmodel.h"
#import "UIImageView+WebCache.h"

#define FONT 12

@implementation TableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"describeCell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    //1 添加界面
    [self setupOriginalView];
    return self;
    
    
    
}
//添加游记界面展示控件
- (void)setupOriginalView
{
    //1.最外面的子控件 选一张浅色纯色图片
    UIImageView *topView = [[UIImageView alloc]init];
    
    [self.contentView addSubview:topView];
    _upLabel = [[UILabel alloc] init];
    _upLabel.font = [UIFont systemFontOfSize:20];
    _upLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_upLabel];
    
    //2.照片
    _showImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:_showImageView];
    //3文字
    _describeLabel = [[UILabel alloc]init];
    _describeLabel.font = [UIFont systemFontOfSize:FONT];
    [self.contentView addSubview:_describeLabel];
    //button
    _buttonView = [[UIImageView alloc]init];
    [self.contentView addSubview:_buttonView];
    UIButton *likeButton = [[UIButton alloc]initWithFrame:CGRectMake(255, 0, 50, 50)];
    UIButton *shareButton = [[UIButton alloc]initWithFrame:CGRectMake(315, 0, 50, 50)];
    //设置downLabel;
    _downLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150, 50)];
    _downLabel.font = [UIFont systemFontOfSize:12];
    _downLabel.textColor = [UIColor blueColor];
    
    
    [likeButton setImage:[UIImage imageNamed:@"UserHeaderButtonLikes@3x"] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed:@"UserHeaderButtonLikes@3x"] forState:UIControlStateNormal];
    [_buttonView addSubview:likeButton];
    [_buttonView addSubview:shareButton];
    [_buttonView addSubview:_downLabel];
    
    

}

//传递模型数据
- (void)setStatusFrame:(StatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    Cmodel *cModel = self.statusFrame.cModel;
    //设置地点标志
    self.upLabel.frame = statusFrame.upLabelFrame;
    self.upLabel.text = cModel.upName;
    
    self.showImageView.contentMode = UIViewContentModeScaleToFill;
    self.showImageView.frame = statusFrame.showImageViewFrame;
    self.describeLabel.frame = statusFrame.describeLabelFrame;
    //一定要设置默认零行
    self.describeLabel.numberOfLines =0;
    self.buttonView.frame = statusFrame.buttonViewFrame;
    self.topImageView.frame = statusFrame.topImageViewFrame;
    
    [self.showImageView sd_setImageWithURL:[NSURL URLWithString:cModel.photo.url]];
    NSLog(@"图片的地址%@",cModel.photo.url);
    self.describeLabel.text = cModel.descriptions;
    self.downLabel.text = cModel.downName;
     
    
    
}

- (void)dealloc
{
    

}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
