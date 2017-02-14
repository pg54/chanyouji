//
//  HomeModel.h
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/7/21.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *startDate;
@property (nonatomic,strong) NSString *days;
@property (nonatomic,strong) NSString *photoCount;
@property (nonatomic,strong) NSString *image;
@property (nonatomic,strong) NSString *frontCoverPhotoUrl;
@property (nonatomic,strong) NSString *tripDescribeID;

@property (nonatomic,strong) NSString *likes_count;


@end
